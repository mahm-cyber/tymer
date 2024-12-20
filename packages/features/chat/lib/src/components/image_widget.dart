import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    super.key,
    required this.message,
    required this.userToken,
  });

  final DisputeMessage message;
  final String userToken;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final isSvg = widget.message.files![0].extension == 'svg';
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: InteractiveViewer(
            child: isSvg
                ? SvgPicture.network(
                    widget.message.files![0].dlUrl!,
                    fit: BoxFit.fitHeight,
                    headers: {
                      "Authorization": "Bearer ${widget.userToken}",
                      "X-API-Key": const String.fromEnvironment('x-api-key'),
                    },
                  )
                : Image.network(
                    widget.message.files![0].dlUrl!,
                    fit: BoxFit.fitHeight,
                    headers: {
                      "Authorization": "Bearer ${widget.userToken}",
                      "X-API-Key": const String.fromEnvironment('x-api-key'),
                    },
                  ),
          ),
          alignment: Alignment.bottomCenter,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: EdgeInsetsDirectional.only(
              top: Spacing.large, start: theme.screenMargin),
          actions: [
            DownloadWidget(
              userToken: widget.userToken,
              isSentByMe: true,
              urls: [widget.message.files![0].dlUrl!],
            ),
            // CircularProgressIndicator(),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
      child: isSvg
          ? SvgPicture.network(
              widget.message.files![0].dlUrl!,
              fit: BoxFit.fitHeight,
              headers: {
                "Authorization": "Bearer ${widget.userToken}",
                "X-API-Key": const String.fromEnvironment('x-api-key'),
              },
            )
          : Image.network(
              widget.message.files![0].dlUrl!,
              fit: BoxFit.fitHeight,
              height: 100,
              headers: {
                "Authorization": "Bearer ${widget.userToken}",
                "X-API-Key": const String.fromEnvironment('x-api-key'),
              },
            ),
    );
  }
}
