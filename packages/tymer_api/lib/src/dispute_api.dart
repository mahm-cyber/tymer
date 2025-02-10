import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:tymer_api/tymer_api.dart';

class DisputeApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _idJsonKey = 'id';
  static const _codeJsonKey = 'code';

  final Dio _dio;
  final UrlBuilder _urlBuilder;

  DisputeApi(
    this._dio,
    this._urlBuilder,
  );

  Future<DisputeRM> getDispute(
      {required int disputeId, required String userType}) async {
    final url = _urlBuilder.buildGetDisputeUrl(
        disputeId: disputeId, userType: userType);
    try {
      final response = await _dio.get(url);
      final dispute = DisputeRM.fromJson(response.data[_dataJsonKey]);
      return dispute;
    } catch (_) {
      rethrow;
    }
  }

  Future<int> disputeRequest(
      {required int serviceRequestId, required String reason}) async {
    final url =
        _urlBuilder.buildDisputeRequestUrl(serviceRequestId: serviceRequestId);
    try {
      final response = await _dio.post(url, data: {'other_details': reason});
      final disputeId = response.data[_dataJsonKey][_idJsonKey] as int;
      return disputeId;
    } catch (_) {
      rethrow;
    }
  }

  Future<DisputeListPageRM> getAllDisputes({
    required int page,
    required String userType,
    String? status,
  }) async {
    final url = _urlBuilder.buildGetAllDisputesUrl(
      page: page,
      userType: userType,
      status: status,
    );
    try {
      final response = await _dio.get(url);
      final disputes = DisputeListPageRM.fromJson(response.data);
      final currentPage = response.data['meta']['current_page'] as int;
      final lastPage = response.data['meta']['last_page'] as int;
      final isLastPage = currentPage >= lastPage;
      disputes.isLastPage = isLastPage;
      return disputes;
    } catch (_) {
      rethrow;
    }
  }

  Future<ChatRM> getDisputeChat(
      {required int disputeId, required String userType}) async {
    final url = _urlBuilder.buildGetDisputeChatUrl(
        disputeId: disputeId, userType: userType);
    try {
      final response = await _dio.get(url);
      final disputeChat = ChatRM.fromJson(response.data);
      return disputeChat;
    } catch (_) {
      rethrow;
    }
  }

  Future sendDisputeChatMessage({
    required int disputeId,
    required String userType,
    String? message,
    List<File?>? documentFiles,
    List<File?>? imageFiles,
    List<File?>? audioFiles,
  }) async {
    final url = _urlBuilder.buildSendDisputeChatMessageUrl(
        disputeId: disputeId, userType: userType);
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
    } catch (_) {
      rethrow;
    }
  }
}
