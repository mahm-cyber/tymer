import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'component_library_localizations_ar.dart';
import 'component_library_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ComponentLibraryLocalizations
/// returned by `ComponentLibraryLocalizations.of(context)`.
///
/// Applications need to include `ComponentLibraryLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/component_library_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ComponentLibraryLocalizations.localizationsDelegates,
///   supportedLocales: ComponentLibraryLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ComponentLibraryLocalizations.supportedLocales
/// property.
abstract class ComponentLibraryLocalizations {
  ComponentLibraryLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ComponentLibraryLocalizations of(BuildContext context) {
    return Localizations.of<ComponentLibraryLocalizations>(context, ComponentLibraryLocalizations)!;
  }

  static const LocalizationsDelegate<ComponentLibraryLocalizations> delegate = _ComponentLibraryLocalizationsDelegate();

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

  /// No description provided for @invalidCredentialsErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Incorrect phone or password'**
  String get invalidCredentialsErrorMessage;

  /// No description provided for @requiredFieldErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Required*'**
  String get requiredFieldErrorMessage;

  /// No description provided for @emailTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTextFieldLabel;

  /// No description provided for @invalidEmailFormatErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormatErrorMessage;

  /// No description provided for @passwordTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldLabel;

  /// No description provided for @forgotMyPasswordButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotMyPasswordButtonLabel;

  /// No description provided for @signInButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButtonLabel;

  /// No description provided for @signInInProgressButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Signing In'**
  String get signInInProgressButtonLabel;

  /// No description provided for @cancelButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// No description provided for @applyButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyButtonLabel;

  /// No description provided for @emptyListIndicatorText.
  ///
  /// In en, this message translates to:
  /// **'No items available'**
  String get emptyListIndicatorText;

  /// No description provided for @generalExceptionMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again later'**
  String get generalExceptionMessage;

  /// No description provided for @tryAgainButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgainButtonLabel;

  /// No description provided for @successSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Operation completed successfully.'**
  String get successSnackBarMessage;

  /// No description provided for @noInternetConnectionSnackBarErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network settings.'**
  String get noInternetConnectionSnackBarErrorMessage;

  /// No description provided for @unAuthSnackBarErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'You must login first.'**
  String get unAuthSnackBarErrorMessage;

  /// No description provided for @reservedForTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Reserved For'**
  String get reservedForTextFieldLabel;

  /// No description provided for @reservationServiceCategoryTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Category'**
  String get reservationServiceCategoryTextFieldLabel;

  /// No description provided for @timeTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeTextFieldLabel;

  /// No description provided for @dateTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateTextFieldLabel;

  /// No description provided for @placeNameTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Place Name'**
  String get placeNameTextFieldLabel;

  /// No description provided for @placeAddressTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Place Address'**
  String get placeAddressTextFieldLabel;

  /// No description provided for @locationTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTextFieldLabel;

  /// No description provided for @priceTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceTextFieldLabel;

  /// No description provided for @additionalCommentsTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Comments'**
  String get additionalCommentsTextFieldLabel;

  /// No description provided for @acceptButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get acceptButtonLabel;

  /// No description provided for @distanceToServiceLocation.
  ///
  /// In en, this message translates to:
  /// **'{meters} meters'**
  String distanceToServiceLocation(String meters);

  /// No description provided for @myLocationInfoWindowTitle.
  ///
  /// In en, this message translates to:
  /// **'My Location'**
  String get myLocationInfoWindowTitle;

  /// No description provided for @viewOnMapButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewOnMapButtonLabel;

  /// No description provided for @serviceRequestDetailsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get serviceRequestDetailsTileTitle;

  /// No description provided for @pendingServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingServiceRequestStatus;

  /// No description provided for @inProgressServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressServiceRequestStatus;

  /// No description provided for @completedServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedServiceRequestStatus;

  /// No description provided for @canceledServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceledServiceRequestStatus;

  /// No description provided for @pendingReviewServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get pendingReviewServiceRequestStatus;

  /// No description provided for @disputedServiceRequestStatus.
  ///
  /// In en, this message translates to:
  /// **'Disputed'**
  String get disputedServiceRequestStatus;

  /// No description provided for @viewButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewButtonLabel;

  /// No description provided for @requesterServiceRequestsFetchMode.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get requesterServiceRequestsFetchMode;

  /// No description provided for @providerServiceRequestsFetchMode.
  ///
  /// In en, this message translates to:
  /// **'Provided'**
  String get providerServiceRequestsFetchMode;

  /// No description provided for @pendingReviewDisputeStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get pendingReviewDisputeStatus;

  /// No description provided for @timeInPastErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Time cannot be in the past.'**
  String get timeInPastErrorMessage;

  /// No description provided for @serviceFeesContainerLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Fee'**
  String get serviceFeesContainerLabel;

  /// No description provided for @servicePriceContainerLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Price'**
  String get servicePriceContainerLabel;

  /// No description provided for @serviceTotalPriceContainerLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Total Price'**
  String get serviceTotalPriceContainerLabel;

  /// No description provided for @openFileSnackBarActionLabel.
  ///
  /// In en, this message translates to:
  /// **'Open File'**
  String get openFileSnackBarActionLabel;

  /// No description provided for @downloadSuccessSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Download completed successfully!'**
  String get downloadSuccessSnackBarMessage;

  /// No description provided for @downloadFailedSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Download failed. Please try again.'**
  String get downloadFailedSnackBarMessage;

  /// No description provided for @reservationNumberTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Reservation Number'**
  String get reservationNumberTextFieldLabel;

  /// No description provided for @additionalNotesTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes'**
  String get additionalNotesTextFieldLabel;

  /// No description provided for @serviceResponseDetailsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Response Details'**
  String get serviceResponseDetailsTileTitle;

  /// No description provided for @eyptianPoundLetters.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get eyptianPoundLetters;

  /// No description provided for @refundedRequesterLabel.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get refundedRequesterLabel;

  /// No description provided for @deniedRequesterLabel.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get deniedRequesterLabel;

  /// No description provided for @providerLostDisputeLabel.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get providerLostDisputeLabel;

  /// No description provided for @providerWonDisputeLabel.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get providerWonDisputeLabel;

  /// No description provided for @serviceIdTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get serviceIdTextFieldLabel;

  /// No description provided for @bankCard.
  ///
  /// In en, this message translates to:
  /// **'Bank Card'**
  String get bankCard;

  /// No description provided for @vodafoneCash.
  ///
  /// In en, this message translates to:
  /// **'Vodafone Cash'**
  String get vodafoneCash;

  /// No description provided for @orangeCash.
  ///
  /// In en, this message translates to:
  /// **'Orange Cash'**
  String get orangeCash;

  /// No description provided for @etisalatCash.
  ///
  /// In en, this message translates to:
  /// **'Etisalat Cash'**
  String get etisalatCash;

  /// No description provided for @instaPay.
  ///
  /// In en, this message translates to:
  /// **'InstaPay'**
  String get instaPay;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bankTransfer;
}

class _ComponentLibraryLocalizationsDelegate extends LocalizationsDelegate<ComponentLibraryLocalizations> {
  const _ComponentLibraryLocalizationsDelegate();

  @override
  Future<ComponentLibraryLocalizations> load(Locale locale) {
    return SynchronousFuture<ComponentLibraryLocalizations>(lookupComponentLibraryLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ComponentLibraryLocalizationsDelegate old) => false;
}

ComponentLibraryLocalizations lookupComponentLibraryLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return ComponentLibraryLocalizationsAr();
    case 'en': return ComponentLibraryLocalizationsEn();
  }

  throw FlutterError(
    'ComponentLibraryLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
