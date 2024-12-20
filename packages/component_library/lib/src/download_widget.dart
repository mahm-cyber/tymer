import 'dart:developer';
import 'dart:io';
import 'package:component_library/component_library.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({
    super.key,
    required this.urls,
    this.child,
    this.padding,
    required this.userToken,
    this.isSentByMe,
  });

  final List<String> urls;
  final Widget? child;
  final EdgeInsetsDirectional? padding;
  final String userToken;

  final bool? isSentByMe;

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  final dio = Dio();
  final ValueNotifier<double> downloadProgress = ValueNotifier(0.0);
  final ValueNotifier<DownloadStatus> downloadStatus =
      ValueNotifier(DownloadStatus.initial);
  bool fileAlreadyOnDevice = (false);
  String? savePath;

  @override
  //init
  void initState() {
    super.initState();
    downloadStatus.addListener(() {
      final l10n = ComponentLibraryLocalizations.of(context);
      final theme = TymerTheme.of(context);
      if (downloadStatus.value == DownloadStatus.success) {
        showSnackBar(
          context: context,
          snackBar: SuccessSnackBar(
            context: context,
            snackBarAction: SnackBarAction(
              backgroundColor: theme.primaryColor,
              label: (l10n.openFileSnackBarActionLabel),
              onPressed: () {
                OpenFilex.open(savePath!);
              },
            ),
            message: (l10n.downloadSuccessSnackBarMessage),
          ),
        );
      }
      if (downloadStatus.value == DownloadStatus.failed) {
        showSnackBar(
          context: context,
          snackBar: ErrorSnackBar(
            context: context,
            message: (l10n.downloadFailedSnackBarMessage),
          ),
        );
      }
    });
    getApplicationDocumentsDirectory().then((downloadDirPath) {
      final fileName = widget.urls[0].split('/').last;
      savePath = '${downloadDirPath.path}/$fileName';
      setState(() {});
      checkIfFileAlreadyOnDevice();
    });
  }

  void checkIfFileAlreadyOnDevice() async {
    final file = File(savePath!);
    if (await file.exists()) {
      fileAlreadyOnDevice = true;
      setState(() {});
    }
  }

  /// [downloadFile] method is used to download the enqueue the file to be downloaded using the [url].
  Future<void> downloadFile({required String url}) async {
    if (savePath == null) return;
    try {
      downloadStatus.value = DownloadStatus.inProgress;
      setState(() {});
      await dio.downloadUri(
        Uri.parse(url),
        options: Options(
          headers: {
            "Authorization": "Bearer ${widget.userToken}",
            "X-API-Key": const String.fromEnvironment('x-api-key'),
          },
        ),
        savePath,
        onReceiveProgress: (received, total) {
          final progress = received / total;
          downloadProgress.value = progress;
          setState(() {});
        },
      );
      downloadStatus.value = DownloadStatus.success;
      downloadProgress.value = 0.0;
      setState(() {});
    } catch (e) {
      log('Error downloading file: $e');
      downloadStatus.value = DownloadStatus.failed;
      setState(() {});
      downloadStatus.value = DownloadStatus.initial;
    }
  }

  @override
  void dispose() {
    downloadProgress.dispose();
    downloadStatus.dispose();
    if (fileAlreadyOnDevice) File(savePath!).delete();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSentByMe = widget.isSentByMe ?? false;
    final downloadInProgress =
        downloadStatus.value == DownloadStatus.inProgress;
    final downloadSuccessOrAlreadyOnDevice =
        downloadStatus.value == DownloadStatus.success || fileAlreadyOnDevice;
    return GestureDetector(
      onTap: () {
        for (String url in widget.urls) {
          downloadFile(url: url);
        }
      },
      child: downloadInProgress
          ? Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                value: downloadProgress.value,
                color: isSentByMe ? null : Colors.white,
              ),
            )
          : downloadSuccessOrAlreadyOnDevice
              ? IconButton(
                  onPressed: () async {
                    OpenFilex.open(savePath!);
                  },
                  icon: Icon(
                    Icons.open_in_new,
                    color: isSentByMe ? null : Colors.white,
                  ),
                )
              : widget.child ?? const Icon(Icons.download),
    );
  }
}

enum DownloadStatus {
  initial,
  inProgress,
  failed,
  success,
}
