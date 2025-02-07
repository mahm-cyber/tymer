import 'component_library_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ComponentLibraryLocalizationsAr extends ComponentLibraryLocalizations {
  ComponentLibraryLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get invalidCredentialsErrorMessage => 'الهاتف او كلمة مرور خطأ';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get emailTextFieldLabel => 'البريد الإلكتروني';

  @override
  String get invalidEmailFormatErrorMessage => 'صيغة البريد الإلكتروني غير صحيح';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get forgotMyPasswordButtonLabel => 'فقدت كلمة المرور';

  @override
  String get signInButtonLabel => 'تسجيل دخول';

  @override
  String get signInInProgressButtonLabel => 'جارى تسجيل الدخول';

  @override
  String get cancelButtonLabel => 'إلغاء';

  @override
  String get applyButtonLabel => 'تطبيق';

  @override
  String get emptyListIndicatorText => 'لا توجد عناصر متاحة';

  @override
  String get generalExceptionMessage => 'حدث خطأ، يرجى المحاولة لاحقًا';

  @override
  String get tryAgainButtonLabel => 'حاول مرة أخرى';

  @override
  String get successSnackBarMessage => 'تمت العملية بنجاح.';

  @override
  String get noInternetConnectionSnackBarErrorMessage => 'لا يوجد اتصال بالإنترنت. يرجى التحقق من إعدادات الشبكة.';

  @override
  String get unAuthSnackBarErrorMessage => 'يجب تسجيل الدخول.';

  @override
  String get reservedForTextFieldLabel => 'محجوز لـ';

  @override
  String get reservationServiceCategoryTextFieldLabel => 'فئة الخدمة';

  @override
  String get timeTextFieldLabel => 'الوقت';

  @override
  String get dateTextFieldLabel => 'التاريخ';

  @override
  String get placeNameTextFieldLabel => 'اسم المكان';

  @override
  String get placeAddressTextFieldLabel => 'عنوان المكان';

  @override
  String get locationTextFieldLabel => 'الموقع';

  @override
  String get priceTextFieldLabel => 'السعر';

  @override
  String get additionalCommentsTextFieldLabel => 'تعليقات إضافية';

  @override
  String get acceptButtonLabel => 'قبول';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters متر';
  }

  @override
  String get myLocationInfoWindowTitle => 'موقعي';

  @override
  String get viewOnMapButtonLabel => 'عرض';

  @override
  String get serviceRequestDetailsTileTitle => 'تفاصيل الطلب';

  @override
  String get pendingServiceRequestStatus => 'قيد الانتظار';

  @override
  String get inProgressServiceRequestStatus => 'جارى التنفيذ';

  @override
  String get completedServiceRequestStatus => 'مكتمل';

  @override
  String get canceledServiceRequestStatus => 'ملغى';

  @override
  String get pendingReviewServiceRequestStatus => 'قيد المراجعة';

  @override
  String get disputedServiceRequestStatus => 'معارض';

  @override
  String get viewButtonLabel => 'عرض';

  @override
  String get requesterServiceRequestsFetchMode => 'طالب خدمة';

  @override
  String get providerServiceRequestsFetchMode => 'منفذ خدمة';

  @override
  String get pendingReviewDisputeStatus => 'قيد المراجعة';

  @override
  String get timeInPastErrorMessage => 'لا يمكن أن يكون الوقت في الماضي';

  @override
  String get serviceFeesContainerLabel => 'رسوم الخدمة';

  @override
  String get servicePriceContainerLabel => 'سعر الخدمة';

  @override
  String get serviceTotalPriceContainerLabel => 'إجمالي سعر الخدمة';

  @override
  String get openFileSnackBarActionLabel => 'فتح الملف';

  @override
  String get downloadSuccessSnackBarMessage => 'تم تحميل الملف بنجاح!';

  @override
  String get downloadFailedSnackBarMessage => 'حدث حطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get reservationNumberTextFieldLabel => 'رقم الحجز';

  @override
  String get additionalNotesTextFieldLabel => 'ملاحظات إضافية';

  @override
  String get serviceResponseDetailsTileTitle => 'تفاصيل الرد';

  @override
  String get eyptianPoundLetters => 'ج.م';

  @override
  String get refundedRequesterLabel => 'تم الاسترداد';

  @override
  String get deniedRequesterLabel => 'مرفوض';

  @override
  String get providerLostDisputeLabel => 'تم الاسترداد';

  @override
  String get providerWonDisputeLabel => 'مرفوض';

  @override
  String get serviceIdTextFieldLabel => 'رقم الطلب';

  @override
  String get bankCard => 'بطاقة مصرفية';

  @override
  String get vodafoneCash => 'فودافون كاش';

  @override
  String get orangeCash => 'أورانج كاش';

  @override
  String get etisalatCash => 'اتصالات كاش';

  @override
  String get instaPay => 'إنستا باي';

  @override
  String get telda => 'تلدا';

  @override
  String get bankTransfer => 'تحويل بنكي';

  @override
  String get galleryButton => 'معرض';

  @override
  String get captureButton => 'التقاط';

  @override
  String get imageTextFieldLabel => 'صورة';

  @override
  String get imageSizeExceedsLimitErrorTextFieldMessage => 'يجب أن يكون حجم الصورة 1 ميجابايت أو أقل';

  @override
  String get bottomSheetGalleryButton => 'معرض';

  @override
  String get bottomSheetCaptureButton => 'التقاط';

  @override
  String get pendingPaymentStatus => 'قيد المراجعة';

  @override
  String get approvedPaymentStatus => 'موافق عليه';

  @override
  String get rejectedPaymentStatus => 'مرفوض';

  @override
  String get uploadFileIconLabel => 'ملف';

  @override
  String get uploadImageFromGalleryIconLabel => 'صورة';

  @override
  String get captureImageIconLabel => 'كاميرا';

  @override
  String get deleteFileIconLabel => 'حذف';

  @override
  String get noMessagesIndicator => 'لا توجد رسائل بعد';

  @override
  String get messageSentByMeCardTitle => 'أنت';

  @override
  String get transactionTypeEarning => 'إيراد';

  @override
  String get transactionTypePayout => 'صرف';

  @override
  String get transactionTypeTopup => 'شحن';

  @override
  String get transactionTypeWithdrawal => 'سحب';

  @override
  String get transactionTypeRefund => 'استرداد';

  @override
  String get transactionTypeBonus => 'مكافأة';

  @override
  String get transactionTypeChargeback => 'استرجاع';

  @override
  String get transactionStatusPending => 'قيد المراجعة';

  @override
  String get transactionStatusCompleted => 'مكتمل';

  @override
  String get transactionStatusFailed => 'فشل';

  @override
  String get transactionStatusCancelled => 'ملغى';

  @override
  String get transactionStatusUnderReview => 'قيد المراجعة';

  @override
  String get transactionStatusRefunded => 'تم الاسترداد';

  @override
  String get chatLimitReachedErrorMessage => 'لقد تجاوزت الحد الأقصى لإرسال الرسائل. يرجى المحاولة لاحقًا';
}
