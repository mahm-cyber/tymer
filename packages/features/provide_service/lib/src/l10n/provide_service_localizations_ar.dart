import 'provide_service_localizations.dart';

/// The translations for Arabic (`ar`).
class ProvideServiceLocalizationsAr extends ProvideServiceLocalizations {
  ProvideServiceLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'قائمة الطلبات';

  @override
  String distanceToServiceLocation(String meters) {
    return '$meters متر';
  }

  @override
  String get noServiceRequestsText => 'لا توجد طلبات خدمة متاحة';

  @override
  String get showInMapButtonLabel => 'عرض على الخريطة';

  @override
  String get viewButtonLabel => 'عرض';

  @override
  String get userHasRunningServiceRequestSnackBarMessage => 'لديك طلب خدمة جاري. يرجى استكماله قبل تقديم طلب جديد.';

  @override
  String get locationDataFailureSnackBarMessage => 'فشل في الحصول على بيانات الموقع. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get showInListViewButtonLabel => 'عرض القائمة';
}
