import 'service_request_status_localizations.dart';

/// The translations for Arabic (`ar`).
class ServiceRequestStatusLocalizationsAr extends ServiceRequestStatusLocalizations {
  ServiceRequestStatusLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'حالة الطلب';

  @override
  String get findingSomeoneStepTitle => 'جاري العثور على شخص';

  @override
  String get processingStepTitle => 'جاري المعالجة';

  @override
  String get completeStepTitle => 'اكتمل';
}
