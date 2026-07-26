// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'choose_top_up_method_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ChooseTopUpMethodLocalizationsAr extends ChooseTopUpMethodLocalizations {
  ChooseTopUpMethodLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBarTitle => 'اختيار طريقة الشحن';

  @override
  String get topUpHistoryButtonLabel => 'عرض طلبات الشحن السابقة';

  @override
  String get topUpProcessingTimeNote =>
      'يرجى العلم أن شحن المحفظة يستغرق 5 دقائق ليتم معالجته، بينما قد تستغرق الخيارات الأخرى ما يصل إلى يوم عمل واحد';
}
