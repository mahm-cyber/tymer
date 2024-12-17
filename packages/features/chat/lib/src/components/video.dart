import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class Video extends StatelessWidget {
  const Video({
    super.key,
    required this.message,
    required this.userToken,
  });

  final ChatMessage message;
  final String userToken;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: VideoDialogContent(url: message.files![0].dlUrl!),
          alignment: Alignment.bottomCenter,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actionsPadding: const EdgeInsets.only(
            top: Spacing.large,
          ),
          actions: [
            // DownloadWidget(
            //   userToken: userToken,
            //   urls: [message.files![0].dlUrl!],
            // ),
            IconButton(
                onPressed: () => Navigator.pop(dialogContext),
                icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
      child: const Icon(Icons.video_camera_front_sharp),
    );
  }
}

class VideoDialogContent extends StatefulWidget {
  const VideoDialogContent({
    super.key,
    required this.url,
  });

  final String url;

  @override
  VideoDialogContentState createState() => VideoDialogContentState();
}

class VideoDialogContentState extends State<VideoDialogContent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                }
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: !_controller.value.isPlaying
                          ? IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.play();
                                });
                              },
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const CenteredCircularProgressIndicator();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
