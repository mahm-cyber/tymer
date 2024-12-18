

import 'package:chat/src/components/image_widget.dart';
import 'package:chat/src/components/video.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class MessageFileWidget extends StatelessWidget {
  const MessageFileWidget({
    super.key,
    required this.message,
    required this.openFileInExternalApp,
    required this.userToken,

  });

  final DisputeMessage message;
  final Function(String p1) openFileInExternalApp;
  final String userToken;



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (message.files![0].type == FileType.image)
          ImageWidget(
            message: message,
            userToken: userToken,
          ),
        if (message.files![0].type == FileType.other ||
            message.files![0].type == FileType.unknown)
          DownloadWidget(
            userToken: userToken,
            urls: [message.files![0].dlUrl!],
            isSentByMe : message.isSentByMe,
            child: Icon(
              Icons.insert_drive_file,
              color: message.isSentByMe ? null : Colors.white,
            ),
          ),
        if (message.files![0].type == FileType.video)
          Video(
            userToken: userToken,
            message: message,
          ),
        VerticalGap.xSmall(),
        SizedBox(
          width: 100,
          child: Text(
            message.files![0].name,
            style: textTheme.bodySmall?.copyWith(
                color: message.isSentByMe ? null : Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          message.files![0].extension.toUpperCase(),
          style: textTheme.bodySmall?.copyWith(
              color: message.isSentByMe ? null : Colors.white),
        ),
      ],
    );
  }
}
