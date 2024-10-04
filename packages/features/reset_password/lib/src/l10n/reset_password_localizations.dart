import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'reset_password_localizations_ar.dart';
import 'reset_password_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ResetPasswordLocalizations
/// returned by `ResetPasswordLocalizations.of(context)`.
///
/// Applications need to include `ResetPasswordLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/reset_password_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ResetPasswordLocalizations.localizationsDelegates,
///   supportedLocales: ResetPasswordLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ResetPasswordLocalizations.supportedLocales
/// property.
abstract class ResetPasswordLocalizations {
  ResetPasswordLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ResetPasswordLocalizations of(BuildContext context) {
    return Localizations.of<ResetPasswordLocalizations>(context, ResetPasswordLocalizations)!;
  }

  static const LocalizationsDelegate<ResetPasswordLocalizations> delegate = _ResetPasswordLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @resetPasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset successfully'**
  String get resetPasswordSuccessMessage;

  /// No description provided for @resetPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordScreenTitle;

  /// No description provided for @resetPasswordScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordScreenSubtitle;

  /// No description provided for @submissionInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submitting'**
  String get submissionInProgressButtonLabel;

  /// No description provided for @submitButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButtonLabel;

  /// No description provided for @newPasswordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordTextFieldLabel;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredFieldErrorMessage;

  /// No description provided for @newPasswordTextFieldWeakPasswordError.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak'**
  String get newPasswordTextFieldWeakPasswordError;

  /// No description provided for @newPasswordTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get newPasswordTextFieldHint;

  /// No description provided for @newPasswordConfirmationTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get newPasswordConfirmationTextFieldLabel;

  /// No description provided for @newPasswordConfirmationTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new password'**
  String get newPasswordConfirmationTextFieldHint;

  /// No description provided for @passwordConfirmationTextFieldDoesNotMatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordConfirmationTextFieldDoesNotMatchError;

  /// No description provided for @passwordTextFieldWeakPasswordErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'The password must have At least 6 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, \$, !, etc.)'**
  String get passwordTextFieldWeakPasswordErrorDescription;
}

class _ResetPasswordLocalizationsDelegate extends LocalizationsDelegate<ResetPasswordLocalizations> {
  const _ResetPasswordLocalizationsDelegate();

  @override
  Future<ResetPasswordLocalizations> load(Locale locale) {
    return SynchronousFuture<ResetPasswordLocalizations>(lookupResetPasswordLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ResetPasswordLocalizationsDelegate old) => false;
}

ResetPasswordLocalizations lookupResetPasswordLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ResetPasswordLocalizationsAr();
    case 'en': return ResetPasswordLocalizationsEn();
  }

  throw FlutterError(
    'ResetPasswordLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
