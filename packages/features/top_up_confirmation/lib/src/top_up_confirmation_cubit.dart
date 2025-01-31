import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'top_up_confirmation_state.dart';

class TopUpConfirmationCubit extends Cubit<TopUpConfirmationState> {
  TopUpConfirmationCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onBackButtonPressed,
    required this.onSuccess,
  })  : _imagePicker = ImagePicker(),
        super(
          TopUpConfirmationState(
            paymentMethods: walletRepository.changeNotifier.paymentMethods!,
          ),
        );

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final StreamController<String> imageFileNameSC = StreamController();
  final ImagePicker _imagePicker;
  final VoidCallback onBackButtonPressed;
  final VoidCallback onSuccess;
  final WebViewController webViewController = WebViewController();

  void onAmountChanged(String? newValue) {
    final previousAmount = state.amount;
    final shouldValidate = previousAmount.isNotValid;
    final newState = state.copyWith(
      amount: shouldValidate
          ? Dynamic.validated(
              newValue,
              checkIfNumber: true,
              isRequired: true,
            )
          : Dynamic.unvalidated(newValue),
    );
    emit(newState);
  }

  void onAmountUnfocused() {
    final newState = state.copyWith(
      amount: Dynamic.validated(
        state.amount.value,
        checkIfNumber: true,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  bool _needsWalletNumber() {
    final type = state.paymentMethods?.pickedPaymentMethodType;
    return type == PaymentMethodType.vodafoneCash ||
        type == PaymentMethodType.orangeCash ||
        type == PaymentMethodType.etisalatCash;
  }

  bool _needsInstantPaymentAddress() {
    return state.paymentMethods?.pickedPaymentMethodType ==
        PaymentMethodType.instaPay;
  }

  bool _needsProof() {
    return state.paymentMethods?.pickedPaymentMethodType !=
        PaymentMethodType.bankCard;
  }

  void onWalletNumberChanged(String? newValue) {
    if (!_needsWalletNumber()) return;

    final previousValue = state.walletNumber;
    final shouldValidate = previousValue.isNotValid;
    final newState = state.copyWith(
      walletNumber: shouldValidate
          ? Dynamic.validated(
              newValue,
              isRequired: true,
              shouldCheckIfEgyptianMobile: true,
            )
          : Dynamic.unvalidated(newValue),
    );
    emit(newState);
  }

  void onWalletNumberUnfocused() {
    if (!_needsWalletNumber()) return;

    final newState = state.copyWith(
      walletNumber: Dynamic.validated(
        state.walletNumber.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onInstantPaymentAddressChanged(String? newValue) {
    if (!_needsInstantPaymentAddress()) return;

    final previousValue = state.instantPaymentAddress;
    final shouldValidate = previousValue.isNotValid;
    final newState = state.copyWith(
      instantPaymentAddress: shouldValidate
          ? Dynamic.validated(newValue, isRequired: true)
          : Dynamic.unvalidated(newValue),
    );
    emit(newState);
  }

  void onInstantPaymentAddressUnfocused() {
    if (!_needsInstantPaymentAddress()) return;

    final newState = state.copyWith(
      instantPaymentAddress: Dynamic.validated(
        state.instantPaymentAddress.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onImagePickerTapped() {
    final imagePickerBottomSheetVisibleState = state.copyWith(
      isImagePickerBottomSheetVisible: true,
    );
    emit(imagePickerBottomSheetVisibleState);
  }

  Future<void> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      onImagePicked(
        xFile.name,
        file,
      );
    }
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 35,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      onImagePicked(
        xFile.name,
        file,
      );
    }
  }

  void onImagePicked(
    String carImageFileName,
    File? file,
  ) {
    //image more than 1 mb
    final validatedImageBytes = FileSize<File?>.validated(
      file,
      sizeLimitInKb: 1024,
    );
    final carImagePicked = state.copyWith(
      isImagePickerBottomSheetVisible: false,
      file: validatedImageBytes,
    );
    emit(carImagePicked);
    imageFileNameSC.add(carImageFileName);
  }

  void deletePickedImage() {
    final imageDeletedState = state.copyWith(
      file: const FileSize<File?>.unvalidated(null),
    );
    emit(imageDeletedState);
    imageFileNameSC.add('');
  }

  void onImagePickerBottomSheetClosed() {
    final imagePickerBottomSheetClosedState = state.copyWith(
      isImagePickerBottomSheetVisible: false,
    );
    emit(imagePickerBottomSheetClosedState);
  }

  void onSubmit() async {
    final amount = Dynamic.validated(
      state.amount.value,
      checkIfNumber: true,
      isRequired: true,
    );
    final file = FileSize<File?>.validated(
      state.file.value,
      sizeLimitInKb: 1024,
      isRequired: true,
    );
    final walletNumber = Dynamic.validated(
      state.walletNumber.value,
      isRequired: true,
      shouldCheckIfEgyptianMobile: true,
    );

    final instantPaymentAddress = Dynamic.validated(
      state.instantPaymentAddress.value,
      isRequired: true,
    );

    final formFields = <FormzInput<dynamic, dynamic>>[
      amount,
      if (_needsProof()) file,
      if (_needsWalletNumber()) walletNumber,
      if (_needsInstantPaymentAddress()) instantPaymentAddress,
    ];

    final isFormValid = Formz.validate(formFields);

    final newState = state.copyWith(
      amount: amount,
      walletNumber: walletNumber,
      instantPaymentAddress: instantPaymentAddress,
      file: file,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        // Add your submission logic here
        if (state.paymentMethods?.pickedPaymentMethodType ==
            PaymentMethodType.bankCard) {
          final url = await walletRepository.confirmBankCardTopUp(
            int.parse(amount.value!),
          );

          //url should be webviewed
          webViewController
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onUrlChange: (UrlChange urlChange) {
                  // Update the URL bar to show the new URL.
                  final currentUrl = urlChange.url;
                  final isPaymentPageLoaded =
                      currentUrl?.contains('secure-egypt.paytabs.com') == true;

                  final newState = state.copyWith(
                    bankCardPaymentStatus: isPaymentPageLoaded
                        ? BankCardPaymentStatus.paymentPageLoaded
                        : null,
                  );
                  emit(newState);
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
        } else {
          await walletRepository.confirmTopUp(
            paymentMethodType: state.paymentMethods!.pickedPaymentMethodType!,
            amount: int.parse(amount.value!),
            walletNumber: walletNumber.value,
            instantPaymentAddress: instantPaymentAddress.value,
            image: state.file.value!,
          );
        }

        final newState = state.copyWith(
          bankCardPaymentStatus:
              state.paymentMethods?.pickedPaymentMethodType ==
                      PaymentMethodType.bankCard
                  ? BankCardPaymentStatus.inProgress
                  : null,
          submissionStatus: state.paymentMethods?.pickedPaymentMethodType ==
                  PaymentMethodType.bankCard
              ? null
              : FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
        );
        emit(newState);
      }
    }
  }
}
