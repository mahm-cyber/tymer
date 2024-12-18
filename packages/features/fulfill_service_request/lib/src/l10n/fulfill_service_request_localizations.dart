import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'fulfill_service_request_localizations_ar.dart';
import 'fulfill_service_request_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FulfillServiceRequestLocalizations
/// returned by `FulfillServiceRequestLocalizations.of(context)`.
///
/// Applications need to include `FulfillServiceRequestLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/fulfill_service_request_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FulfillServiceRequestLocalizations.localizationsDelegates,
///   supportedLocales: FulfillServiceRequestLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FulfillServiceRequestLocalizations.supportedLocales
/// property.
abstract class FulfillServiceRequestLocalizations {
  FulfillServiceRequestLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FulfillServiceRequestLocalizations of(BuildContext context) {
    return Localizations.of<FulfillServiceRequestLocalizations>(context, FulfillServiceRequestLocalizations)!;
  }

  static const LocalizationsDelegate<FulfillServiceRequestLocalizations> delegate = _FulfillServiceRequestLocalizationsDelegate();

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

  /// No description provided for @submitButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButtonLabel;

  /// No description provided for @serviceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get serviceDetailsTitle;

  /// No description provided for @bottomSheetGalleryButton.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get bottomSheetGalleryButton;

  /// No description provided for @bottomSheetCaptureButton.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get bottomSheetCaptureButton;

  /// No description provided for @imageTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get imageTextFieldLabel;

  /// No description provided for @additionalDetailsTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetailsTextFieldLabel;

  /// No description provided for @reservationNumberTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Number'**
  String get reservationNumberTextFieldLabel;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @timeTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeTextFieldLabel;

  /// No description provided for @dayTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayTextFieldLabel;

  /// No description provided for @serviceRequestSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Request fulfilled successfully'**
  String get serviceRequestSuccessMessage;

  /// No description provided for @serviceRequestFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed, try again'**
  String get serviceRequestFailureMessage;

  /// No description provided for @backHomeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backHomeButtonLabel;

  /// No description provided for @serviceFeesContainerLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Fees'**
  String get serviceFeesContainerLabel;

  /// No description provided for @awaitingConfirmationButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Awaiting Confirmation'**
  String get awaitingConfirmationButtonLabel;
}

class _FulfillServiceRequestLocalizationsDelegate extends LocalizationsDelegate<FulfillServiceRequestLocalizations> {
  const _FulfillServiceRequestLocalizationsDelegate();

  @override
  Future<FulfillServiceRequestLocalizations> load(Locale locale) {
    return SynchronousFuture<FulfillServiceRequestLocalizations>(lookupFulfillServiceRequestLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FulfillServiceRequestLocalizationsDelegate old) => false;
}

FulfillServiceRequestLocalizations lookupFulfillServiceRequestLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return FulfillServiceRequestLocalizationsAr();
    case 'en': return FulfillServiceRequestLocalizationsEn();
  }

  throw FlutterError(
    'FulfillServiceRequestLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
