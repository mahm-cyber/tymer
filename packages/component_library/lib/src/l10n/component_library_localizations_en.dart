import 'component_library_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ComponentLibraryLocalizationsEn extends ComponentLibraryLocalizations {
  ComponentLibraryLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get invalidCredentialsErrorMessage => 'Incorrect phone or password';

  @override
  String get requiredFieldErrorMessage => 'Required*';

  @override
  String get emailTextFieldLabel => 'Email';

  @override
  String get invalidEmailFormatErrorMessage => 'Invalid email format';

  @override
  String get passwordTextFieldLabel => 'Password';

  @override
  String get forgotMyPasswordButtonLabel => 'Forgot Password';

  @override
  String get signInButtonLabel => 'Sign In';

  @override
  String get signInInProgressButtonLabel => 'Signing In';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get applyButtonLabel => 'Apply';

  @override
  String get emptyListIndicatorText => 'No items available';

  @override
  String get generalExceptionMessage => 'An error occurred, please try again later';

  @override
  String get tryAgainButtonLabel => 'Try Again';

  @override
  String get successSnackBarMessage => 'Operation completed successfully.';

  @override
  String get noInternetConnectionSnackBarErrorMessage => 'No internet connection. Please check your network settings.';

  @override
  String get unAuthSnackBarErrorMessage => 'You must login first.';

  @override
  String get reservedForTextFieldLabel => 'Reserved For';

  @override
  String get reservationServiceCategoryTextFieldLabel => 'Service Category';

  @override
  String get timeTextFieldLabel => 'Time';

  @override
  String get dateTextFieldLabel => 'Date';

  @override
  String get placeNameTextFieldLabel => 'Place Name';

  @override
  String get placeAddressTextFieldLabel => 'Place Address';

  @override
  String get locationTextFieldLabel => 'Location';

  @override
  String get priceTextFieldLabel => 'Price';

  @override
  String get additionalCommentsTextFieldLabel => 'Additional Comments';

  @override
  String get acceptButtonLabel => 'Accept';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters meters';
  }

  @override
  String get myLocationInfoWindowTitle => 'My Location';

  @override
  String get viewOnMapButtonLabel => 'View';

  @override
  String get serviceRequestDetailsTileTitle => 'Request Details';

  @override
  String get pendingServiceRequestStatus => 'Pending';

  @override
  String get inProgressServiceRequestStatus => 'In Progress';

  @override
  String get completedServiceRequestStatus => 'Completed';

  @override
  String get canceledServiceRequestStatus => 'Canceled';

  @override
  String get pendingReviewServiceRequestStatus => 'Pending Review';

  @override
  String get disputedServiceRequestStatus => 'Disputed';

  @override
  String get viewButtonLabel => 'View';

  @override
  String get requesterServiceRequestsFetchMode => 'Requested';

  @override
  String get providerServiceRequestsFetchMode => 'Provided';

  @override
  String get pendingReviewDisputeStatus => 'Pending Review';

  @override
  String get timeInPastErrorMessage => 'Time cannot be in the past.';

  @override
  String get serviceFeesContainerLabel => 'Service Fee';

  @override
  String get servicePriceContainerLabel => 'Service Price';

  @override
  String get serviceTotalPriceContainerLabel => 'Service Total Price';

  @override
  String get openFileSnackBarActionLabel => 'Open File';

  @override
  String get downloadSuccessSnackBarMessage => 'Download completed successfully!';

  @override
  String get downloadFailedSnackBarMessage => 'Download failed. Please try again.';

  @override
  String get reservationNumberTextFieldLabel => 'Reservation Number';

  @override
  String get additionalNotesTextFieldLabel => 'Additional Notes';

  @override
  String get serviceResponseDetailsTileTitle => 'Response Details';

  @override
  String get eyptianPoundLetters => 'EGP';

  @override
  String get refundedRequesterLabel => 'Refunded';

  @override
  String get deniedRequesterLabel => 'Denied';

  @override
  String get providerLostDisputeLabel => 'Refunded';

  @override
  String get providerWonDisputeLabel => 'Denied';

  @override
  String get serviceIdTextFieldLabel => 'Request ID';

  @override
  String get bankCard => 'Bank Card';

  @override
  String get vodafoneCash => 'Vodafone Cash';

  @override
  String get orangeCash => 'Orange Cash';

  @override
  String get etisalatCash => 'Etisalat Cash';

  @override
  String get instaPay => 'InstaPay';

  @override
  String get telda => 'Telda';

  @override
  String get bankTransfer => 'Bank Transfer';

  @override
  String get galleryButton => 'Gallery';

  @override
  String get captureButton => 'Capture';

  @override
  String get imageTextFieldLabel => 'Image';

  @override
  String get imageSizeExceedsLimitErrorTextFieldMessage => 'The image size must be 1 MB or less';

  @override
  String get bottomSheetGalleryButton => 'Gallery';

  @override
  String get bottomSheetCaptureButton => 'Capture';

  @override
  String get pendingPaymentStatus => 'Pending';

  @override
  String get approvedPaymentStatus => 'Approved';

  @override
  String get rejectedPaymentStatus => 'Rejected';

  @override
  String get uploadFileIconLabel => 'File';

  @override
  String get uploadImageFromGalleryIconLabel => 'Gallery';

  @override
  String get captureImageIconLabel => 'Capture';

  @override
  String get deleteFileIconLabel => 'Delete';

  @override
  String get noMessagesIndicator => 'No messages yet';

  @override
  String get messageSentByMeCardTitle => 'You';

  @override
  String get transactionTypeEarning => 'Earning';

  @override
  String get transactionTypePayout => 'Payout';

  @override
  String get transactionTypeTopup => 'Top Up';

  @override
  String get transactionTypeWithdrawal => 'Withdrawal';

  @override
  String get transactionTypeRefund => 'Refund';

  @override
  String get transactionTypeBonus => 'Bonus';

  @override
  String get transactionTypeChargeback => 'Charged Back';

  @override
  String get transactionStatusPending => 'Pending';

  @override
  String get transactionStatusCompleted => 'Completed';

  @override
  String get transactionStatusFailed => 'Failed';

  @override
  String get transactionStatusCancelled => 'Cancelled';

  @override
  String get transactionStatusUnderReview => 'Under Review';

  @override
  String get transactionStatusRefunded => 'Refunded';
}
