import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
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
        final isImagePicked = state.file.value != null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final imageUrl = state.service?.responseDetails?.imageUrl;
        final imageError = state.file.isNotValid ? state.file.error : null;
        final hasPickedImage = state.file.value != null && state.file.isValid;
        final isStatusPendingReview =
            state.service?.status == ServiceStatus.pendingReview;
        return StreamBuilder<String>(
          stream: cubit.imageFileNameSC.stream,
          builder: (context, snapshot) {
            final controller = TextEditingController(
              text: state.service?.responseDetails?.imageUrl?.split('/').last,
            );
            if (snapshot.hasData) controller.text = snapshot.data ?? '';
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            enabled: !isSubmissionInProgress,
                            controller: controller,
                            readOnly: true,
                            style: TextStyle(
                              color: Colors.grey.withAlpha((255 * 0.7).toInt()),
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.camera_alt_outlined,
                                color: hasPickedImage && !isStatusPendingReview
                                    ? Colors.transparent
                                    : null,
                              ),
                              labelText: l10n.imageTextFieldLabel,
                              errorText: imageError ==
                                      FileSizeValidationError.exceedsSizeLimit
                                  ? l10n
                                      .imageSizeExceedsLimitErrorTextFieldMessage
                                  : null,
                            ),
                          ),
                        ),
                        if (hasPickedImage && !isStatusPendingReview)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: cubit.deletePickedImage,
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (isImagePicked || imageUrl != null) ...[
                  const SizedBox(
                    width: Spacing.small,
                  ),
                  GestureDetector(
                    onTap: () => showImageDialog(
                      context,
                      imageBytes: state.file.value?.readAsBytesSync(),
                      imageUrl: imageUrl,
                      userToken: state.userToken,
                      onBackButtonPressed: cubit.onBackButtonPressed,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 6.5,
                      // Equivalent to the radius of the CircleAvatar
                      height: MediaQuery.of(context).size.width / 6.5,
                      // Equal width and height to make it circular
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.secondaryColor, // Background color
                      ),
                      child: ClipOval(
                        child: isImagePicked
                            ? Image.memory(
                                gaplessPlayback: true,
                                state.file.value!.readAsBytesSync(),
                                fit: BoxFit.cover,
                                // Ensures the image covers the container
                                width: MediaQuery.of(context).size.width / 6.5,
                                // Image size matches the container
                                height: MediaQuery.of(context).size.width /
                                    6.5, // Image size matches the container
                              )
                            : Image.network(
                                imageUrl!,
                                headers: {
                                  "Authorization": "Bearer ${state.userToken}",
                                  "X-API-Key":
                                      const String.fromEnvironment('x-api-key'),
                                },
                                fit: BoxFit.cover,
                                // Ensures the image covers the container
                                width: MediaQuery.of(context).size.width / 6.5,
                                // Image size matches the container
                                height: MediaQuery.of(context).size.width /
                                    6.5, // Image size matches the container
                              ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        );
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
  String? userToken,
  required VoidCallback onBackButtonPressed,
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
          userToken: userToken!,
          onBackButtonPressed: onBackButtonPressed);
    }),
  );
}

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    super.key,
    this.imageUrl,
    this.imageBytes,
    required this.userToken,
    required this.onBackButtonPressed,
  });

  final String? imageUrl;
  final Uint8List? imageBytes;
  final String userToken;
  final VoidCallback onBackButtonPressed;

  @override
  State<ImageDialog> createState() => _State();
}

class _State extends State<ImageDialog> {
  int quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return BackButtonListener(
      onBackButtonPressed: () async {
        widget.onBackButtonPressed();
        return true;
      },
      child: Align(
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
                        ? Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.fill,
                            headers: {
                              "Authorization": "Bearer ${widget.userToken}",
                              "X-API-Key":
                                  const String.fromEnvironment('x-api-key'),
                            },
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
      ),
    );
  }
}
