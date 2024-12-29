import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'change_password_localizations_ar.dart';
import 'change_password_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChangePasswordLocalizations
/// returned by `ChangePasswordLocalizations.of(context)`.
///
/// Applications need to include `ChangePasswordLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/change_password_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChangePasswordLocalizations.localizationsDelegates,
///   supportedLocales: ChangePasswordLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ChangePasswordLocalizations.supportedLocales
/// property.
abstract class ChangePasswordLocalizations {
  ChangePasswordLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChangePasswordLocalizations of(BuildContext context) {
    return Localizations.of<ChangePasswordLocalizations>(context, ChangePasswordLocalizations)!;
  }

  static const LocalizationsDelegate<ChangePasswordLocalizations> delegate = _ChangePasswordLocalizationsDelegate();

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

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get appBarTitle;

  /// No description provided for @requiredTextFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredTextFieldErrorMessage;

  /// No description provided for @incorrectPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password, please try again'**
  String get incorrectPasswordErrorMessage;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @passwordTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get passwordTextFieldHint;

  /// No description provided for @newPasswordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordTextFieldLabel;

  /// No description provided for @newPasswordTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get newPasswordTextFieldHint;

  /// No description provided for @newPasswordWeakErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Your new password is too weak'**
  String get newPasswordWeakErrorMessage;

  /// No description provided for @newPasswordConfirmationTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get newPasswordConfirmationTextFieldLabel;

  /// No description provided for @newPasswordConfirmationTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new password'**
  String get newPasswordConfirmationTextFieldHint;

  /// No description provided for @newPasswordConfirmationTextFieldError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get newPasswordConfirmationTextFieldError;

  /// No description provided for @changePasswordInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing Up...'**
  String get changePasswordInProgressButtonLabel;

  /// No description provided for @changePasswordButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordButtonLabel;

  /// No description provided for @changePasswordSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get changePasswordSuccessMessage;

  /// No description provided for @changePasswordFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Change password failed, try again'**
  String get changePasswordFailureMessage;

  /// No description provided for @newPasswordTextFieldWeakPasswordErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'The password must have At least 8 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, '**
  String get newPasswordTextFieldWeakPasswordErrorDescription;
}

class _ChangePasswordLocalizationsDelegate extends LocalizationsDelegate<ChangePasswordLocalizations> {
  const _ChangePasswordLocalizationsDelegate();

  @override
  Future<ChangePasswordLocalizations> load(Locale locale) {
    return SynchronousFuture<ChangePasswordLocalizations>(lookupChangePasswordLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChangePasswordLocalizationsDelegate old) => false;
}

ChangePasswordLocalizations lookupChangePasswordLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ChangePasswordLocalizationsAr();
    case 'en': return ChangePasswordLocalizationsEn();
  }

  throw FlutterError(
    'ChangePasswordLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
