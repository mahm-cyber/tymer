part of 'top_up_confirmation_cubit.dart';

class TopUpConfirmationState extends Equatable {
  const TopUpConfirmationState({
    this.paymentMethods,
    this.amount = const Dynamic<String?>.unvalidated(),
    this.walletNumber = const Dynamic<String?>.unvalidated(),
    this.instantPaymentAddress = const Dynamic<String?>.unvalidated(),
    this.file = const FileSize<File?>.unvalidated(),
    this.imageFileName,
    this.isImagePickerBottomSheetVisible = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.bankCardPaymentStatus = BankCardPaymentStatus.initial,
  });

  final PaymentMethods? paymentMethods;
  final Dynamic<String?> amount;
  final Dynamic<String?> walletNumber;
  final Dynamic<String?> instantPaymentAddress;
  final FileSize<File?> file;
  final String? imageFileName;
  final bool isImagePickerBottomSheetVisible;
  final FormzSubmissionStatus submissionStatus;
  final BankCardPaymentStatus bankCardPaymentStatus;

  TopUpConfirmationState copyWith({
    PaymentMethods? paymentMethods,
    Dynamic<String?>? amount,
    Dynamic<String?>? walletNumber,
    Dynamic<String?>? instantPaymentAddress,
    FileSize<File?>? file,
    String? imageFileName,
    bool? isImagePickerBottomSheetVisible,
    FormzSubmissionStatus? submissionStatus,
    BankCardPaymentStatus? bankCardPaymentStatus,
  }) {
    return TopUpConfirmationState(
      paymentMethods: paymentMethods ?? this.paymentMethods,
      amount: amount ?? this.amount,
      walletNumber: walletNumber ?? this.walletNumber,
      instantPaymentAddress:
          instantPaymentAddress ?? this.instantPaymentAddress,
      file: file ?? this.file,
      imageFileName: imageFileName ?? this.imageFileName,
      isImagePickerBottomSheetVisible:
          isImagePickerBottomSheetVisible ?? this.isImagePickerBottomSheetVisible,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      bankCardPaymentStatus: bankCardPaymentStatus ?? this.bankCardPaymentStatus,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethods,
        amount,
        walletNumber,
        instantPaymentAddress,
        file,
        imageFileName,
        isImagePickerBottomSheetVisible,
        submissionStatus,
        bankCardPaymentStatus,
      ];
}

enum BankCardPaymentStatus {
  initial,
  inProgress,
  paymentPageLoaded,
  success,
  failed,
}
