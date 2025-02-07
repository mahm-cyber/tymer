import 'delete_account_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class DeleteAccountLocalizationsAr extends DeleteAccountLocalizations {
  DeleteAccountLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get deleteAccountTitle => 'حذف الحساب';

  @override
  String get deleteAccountContent => 'هل أنت متأكد أنك تريد حذف حسابك؟';

  @override
  String get deleteAccountButton => 'حذف';

  @override
  String get cancelButtonLabel => 'إلغاء';

  @override
  String get deleteAccountSuccessMessage => 'تم حذف الحساب بنجاح';

  @override
  String get passwordTextFieldLabel => 'كلمة المرور';

  @override
  String get requiredFieldErrorMessage => 'مطلوب*';

  @override
  String get invalidCredentialsErrorMessage => 'كلمة المرور غير متطابقة';
}
