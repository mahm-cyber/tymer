import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'provide_service_localizations_ar.dart';
import 'provide_service_localizations_en.dart';

// ignore_for_file: type=lint

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

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Requests List'**
  String get appBarTitle;

  /// No description provided for @distanceToServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'{meters} meters'**
  String distanceToServiceLocation(String meters);

  /// No description provided for @noServiceRequestsText.
  ///
  /// In en, this message translates to:
  /// **'No service requests available'**
  String get noServiceRequestsText;

  /// No description provided for @showInMapButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Show in Map'**
  String get showInMapButtonLabel;

  /// No description provided for @viewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewButtonLabel;

  /// No description provided for @userHasRunningServiceRequestSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'You have a running service request. Please complete it before providing a new one'**
  String get userHasRunningServiceRequestSnackBarMessage;

  /// No description provided for @locationDataFailureSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location data. Please try again later'**
  String get locationDataFailureSnackBarMessage;

  /// No description provided for @showInListViewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Show in List View'**
  String get showInListViewButtonLabel;

  /// No description provided for @distanceToServiceLocationBottomSheetText.
  ///
  /// In en, this message translates to:
  /// **'Tymer uses straight line walking distance between your current location and the service’s location, so distance might be different when the location is viewed on an external maps application.'**
  String get distanceToServiceLocationBottomSheetText;
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
