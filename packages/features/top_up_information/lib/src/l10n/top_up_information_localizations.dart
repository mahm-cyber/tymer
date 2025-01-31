import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'top_up_information_localizations_ar.dart';
import 'top_up_information_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of TopUpInformationLocalizations
/// returned by `TopUpInformationLocalizations.of(context)`.
///
/// Applications need to include `TopUpInformationLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/top_up_information_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TopUpInformationLocalizations.localizationsDelegates,
///   supportedLocales: TopUpInformationLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the TopUpInformationLocalizations.supportedLocales
/// property.
abstract class TopUpInformationLocalizations {
  TopUpInformationLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TopUpInformationLocalizations of(BuildContext context) {
    return Localizations.of<TopUpInformationLocalizations>(context, TopUpInformationLocalizations)!;
  }

  static const LocalizationsDelegate<TopUpInformationLocalizations> delegate = _TopUpInformationLocalizationsDelegate();

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
  /// **'Top Up Information'**
  String get appBarTitle;

  /// No description provided for @continueButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonLabel;

  /// No description provided for @bankCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get bankCardNumber;

  /// No description provided for @walletNumber.
  ///
  /// In en, this message translates to:
  /// **'Wallet Number'**
  String get walletNumber;

  /// No description provided for @instantPaymentAddress.
  ///
  /// In en, this message translates to:
  /// **'Instant Payment Address'**
  String get instantPaymentAddress;

  /// No description provided for @beneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Name'**
  String get beneficiaryName;

  /// No description provided for @beneficiaryAddress.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Address'**
  String get beneficiaryAddress;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @swiftCode.
  ///
  /// In en, this message translates to:
  /// **'SWIFT Code'**
  String get swiftCode;

  /// No description provided for @messageAr.
  ///
  /// In en, this message translates to:
  /// **'Message (AR)'**
  String get messageAr;

  /// No description provided for @messageEn.
  ///
  /// In en, this message translates to:
  /// **'Message (EN)'**
  String get messageEn;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get error;
}

class _TopUpInformationLocalizationsDelegate extends LocalizationsDelegate<TopUpInformationLocalizations> {
  const _TopUpInformationLocalizationsDelegate();

  @override
  Future<TopUpInformationLocalizations> load(Locale locale) {
    return SynchronousFuture<TopUpInformationLocalizations>(lookupTopUpInformationLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TopUpInformationLocalizationsDelegate old) => false;
}

TopUpInformationLocalizations lookupTopUpInformationLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TopUpInformationLocalizationsAr();
    case 'en': return TopUpInformationLocalizationsEn();
  }

  throw FlutterError(
    'TopUpInformationLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
