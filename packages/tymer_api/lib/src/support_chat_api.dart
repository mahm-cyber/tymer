import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:tymer_api/tymer_api.dart';

class SupportChatApi {
  static const _errorJsonKey = 'error';
  static const _idJsonKey = 'id';
  static const _codeJsonKey = 'code';
  final Dio _dio;
  final UrlBuilder _urlBuilder;

  SupportChatApi(
    this._dio,
    this._urlBuilder,
  );

  Future<int?> checkIfUserHasSupportChat() async {
    final url = _urlBuilder.buildCheckIfUserHasSupportChatUrl();
    try {
      final response = await _dio.get(url);
      return response.data[_idJsonKey] as int?;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> createSupportChat() async {
    final url = _urlBuilder.buildCreateSupportChatUrl();
    try {
      final response = await _dio.post(url);
      return response.data[_idJsonKey] as int;
    } catch (error) {
      rethrow;
    }
  }

  Future<ChatRM> getSupportChat({required int supportChatId}) async {
    final url = _urlBuilder.buildGetSupportChatUrl(supportChatId);
    try {
      final response = await _dio.get(url);
      final supportChat = ChatRM.fromJson(response.data);
      return supportChat;
    } catch (error) {
      rethrow;
    }
  }

  Future sendSupportChatMessage({
    required int supportChatId,
    String? message,
    List<File?>? documentFiles,
    List<File?>? imageFiles,
    List<File?>? audioFiles,
  }) async {
    final url = _urlBuilder.buildSendSupportChatMessageUrl(supportChatId);
    List<MultipartFile> documentMultipartFiles = [];
    List<MultipartFile> imageMultipartFiles = [];
    List<MultipartFile> audioMultipartFiles = [];

    if (documentFiles != null) {
      for (final documentFile in documentFiles) {
        if (documentFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            documentFile.path,
            filename: documentFile.path.split('/').last,
          );
          documentMultipartFiles.add(multipartFile);
        }
      }
    }

    if (imageFiles != null) {
      for (final imageFile in imageFiles) {
        if (imageFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          );
          imageMultipartFiles.add(multipartFile);
        }
      }
    }

    if (audioFiles != null) {
      for (final audioFile in audioFiles) {
        if (audioFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            audioFile.path,
            filename: audioFile.path.split('/').last,
          );
          audioMultipartFiles.add(multipartFile);
        }
      }
    }

    final requestJsonBody = {
      if (imageFiles != null)
        for (var i = 0; i < imageMultipartFiles.length; i++)
          'chat_images[]': imageMultipartFiles[i],
      if (documentFiles != null)
        for (var i = 0; i < documentMultipartFiles.length; i++)
          'chat_documents[]': documentMultipartFiles[i],
      if (audioFiles != null)
        for (var i = 0; i < audioMultipartFiles.length; i++)
          'chat_records[]': audioMultipartFiles[i],
      'content': message,
    };

    final formData =
        FormData.fromMap(requestJsonBody, ListFormat.multiCompatible);

    try {
      await _dio.post(url, data: formData);
    } on DioException catch (error) {
      if (error.response?.statusCode == 403) {
        final chatLimitReached = error.response?.data[_errorJsonKey]
                [_codeJsonKey] ==
            'MESSAGE_SENDING_LIMIT_EXCEEDED';
        if (chatLimitReached) {
          throw ChatLimitReachedTymerException();
        }
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
