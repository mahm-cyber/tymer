import 'tab_container_localizations.dart';

/// The translations for Arabic (`ar`).
class TabContainerLocalizationsAr extends TabContainerLocalizations {
  TabContainerLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get tasksTabLabel => 'مهام';

  @override
  String get contactsTabLabel => 'جهات الاتصال';

  @override
  String get dashboardTabLabel => 'الرئيسية';

  @override
  String get companiesTabLabel => 'الشركات';

  @override
  String get dealsTabLabel => 'صفقات';

  @override
  String get menuTabLabel => 'القائمة';

  @override
  String get appDependenciesFetchSuccessSnackBarMessage => 'تم تحميل البيانات بنجاح';

  @override
  String get refreshAppDepButtonTooltip => 'تحديث البيانات';
}
