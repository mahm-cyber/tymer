import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'sign_up_localizations_ar.dart';
import 'sign_up_localizations_en.dart';

/// Callers can lookup localized strings with an instance of SignUpLocalizations
/// returned by `SignUpLocalizations.of(context)`.
///
/// Applications need to include `SignUpLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/sign_up_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignUpLocalizations.localizationsDelegates,
///   supportedLocales: SignUpLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the SignUpLocalizations.supportedLocales
/// property.
abstract class SignUpLocalizations {
  SignUpLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignUpLocalizations of(BuildContext context) {
    return Localizations.of<SignUpLocalizations>(context, SignUpLocalizations)!;
  }

  static const LocalizationsDelegate<SignUpLocalizations> delegate = _SignUpLocalizationsDelegate();

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
  /// **'Create New Account'**
  String get appBarTitle;

  /// No description provided for @signInButtonText.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonText;

  /// No description provided for @emailTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailTextFieldLabel;

  /// No description provided for @emailTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailTextFieldHint;

  /// No description provided for @requiredTextFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredTextFieldErrorMessage;

  /// No description provided for @invalidCredentialsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials, please try again.'**
  String get invalidCredentialsErrorMessage;

  /// No description provided for @invalidFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid format, please check your input.'**
  String get invalidFormatErrorMessage;

  /// No description provided for @alreadyRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'You are already registered.'**
  String get alreadyRegisteredErrorMessage;

  /// No description provided for @nameTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameTextFieldHint;

  /// No description provided for @nameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get nameTextFieldLabel;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @passwordTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordTextFieldHint;

  /// No description provided for @passwordWeakErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password is too weak.'**
  String get passwordWeakErrorMessage;

  /// No description provided for @passwordConfirmationTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get passwordConfirmationTextFieldLabel;

  /// No description provided for @passwordConfirmationTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get passwordConfirmationTextFieldHint;

  /// No description provided for @passwordConfirmationTextFieldError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordConfirmationTextFieldError;

  /// No description provided for @phoneTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneTextFieldLabel;

  /// No description provided for @phoneTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneTextFieldHint;

  /// No description provided for @signUpInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing Up...'**
  String get signUpInProgressButtonLabel;

  /// No description provided for @signUpButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButtonLabel;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @invalidMobileFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number format'**
  String get invalidMobileFormatErrorMessage;

  /// No description provided for @termsAndConditionsBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditionsBottomSheetTitle;

  /// No description provided for @agreeAndAcceptAllButtonText.
  ///
  /// In en, this message translates to:
  /// **'Agree to Terms and Conditions'**
  String get agreeAndAcceptAllButtonText;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'An OTP has been sent to your phone'**
  String get signUpSuccessMessage;

  /// No description provided for @signUpFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Failed, try again'**
  String get signUpFailureMessage;

  /// No description provided for @passwordTextFieldWeakPasswordErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'The password must have At least 6 characters long, Contains at least one uppercase letter, Contains at least one lowercase letter, Contains at least one number, Contains at least one symbol (e.g., @, '**
  String get passwordTextFieldWeakPasswordErrorDescription;
}

class _SignUpLocalizationsDelegate extends LocalizationsDelegate<SignUpLocalizations> {
  const _SignUpLocalizationsDelegate();

  @override
  Future<SignUpLocalizations> load(Locale locale) {
    return SynchronousFuture<SignUpLocalizations>(lookupSignUpLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SignUpLocalizationsDelegate old) => false;
}

SignUpLocalizations lookupSignUpLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return SignUpLocalizationsAr();
    case 'en': return SignUpLocalizationsEn();
  }

  throw FlutterError(
    'SignUpLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
