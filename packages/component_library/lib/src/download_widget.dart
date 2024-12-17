import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  final ReceivePort _port = ReceivePort();

  /// [downloadTaskId] variable is used to store the id of the download task created when the [FlutterDownloader.enqueue] method is called.
  String? downloadTaskId;

  /// [downloadTaskStatus] is used to store the task status.
  int downloadTaskStatus = 0;

  /// [downloadTaskProgress] store the progress of the download task. ranging between 1 to 100.
  int downloadTaskProgress = 0;

  /// [isDownloading] is set to true if the file is being downloaded.
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _port.listen((message) {
      setState(
        () {
          downloadTaskId = message[0];
          downloadTaskStatus = message[1];
          downloadTaskProgress = message[2];
        },
      );

      if (message[1] == 2) {
        isDownloading = true;
      } else {
        isDownloading = false;
      }
      setState(() {});
    });
  }

  /// [downloadFile] method is used to download the enqueue the file to be downloaded using the [url].
  Future<void> downloadFile({required String url}) async {
    log('DownloadsController - downloadFile called');
    log('DownloadsController - downloadFile - url = $url');

    /// [downloadDirPath] var stores the path of device's download directory path.
    late String downloadDirPath;
    if (Platform.isIOS) {
      downloadDirPath = (await getApplicationDocumentsDirectory()).path;
    } else {
      downloadDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    downloadTaskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {
        "Authorization": "Bearer ${widget.userToken}",
        "X-API-Key": "01f64a264be7442a9008abda93d5d6ae",
      },
      // optional: header send with url (auth token etc)
      savedDir: downloadDirPath,
      saveInPublicStorage: true,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on the notification to open the downloaded file (for Android)
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final isSentByMe = widget.isSentByMe ?? false;
    return GestureDetector(
      onTap: () {
        for (String url in widget.urls) {
          downloadFile(url: url);
        }
      },
      child: true
          ? Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                color: isSentByMe ? null : Colors.white,
                backgroundColor: theme.primaryColor.withOpacity(0.2),
              ),
            )
          : widget.child ?? const Icon(Icons.download),
    );
  }
}
