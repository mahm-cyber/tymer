import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'payment_history_localizations_ar.dart';
import 'payment_history_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of PaymentHistoryLocalizations
/// returned by `PaymentHistoryLocalizations.of(context)`.
///
/// Applications need to include `PaymentHistoryLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/payment_history_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PaymentHistoryLocalizations.localizationsDelegates,
///   supportedLocales: PaymentHistoryLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the PaymentHistoryLocalizations.supportedLocales
/// property.
abstract class PaymentHistoryLocalizations {
  PaymentHistoryLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PaymentHistoryLocalizations of(BuildContext context) {
    return Localizations.of<PaymentHistoryLocalizations>(context, PaymentHistoryLocalizations)!;
  }

  static const LocalizationsDelegate<PaymentHistoryLocalizations> delegate = _PaymentHistoryLocalizationsDelegate();

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

  /// No description provided for @noTopupPaymentsText.
  ///
  /// In en, this message translates to:
  /// **'No topups available'**
  String get noTopupPaymentsText;

  /// No description provided for @noWithdrawalPaymentsText.
  ///
  /// In en, this message translates to:
  /// **'No withdrawals available'**
  String get noWithdrawalPaymentsText;

  /// No description provided for @topupHistoryAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Topup History'**
  String get topupHistoryAppBarTitle;

  /// No description provided for @withdrawHistoryAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal History'**
  String get withdrawHistoryAppBarTitle;

  /// No description provided for @ibanNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get ibanNumberLabel;

  /// No description provided for @beneficiaryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary'**
  String get beneficiaryNameLabel;

  /// No description provided for @walletNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletNumberLabel;

  /// No description provided for @instantPaymentAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'InstaPay'**
  String get instantPaymentAddressLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;
}

class _PaymentHistoryLocalizationsDelegate extends LocalizationsDelegate<PaymentHistoryLocalizations> {
  const _PaymentHistoryLocalizationsDelegate();

  @override
  Future<PaymentHistoryLocalizations> load(Locale locale) {
    return SynchronousFuture<PaymentHistoryLocalizations>(lookupPaymentHistoryLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_PaymentHistoryLocalizationsDelegate old) => false;
}

PaymentHistoryLocalizations lookupPaymentHistoryLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return PaymentHistoryLocalizationsAr();
    case 'en': return PaymentHistoryLocalizationsEn();
  }

  throw FlutterError(
    'PaymentHistoryLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
