import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'forgot_password_localizations_ar.dart';
import 'forgot_password_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ForgotPasswordLocalizations
/// returned by `ForgotPasswordLocalizations.of(context)`.
///
/// Applications need to include `ForgotPasswordLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/forgot_password_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ForgotPasswordLocalizations.localizationsDelegates,
///   supportedLocales: ForgotPasswordLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ForgotPasswordLocalizations.supportedLocales
/// property.
abstract class ForgotPasswordLocalizations {
  ForgotPasswordLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ForgotPasswordLocalizations of(BuildContext context) {
    return Localizations.of<ForgotPasswordLocalizations>(context, ForgotPasswordLocalizations)!;
  }

  static const LocalizationsDelegate<ForgotPasswordLocalizations> delegate = _ForgotPasswordLocalizationsDelegate();

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
  /// **'Forgot Password'**
  String get appBarTitle;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your details and we’ll send you an OTP to reset your password'**
  String get forgotPasswordTitle;

  /// No description provided for @otpSentSuccessfullySnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully.'**
  String get otpSentSuccessfullySnackBarMessage;

  /// No description provided for @generalErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'ٍSomething went wrong.'**
  String get generalErrorSnackBarMessage;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @invalidEmailFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone format'**
  String get invalidEmailFormatErrorMessage;

  /// No description provided for @phoneNotRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Phone not registered'**
  String get phoneNotRegisteredErrorMessage;

  /// No description provided for @forgotPasswordProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sending OTP'**
  String get forgotPasswordProgressButtonLabel;

  /// No description provided for @forgotPasswordButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset My Password'**
  String get forgotPasswordButtonLabel;

  /// No description provided for @phoneTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneTextFieldLabel;

  /// No description provided for @invalidPhoneFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneFormatErrorMessage;

  /// No description provided for @unverifiedPhoneErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Reset My Password'**
  String get unverifiedPhoneErrorMessage;

  /// No description provided for @isNotRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Phone not registered'**
  String get isNotRegisteredErrorMessage;

  /// No description provided for @otpRateLimitExceededErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of OTP requests reached. Please try again in {seconds} seconds.'**
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds);
}

class _ForgotPasswordLocalizationsDelegate extends LocalizationsDelegate<ForgotPasswordLocalizations> {
  const _ForgotPasswordLocalizationsDelegate();

  @override
  Future<ForgotPasswordLocalizations> load(Locale locale) {
    return SynchronousFuture<ForgotPasswordLocalizations>(lookupForgotPasswordLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ForgotPasswordLocalizationsDelegate old) => false;
}

ForgotPasswordLocalizations lookupForgotPasswordLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ForgotPasswordLocalizationsAr();
    case 'en': return ForgotPasswordLocalizationsEn();
  }

  throw FlutterError(
    'ForgotPasswordLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
