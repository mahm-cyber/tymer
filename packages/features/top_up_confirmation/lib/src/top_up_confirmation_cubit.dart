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
              isGreatherThan: 0,
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
        isGreatherThan: 0,
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

  bool _needsTeldaUsername() {
    return state.paymentMethods?.pickedPaymentMethodType ==
        PaymentMethodType.telda;
  }

  bool _needsProof() {
    final type = state.paymentMethods?.pickedPaymentMethodType;
    if (type == PaymentMethodType.bankCard) return false;

    // Paymob disbursement (Instant Cashin) does not require user to upload an image proof.
    if (_isPaymobSupportedWallet(type)) return false;

    return true;
  }

  bool _isPaymobSupportedWallet(PaymentMethodType? type) {
    if (type == null) return false;
    return type == PaymentMethodType.vodafoneCash ||
        type == PaymentMethodType.orangeCash ||
        type == PaymentMethodType.etisalatCash;
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
        shouldCheckIfEgyptianMobile: true,
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

  void onTeldaUsernameChanged(String? newValue) {
    if (!_needsTeldaUsername()) return;

    final previousValue = state.teldaUsername;
    final shouldValidate = previousValue.isNotValid;
    final newState = state.copyWith(
      teldaUsername: shouldValidate
          ? Dynamic.validated(newValue, isRequired: true)
          : Dynamic.unvalidated(newValue),
    );
    emit(newState);
  }

  void onTeldaUsernameUnfocused() {
    if (!_needsTeldaUsername()) return;

    final newState = state.copyWith(
      teldaUsername: Dynamic.validated(
        state.teldaUsername.value,
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
    final teldaUsername = Dynamic.validated(
      state.teldaUsername.value,
      isRequired: true,
    );

    final amount = Dynamic.validated(
      state.amount.value,
      checkIfNumber: true,
      isRequired: true,
      isGreatherThan: 0,
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
      if (_needsTeldaUsername()) teldaUsername,
    ];

    final isFormValid = Formz.validate(formFields);

    final newState = state.copyWith(
      amount: amount,
      walletNumber: walletNumber,
      instantPaymentAddress: instantPaymentAddress,
      teldaUsername: teldaUsername,
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
            double.parse(amount.value!),
          );

          //url should be webviewed
          webViewController
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onUrlChange: (UrlChange urlChange) async {
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
                  final isPaymentProccessFinished =
                      currentUrl?.contains('result') == true;
                  if (isPaymentProccessFinished) {
                    await userRepository.getFreshUser();
                  }
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
        } else {
          final paymentType = state.paymentMethods!.pickedPaymentMethodType!;

          if (paymentType == PaymentMethodType.vodafoneCash ||
              paymentType == PaymentMethodType.etisalatCash ||
              paymentType == PaymentMethodType.orangeCash) {
            final transactionId = await walletRepository.paymobTopUp(
              paymentMethodType: paymentType,
              amount: double.parse(amount.value!),
              msisdn: walletNumber.value!,
            );
            // await walletRepository.confirmTopUp(
            //   paymentMethodType: paymentType,
            //   amount: double.parse(amount.value!),
            //   walletNumber: walletNumber.value,
            //   transactionId: transactionId,
            // );
          } else {
            await walletRepository.confirmTopUp(
              paymentMethodType: paymentType,
              amount: double.parse(amount.value!),
              walletNumber: walletNumber.value,
              teldaUsername: teldaUsername.value,
              instantPaymentAddress: instantPaymentAddress.value,
              image: state.file.value!,
            );
          }
          await userRepository.getFreshUser();
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
          error: error,
        );
        emit(newState);
      }
    }
  }
}
