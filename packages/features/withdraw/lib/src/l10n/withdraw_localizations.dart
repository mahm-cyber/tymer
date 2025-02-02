import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'withdraw_localizations_ar.dart';
import 'withdraw_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of WithdrawLocalizations
/// returned by `WithdrawLocalizations.of(context)`.
///
/// Applications need to include `WithdrawLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/withdraw_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WithdrawLocalizations.localizationsDelegates,
///   supportedLocales: WithdrawLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the WithdrawLocalizations.supportedLocales
/// property.
abstract class WithdrawLocalizations {
  WithdrawLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WithdrawLocalizations of(BuildContext context) {
    return Localizations.of<WithdrawLocalizations>(context, WithdrawLocalizations)!;
  }

  static const LocalizationsDelegate<WithdrawLocalizations> delegate = _WithdrawLocalizationsDelegate();

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
  /// **'Withdraw'**
  String get appBarTitle;

  /// No description provided for @withdrawAmountTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Amount'**
  String get withdrawAmountTextFieldLabel;

  /// No description provided for @withdrawAmountTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Withdraw Amount'**
  String get withdrawAmountTextFieldHint;

  /// No description provided for @isNotNumberTextFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get isNotNumberTextFieldErrorMessage;

  /// No description provided for @withdrawConfirmButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Request Withdraw'**
  String get withdrawConfirmButtonLabel;

  /// No description provided for @walletNumberTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet Number'**
  String get walletNumberTextFieldLabel;

  /// No description provided for @ibanNumberTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'IBAN Number'**
  String get ibanNumberTextFieldLabel;

  /// No description provided for @beneficiaryNameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Name'**
  String get beneficiaryNameTextFieldLabel;

  /// No description provided for @invalidWalletNumberErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid wallet number'**
  String get invalidWalletNumberErrorMessage;

  /// No description provided for @instantPaymentAddressTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Instant Payment Address'**
  String get instantPaymentAddressTextFieldLabel;

  /// No description provided for @teldaUsernameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Telda Username'**
  String get teldaUsernameTextFieldLabel;
}

class _WithdrawLocalizationsDelegate extends LocalizationsDelegate<WithdrawLocalizations> {
  const _WithdrawLocalizationsDelegate();

  @override
  Future<WithdrawLocalizations> load(Locale locale) {
    return SynchronousFuture<WithdrawLocalizations>(lookupWithdrawLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_WithdrawLocalizationsDelegate old) => false;
}

WithdrawLocalizations lookupWithdrawLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return WithdrawLocalizationsAr();
    case 'en': return WithdrawLocalizationsEn();
  }

  throw FlutterError(
    'WithdrawLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
