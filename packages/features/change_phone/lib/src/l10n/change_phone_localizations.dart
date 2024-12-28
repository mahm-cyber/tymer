import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'change_phone_localizations_ar.dart';
import 'change_phone_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ChangePhoneLocalizations
/// returned by `ChangePhoneLocalizations.of(context)`.
///
/// Applications need to include `ChangePhoneLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/change_phone_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChangePhoneLocalizations.localizationsDelegates,
///   supportedLocales: ChangePhoneLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ChangePhoneLocalizations.supportedLocales
/// property.
abstract class ChangePhoneLocalizations {
  ChangePhoneLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChangePhoneLocalizations of(BuildContext context) {
    return Localizations.of<ChangePhoneLocalizations>(context, ChangePhoneLocalizations)!;
  }

  static const LocalizationsDelegate<ChangePhoneLocalizations> delegate = _ChangePhoneLocalizationsDelegate();

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
  /// **'Change Phone Number'**
  String get appBarTitle;

  /// No description provided for @generalErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get generalErrorSnackBarMessage;

  /// No description provided for @incorrectPasswordErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password, please try again'**
  String get incorrectPasswordErrorMessage;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @phoneTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'New Phone Number'**
  String get phoneTextFieldLabel;

  /// No description provided for @phoneTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new phone number'**
  String get phoneTextFieldHint;

  /// No description provided for @invalidPhoneFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get invalidPhoneFormatErrorMessage;

  /// No description provided for @phoneIsAlreadyRegisteredErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Phone is already registered'**
  String get phoneIsAlreadyRegisteredErrorMessage;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @changePhoneButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get changePhoneButtonLabel;

  /// No description provided for @changePhoneInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing In'**
  String get changePhoneInProgressButtonLabel;

  /// No description provided for @otpRateLimitExceededErrorSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Maximum number of OTP requests reached. Please try again in {seconds} seconds.'**
  String otpRateLimitExceededErrorSnackBarMessage(Object seconds);

  /// No description provided for @otpSentSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'An OTP has been sent to your phone'**
  String get otpSentSnackBarMessage;
}

class _ChangePhoneLocalizationsDelegate extends LocalizationsDelegate<ChangePhoneLocalizations> {
  const _ChangePhoneLocalizationsDelegate();

  @override
  Future<ChangePhoneLocalizations> load(Locale locale) {
    return SynchronousFuture<ChangePhoneLocalizations>(lookupChangePhoneLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChangePhoneLocalizationsDelegate old) => false;
}

ChangePhoneLocalizations lookupChangePhoneLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ChangePhoneLocalizationsAr();
    case 'en': return ChangePhoneLocalizationsEn();
  }

  throw FlutterError(
    'ChangePhoneLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
