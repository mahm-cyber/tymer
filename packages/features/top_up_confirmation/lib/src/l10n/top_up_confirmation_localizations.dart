import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'top_up_confirmation_localizations_ar.dart';
import 'top_up_confirmation_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of TopUpConfirmationLocalizations
/// returned by `TopUpConfirmationLocalizations.of(context)`.
///
/// Applications need to include `TopUpConfirmationLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/top_up_confirmation_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TopUpConfirmationLocalizations.localizationsDelegates,
///   supportedLocales: TopUpConfirmationLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the TopUpConfirmationLocalizations.supportedLocales
/// property.
abstract class TopUpConfirmationLocalizations {
  TopUpConfirmationLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TopUpConfirmationLocalizations of(BuildContext context) {
    return Localizations.of<TopUpConfirmationLocalizations>(context, TopUpConfirmationLocalizations)!;
  }

  static const LocalizationsDelegate<TopUpConfirmationLocalizations> delegate = _TopUpConfirmationLocalizationsDelegate();

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
  /// **'Top Up Confirmation'**
  String get appBarTitle;

  /// No description provided for @amountTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountTextFieldLabel;

  /// No description provided for @invalidAmountFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidAmountFormatErrorMessage;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @confirmButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButtonLabel;

  /// No description provided for @confirmingButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirming...'**
  String get confirmingButtonLabel;

  /// No description provided for @walletNumberTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet Number'**
  String get walletNumberTextFieldLabel;

  /// No description provided for @instantPaymentAddressTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Instant Payment Address'**
  String get instantPaymentAddressTextFieldLabel;

  /// No description provided for @isNotEgyptianMobileErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get isNotEgyptianMobileErrorMessage;

  /// No description provided for @teldaUsernameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Telda Username'**
  String get teldaUsernameTextFieldLabel;

  /// No description provided for @isNotGreaterThanZeroTextFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 0'**
  String get isNotGreaterThanZeroTextFieldErrorMessage;
}

class _TopUpConfirmationLocalizationsDelegate extends LocalizationsDelegate<TopUpConfirmationLocalizations> {
  const _TopUpConfirmationLocalizationsDelegate();

  @override
  Future<TopUpConfirmationLocalizations> load(Locale locale) {
    return SynchronousFuture<TopUpConfirmationLocalizations>(lookupTopUpConfirmationLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TopUpConfirmationLocalizationsDelegate old) => false;
}

TopUpConfirmationLocalizations lookupTopUpConfirmationLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return TopUpConfirmationLocalizationsAr();
    case 'en': return TopUpConfirmationLocalizationsEn();
  }

  throw FlutterError(
    'TopUpConfirmationLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
