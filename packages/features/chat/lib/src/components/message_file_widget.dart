import 'package:chat/src/components/image_widget.dart';
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
    final isSentByMe = message.isSentByMe;
    final extension = message.files![0].extension;
    final cleanExtension = extension.length > 4
        ? extension.substring(0, 4).toUpperCase()
        : extension.toUpperCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (message.files![0].type == FileType.image)
          ImageWidget(
            message: message,
            userToken: userToken,
          ),
        if (message.files![0].type != FileType.image)
          DownloadWidget(
            userToken: userToken,
            urls: [message.files![0].dlUrl!],
            isSentByMe: message.isSentByMe,
            child: Stack(
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  size: 35,
                  color: isSentByMe ? null : Colors.white,
                ),
                 PositionedDirectional(
                  end: 0,
                  bottom: 0,
                  top: 0  ,
                  start: 0,
                  child: Icon(
                    Icons.download,
                    size: 20,
                    color: isSentByMe ? null : Colors.white,

                  ),
                )
              ],
            ),
          ),
        // if (message.files![0].type == FileType.video)
        //   Video(
        //     userToken: userToken,
        //     message: message,
        //   ),
        VerticalGap.xSmall(),
        // SizedBox(
        //   width: 100,
        //   child: Text(
        //     message.files![0].name,
        //     style: textTheme.bodySmall
        //         ?.copyWith(color: message.isSentByMe ? null : Colors.white),
        //     overflow: TextOverflow.ellipsis,
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        Text(
          cleanExtension,
          style: textTheme.bodySmall
              ?.copyWith(color: message.isSentByMe ? null : Colors.white),
        ),
      ],
    );
  }
}
