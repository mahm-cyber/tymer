import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'provide_service_localizations_ar.dart';
import 'provide_service_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ProvideServiceLocalizations
/// returned by `ProvideServiceLocalizations.of(context)`.
///
/// Applications need to include `ProvideServiceLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/provide_service_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProvideServiceLocalizations.localizationsDelegates,
///   supportedLocales: ProvideServiceLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ProvideServiceLocalizations.supportedLocales
/// property.
abstract class ProvideServiceLocalizations {
  ProvideServiceLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProvideServiceLocalizations of(BuildContext context) {
    return Localizations.of<ProvideServiceLocalizations>(context, ProvideServiceLocalizations)!;
  }

  static const LocalizationsDelegate<ProvideServiceLocalizations> delegate = _ProvideServiceLocalizationsDelegate();

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

  /// No description provided for @reservationServiceTypeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting List'**
  String get reservationServiceTypeAppBarTitle;

  /// No description provided for @otherServiceTypeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Other Request'**
  String get otherServiceTypeAppBarTitle;

  /// No description provided for @addressTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Address*'**
  String get addressTextFieldLabel;

  /// No description provided for @datePickerTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date*'**
  String get datePickerTextFieldLabel;

  /// No description provided for @placeNameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Place Name*'**
  String get placeNameTextFieldLabel;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredFieldErrorMessage;

  /// No description provided for @reservationNameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Name*'**
  String get reservationNameTextFieldLabel;

  /// No description provided for @locationPickingCompletedButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get locationPickingCompletedButton;

  /// No description provided for @locationPickerTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Pick Location*'**
  String get locationPickerTextFieldLabel;

  /// No description provided for @locationPickedTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Location Picked'**
  String get locationPickedTextFieldLabel;

  /// No description provided for @pricePickerTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get pricePickerTextFieldLabel;

  /// No description provided for @requestServiceButtonInProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Requesting...'**
  String get requestServiceButtonInProgressLabel;

  /// No description provided for @requestServiceButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Request Service'**
  String get requestServiceButtonLabel;
}

class _ProvideServiceLocalizationsDelegate extends LocalizationsDelegate<ProvideServiceLocalizations> {
  const _ProvideServiceLocalizationsDelegate();

  @override
  Future<ProvideServiceLocalizations> load(Locale locale) {
    return SynchronousFuture<ProvideServiceLocalizations>(lookupProvideServiceLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ProvideServiceLocalizationsDelegate old) => false;
}

ProvideServiceLocalizations lookupProvideServiceLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ProvideServiceLocalizationsAr();
    case 'en': return ProvideServiceLocalizationsEn();
  }

  throw FlutterError(
    'ProvideServiceLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
