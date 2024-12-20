import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'order_history_localizations_ar.dart';
import 'order_history_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of OrderHistoryLocalizations
/// returned by `OrderHistoryLocalizations.of(context)`.
///
/// Applications need to include `OrderHistoryLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/order_history_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: OrderHistoryLocalizations.localizationsDelegates,
///   supportedLocales: OrderHistoryLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the OrderHistoryLocalizations.supportedLocales
/// property.
abstract class OrderHistoryLocalizations {
  OrderHistoryLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static OrderHistoryLocalizations of(BuildContext context) {
    return Localizations.of<OrderHistoryLocalizations>(context, OrderHistoryLocalizations)!;
  }

  static const LocalizationsDelegate<OrderHistoryLocalizations> delegate = _OrderHistoryLocalizationsDelegate();

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

  /// No description provided for @fabLabel.
  ///
  /// In en, this message translates to:
  /// **'Disputes'**
  String get fabLabel;
}

class _OrderHistoryLocalizationsDelegate extends LocalizationsDelegate<OrderHistoryLocalizations> {
  const _OrderHistoryLocalizationsDelegate();

  @override
  Future<OrderHistoryLocalizations> load(Locale locale) {
    return SynchronousFuture<OrderHistoryLocalizations>(lookupOrderHistoryLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_OrderHistoryLocalizationsDelegate old) => false;
}

OrderHistoryLocalizations lookupOrderHistoryLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return OrderHistoryLocalizationsAr();
    case 'en': return OrderHistoryLocalizationsEn();
  }

  throw FlutterError(
    'OrderHistoryLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
