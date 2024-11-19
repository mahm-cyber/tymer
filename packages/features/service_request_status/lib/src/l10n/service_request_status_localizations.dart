import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'service_request_status_localizations_ar.dart';
import 'service_request_status_localizations_en.dart';

/// Callers can lookup localized strings with an instance of ServiceRequestStatusLocalizations
/// returned by `ServiceRequestStatusLocalizations.of(context)`.
///
/// Applications need to include `ServiceRequestStatusLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/service_request_status_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ServiceRequestStatusLocalizations.localizationsDelegates,
///   supportedLocales: ServiceRequestStatusLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ServiceRequestStatusLocalizations.supportedLocales
/// property.
abstract class ServiceRequestStatusLocalizations {
  ServiceRequestStatusLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ServiceRequestStatusLocalizations of(BuildContext context) {
    return Localizations.of<ServiceRequestStatusLocalizations>(context, ServiceRequestStatusLocalizations)!;
  }

  static const LocalizationsDelegate<ServiceRequestStatusLocalizations> delegate = _ServiceRequestStatusLocalizationsDelegate();

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
  /// **'Request Status'**
  String get appBarTitle;

  /// No description provided for @findingSomeoneStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Finding Someone'**
  String get findingSomeoneStepTitle;

  /// No description provided for @processingStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processingStepTitle;

  /// No description provided for @completeStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get completeStepTitle;

  /// No description provided for @requestDoneContainerTitle.
  ///
  /// In en, this message translates to:
  /// **'Is your request done?'**
  String get requestDoneContainerTitle;

  /// No description provided for @yesButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesButtonLabel;

  /// No description provided for @noButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noButtonLabel;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @cancellationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request has been cancelled'**
  String get cancellationSuccessMessage;

  /// No description provided for @cancellationErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There was an error cancelling your request'**
  String get cancellationErrorMessage;

  /// No description provided for @confirmationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request has been confirmed'**
  String get confirmationSuccessMessage;

  /// No description provided for @confirmationErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'There was an error confirming your request'**
  String get confirmationErrorMessage;

  /// No description provided for @backHomeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backHomeButtonLabel;
}

class _ServiceRequestStatusLocalizationsDelegate extends LocalizationsDelegate<ServiceRequestStatusLocalizations> {
  const _ServiceRequestStatusLocalizationsDelegate();

  @override
  Future<ServiceRequestStatusLocalizations> load(Locale locale) {
    return SynchronousFuture<ServiceRequestStatusLocalizations>(lookupServiceRequestStatusLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ServiceRequestStatusLocalizationsDelegate old) => false;
}

ServiceRequestStatusLocalizations lookupServiceRequestStatusLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ServiceRequestStatusLocalizationsAr();
    case 'en': return ServiceRequestStatusLocalizationsEn();
  }

  throw FlutterError(
    'ServiceRequestStatusLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
