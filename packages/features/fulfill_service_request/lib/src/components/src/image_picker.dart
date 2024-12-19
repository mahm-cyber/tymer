import 'package:component_library/component_library.dart';
import 'package:flutter/foundation.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerTextField extends StatelessWidget {
  const ImagePickerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      builder: (context, state) {
        final l10n = FulfillServiceRequestLocalizations.of(context);
        final cubit = context.read<FulfillServiceRequestCubit>();
        final theme = TymerTheme.of(context);
        final isImagePicked = state.imageBytes != null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        return StreamBuilder<String>(
            stream: cubit.carImageFileNameSC.stream,
            builder: (context, snapshot) {
              final controller = TextEditingController(
                text: state.service?.response?.imageUrl?.split('/').last,
              );
              if (snapshot.hasData) controller.text = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: isImagePicked
                          ? MediaQuery.of(context).size.width / 1.35
                          : MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: isSubmissionInProgress
                                ? null
                                : () {
                                    cubit.onImagePickerTapped();
                                  },
                            child: Container(
                              color: Colors.transparent,
                              height: 50,
                              width: double.infinity,
                            ),
                          ),
                          IgnorePointer(
                            child: TextField(
                              controller: controller,
                              readOnly: true,
                              decoration: InputDecoration(
                                suffixIcon:
                                    const Icon(Icons.camera_alt_outlined),
                                labelText: l10n.imageTextFieldLabel,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (isImagePicked) ...[
                    const SizedBox(
                      width: Spacing.small,
                    ),
                    GestureDetector(
                      onTap: () => showImageDialog(
                        context,
                        imageBytes: state.imageBytes,
                      ),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 13,
                        backgroundColor: theme.secondaryColor,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 13 - 1,
                          backgroundColor: Colors.black,
                          foregroundImage: MemoryImage(state.imageBytes!),
                        ),
                      ),
                    ),
                  ]
                ],
              );
            });
      },
    );
  }
}

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({
    super.key,
    required this.onTapGallery,
    required this.onTapCamera,
    required this.galleryIcon,
    required this.cameraIcon,
    required this.galleryText,
    required this.cameraText,
  });

  final VoidCallback onTapGallery;
  final VoidCallback onTapCamera;
  final IconData galleryIcon;
  final IconData cameraIcon;
  final String galleryText;
  final String cameraText;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return SizedBox(
      height: 80,
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onTapGallery,
            icon: Icon(
              galleryIcon,
              color: theme.secondaryColor,
              size: 35,
            ),
          ),
          HorizontalGap.xLarge(),
          IconButton(
            onPressed: onTapCamera,
            icon: Icon(
              cameraIcon,
              color: theme.secondaryColor,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

void showImageDialog(
  BuildContext context, {
  String? imageUrl,
  Uint8List? imageBytes,
}) {
  if (imageUrl == null && imageBytes == null) {
    throw Exception('either imageUrl or imageBytes should be provided');
  }
  showDialog(
    context: context,
    builder: ((_) {
      return ImageDialog(
        imageUrl: imageUrl,
        imageBytes: imageBytes,
      );
    }),
  );
}

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    super.key,
    this.imageUrl,
    this.imageBytes,
  });

  final String? imageUrl;
  final Uint8List? imageBytes;

  @override
  State<ImageDialog> createState() => _State();
}

class _State extends State<ImageDialog> {
  int quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);

    return Align(
      alignment: Alignment.center,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white.withAlpha((255 * 0.0).toInt()),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        content: Stack(
          children: [
            InteractiveViewer(
              child: RotatedBox(
                quarterTurns: quarterTurns,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: widget.imageUrl != null
                      ? FadeInImage.assetNetwork(
                          placeholderFit: BoxFit.fill,
                          placeholder: 'assets/images/logo.png',
                          image: widget.imageUrl!,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(widget.imageBytes!),
                ),
              ),
            ),
            Positioned(
              top: Spacing.small,
              right: Spacing.small,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: theme.errorColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: Spacing.small,
              right: Spacing.small,
              child: InkWell(
                onTap: () {
                  setState(() {
                    quarterTurns++;
                    // print('rotated');
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.rotate_right,
                    size: 30,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
