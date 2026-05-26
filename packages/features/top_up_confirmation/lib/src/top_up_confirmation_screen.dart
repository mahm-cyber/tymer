import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:top_up_confirmation/src/components/telda_username_text_field.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';
import 'package:top_up_confirmation/top_up_confirmation.dart';
import 'package:domain_models/domain_models.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

import 'package:form_fields/form_fields.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'components/amount_text_field.dart';
import 'components/wallet_number_text_field.dart';
import 'components/instant_payment_address_text_field.dart';

class TopUpConfirmationScreen extends StatelessWidget {
  const TopUpConfirmationScreen({
    required this.userRepository,
    required this.walletRepository,
    required this.onBackButtonPressed,
    required this.onSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onBackButtonPressed;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopUpConfirmationCubit>(
      create: (_) => TopUpConfirmationCubit(
        userRepository: userRepository,
        walletRepository: walletRepository,
        onBackButtonPressed: onBackButtonPressed,
        onSuccess: onSuccess,
      ),
      child: const TopUpConfirmationView(),
    );
  }
}

class TopUpConfirmationView extends StatelessWidget {
  const TopUpConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cl10n = ComponentLibraryLocalizations.of(context);
    final l10n = TopUpConfirmationLocalizations.of(context);
    final theme = TymerTheme.of(context);

    return BlocConsumer<TopUpConfirmationCubit, TopUpConfirmationState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus ||
          previous.isImagePickerBottomSheetVisible !=
              current.isImagePickerBottomSheetVisible,
      listener: (context, state) {
        final cubit = context.read<TopUpConfirmationCubit>();
        final cl10n = ComponentLibraryLocalizations.of(context);
        if (state.isImagePickerBottomSheetVisible == true) {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return BackButtonListener(
                onBackButtonPressed: () async {
                  cubit.onBackButtonPressed();
                  return true;
                },
                child: ImagePickerBottomSheet(
                  galleryIcon: Icons.collections,
                  cameraIcon: Icons.camera_alt,
                  galleryText: cl10n.bottomSheetGalleryButton,
                  cameraText: cl10n.bottomSheetCaptureButton,
                  onTapGallery: () {
                    Navigator.pop(context);
                    cubit.pickImageFromGallery();
                  },
                  onTapCamera: () {
                    Navigator.pop(context);
                    cubit.capturePhoto();
                  },
                ),
              );
            },
          ).whenComplete(() {
            cubit.onImagePickerBottomSheetClosed();
          });
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          cubit.onSuccess();
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          final errorMessage = state.error is PaymobTopUpFailedException
              ? (state.error as PaymobTopUpFailedException).message
              : null;
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              marginalSpace: theme.snackBarMargin,
              message: errorMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final pickedMethod = state.paymentMethods?.pickedPaymentMethodType;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<TopUpConfirmationCubit>();
        final isCardPaymentInProgress =
            state.bankCardPaymentStatus == BankCardPaymentStatus.inProgress;
        final isCardPaymentPageLoaded = state.bankCardPaymentStatus ==
            BankCardPaymentStatus.paymentPageLoaded;
        final isEWallet = [
          PaymentMethodType.vodafoneCash,
          PaymentMethodType.orangeCash,
          PaymentMethodType.etisalatCash,
        ].contains(state.paymentMethods?.pickedPaymentMethodType);
        final isTelda = state.paymentMethods?.pickedPaymentMethodType ==
            PaymentMethodType.telda;
        final isInstaPay = state.paymentMethods?.pickedPaymentMethodType ==
            PaymentMethodType.instaPay;

        final isBankCard = state.paymentMethods?.pickedPaymentMethodType ==
            PaymentMethodType.bankCard;

        return GestureDetector(
          onTap: context.releaseFocus,
          child: Stack(
            children: [
              if (isCardPaymentInProgress)
                Scaffold(
                  appBar: AppBar(
                    title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                    iconTheme: const IconThemeData(color: Colors.white),
                    toolbarHeight: 70,
                  ),
                  body: const CenteredCircularProgressIndicator(),
                )
              else if (isCardPaymentPageLoaded)
                Scaffold(
                  appBar: AppBar(
                    title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                    iconTheme: const IconThemeData(color: Colors.white),
                    toolbarHeight: 70,
                  ),
                  body: WebViewWidget(
                    controller: cubit.webViewController,
                  ),
                )
              else
                Scaffold(
                  appBar: AppBar(
                    title: const SvgAsset(AssetPathConstants.whiteLogoPath),
                    iconTheme: const IconThemeData(color: Colors.white),
                    toolbarHeight: 160,
                  ),
                  body: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(theme.screenMargin),
                      children: [
                        VerticalGap.large(),
                        const AmountTextField(),
                        VerticalGap.medium(),
                        if (isInstaPay) ...[
                          const InstantPaymentAddressTextField(),
                          VerticalGap.medium(),
                        ] else if (isTelda) ...[
                          const TeldaUsernameTextField(),
                          VerticalGap.medium(),
                        ] else if (isEWallet) ...[
                          const WalletNumberTextField(),
                          VerticalGap.medium(),
                        ],
                        if (!isBankCard && !isEWallet)
                          ImagePickerTextField(
                            imageFileNameSC: cubit.imageFileNameSC,
                            onImagePickerTapped: cubit.onImagePickerTapped,
                            deletePickedImage: cubit.deletePickedImage,
                            onBackButtonPressed: cubit.onBackButtonPressed,
                            isSubmissionInProgress: isSubmissionInProgress,
                            imageError:
                                state.file.isNotValid ? state.file.error : null,
                            hasPickedImage:
                                state.file.value != null && state.file.isValid,
                            imageBytes: state.file.value?.readAsBytesSync(),
                            isImagePicked: state.file.value != null,
                          ),
                        VerticalGap.medium(),
                        if (isSubmissionInProgress)
                          TymerElevatedButton.inProgress(
                            label: l10n.confirmingButtonLabel,
                          )
                        else
                          TymerElevatedButton(
                            onTap: cubit.onSubmit,
                            label: l10n.confirmButtonLabel,
                          ),
                      ],
                    ),
                  ),
                ),
              if (state.bankCardPaymentStatus !=
                      BankCardPaymentStatus.paymentPageLoaded &&
                  state.bankCardPaymentStatus !=
                      BankCardPaymentStatus.inProgress)
                AppBarTitleContainer(
                  title: switch (pickedMethod) {
                    null => 'l10n.error',
                    PaymentMethodType.bankCard => cl10n.bankCard,
                    PaymentMethodType.vodafoneCash => cl10n.vodafoneCash,
                    PaymentMethodType.orangeCash => cl10n.orangeCash,
                    PaymentMethodType.etisalatCash => cl10n.etisalatCash,
                    PaymentMethodType.instaPay => cl10n.instaPay,
                    PaymentMethodType.bankTransfer => cl10n.bankTransfer,
                    PaymentMethodType.telda => cl10n.telda,
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
