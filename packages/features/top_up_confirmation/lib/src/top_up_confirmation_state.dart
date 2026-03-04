part of 'top_up_confirmation_cubit.dart';

class TopUpConfirmationState extends Equatable {
  const TopUpConfirmationState({
    this.paymentMethods,
    this.amount = const Dynamic<String?>.unvalidated(),
    this.walletNumber = const Dynamic<String?>.unvalidated(),
    this.instantPaymentAddress = const Dynamic<String?>.unvalidated(),
    this.teldaUsername = const Dynamic<String?>.unvalidated(),
    this.file = const FileSize<File?>.unvalidated(),
    this.imageFileName,
    this.isImagePickerBottomSheetVisible = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.bankCardPaymentStatus = BankCardPaymentStatus.initial,
    this.error,
  });

  final PaymentMethods? paymentMethods;
  final Dynamic<String?> amount;
  final Dynamic<String?> walletNumber;
  final Dynamic<String?> instantPaymentAddress;
  final Dynamic<String?> teldaUsername;
  final FileSize<File?> file;
  final String? imageFileName;
  final bool isImagePickerBottomSheetVisible;
  final FormzSubmissionStatus submissionStatus;
  final BankCardPaymentStatus bankCardPaymentStatus;
  final dynamic error;

  TopUpConfirmationState copyWith({
    PaymentMethods? paymentMethods,
    Dynamic<String?>? amount,
    Dynamic<String?>? walletNumber,
    Dynamic<String?>? instantPaymentAddress,
    Dynamic<String?>? teldaUsername,
    FileSize<File?>? file,
    String? imageFileName,
    bool? isImagePickerBottomSheetVisible,
    FormzSubmissionStatus? submissionStatus,
    BankCardPaymentStatus? bankCardPaymentStatus,
    dynamic error,
  }) {
    return TopUpConfirmationState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      amount: amount ?? this.amount,
      walletNumber: walletNumber ?? this.walletNumber,
      instantPaymentAddress:
          instantPaymentAddress ?? this.instantPaymentAddress,
      teldaUsername: teldaUsername ?? this.teldaUsername,
      file: file ?? this.file,
      imageFileName: imageFileName ?? this.imageFileName,
      isImagePickerBottomSheetVisible: isImagePickerBottomSheetVisible ??
          this.isImagePickerBottomSheetVisible,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      bankCardPaymentStatus:
          bankCardPaymentStatus ?? this.bankCardPaymentStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethods,
        amount,
        walletNumber,
        instantPaymentAddress,
        teldaUsername,
        file,
        imageFileName,
        isImagePickerBottomSheetVisible,
        submissionStatus,
        bankCardPaymentStatus,
        error,
      ];
}

enum BankCardPaymentStatus {
  initial,
  inProgress,
  paymentPageLoaded,
  success,
  failed,
}
