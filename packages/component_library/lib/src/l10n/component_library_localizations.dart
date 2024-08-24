import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'component_library_localizations_ar.dart';
import 'component_library_localizations_en.dart';

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
  /// **'Incorrect email or password'**
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

  /// No description provided for @selectAllButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAllButtonLabel;

  /// No description provided for @sortBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort Options'**
  String get sortBottomSheetTitle;

  /// No description provided for @lastAddedTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Last Added'**
  String get lastAddedTileTitle;

  /// No description provided for @alphabeticalTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get alphabeticalTileTitle;

  /// No description provided for @highPriorityTileTitle.
  ///
  /// In en, this message translates to:
  /// **'High Priority'**
  String get highPriorityTileTitle;

  /// No description provided for @lowPriorityTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Low Priority'**
  String get lowPriorityTileTitle;

  /// No description provided for @lastModifiedTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Last Modified'**
  String get lastModifiedTileTitle;

  /// No description provided for @emptyActivityLogListIndicator.
  ///
  /// In en, this message translates to:
  /// **'No activity logs available'**
  String get emptyActivityLogListIndicator;

  /// No description provided for @tabOneName.
  ///
  /// In en, this message translates to:
  /// **'Activity Log'**
  String get tabOneName;

  /// No description provided for @tabTwoName.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get tabTwoName;

  /// No description provided for @tabThreeName.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tabThreeName;

  /// No description provided for @tabFourName.
  ///
  /// In en, this message translates to:
  /// **'Log Activity'**
  String get tabFourName;

  /// No description provided for @taskExpansionTitleTitle.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get taskExpansionTitleTitle;

  /// No description provided for @commentWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Comment by'**
  String get commentWidgetTitle;

  /// No description provided for @emptyHistoryLogListIndicator.
  ///
  /// In en, this message translates to:
  /// **'No history available'**
  String get emptyHistoryLogListIndicator;

  /// No description provided for @addCommentTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addCommentTextFieldLabel;

  /// No description provided for @commentsExpansionTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commentsExpansionTileTitle;

  /// No description provided for @emptyCommentsExpansionTileIndicator.
  ///
  /// In en, this message translates to:
  /// **'No comments available'**
  String get emptyCommentsExpansionTileIndicator;

  /// No description provided for @callLogTypeText.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callLogTypeText;

  /// No description provided for @emailLogTypeText.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLogTypeText;

  /// No description provided for @meetingLogTypeText.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meetingLogTypeText;

  /// No description provided for @textLogTypeText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textLogTypeText;

  /// No description provided for @otherLogTypeText.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherLogTypeText;

  /// No description provided for @noteWidgetTitle.
  ///
  /// In en, this message translates to:
  /// **'Note by'**
  String get noteWidgetTitle;

  /// No description provided for @emptyNoteLogListIndicator.
  ///
  /// In en, this message translates to:
  /// **'No notes available'**
  String get emptyNoteLogListIndicator;

  /// No description provided for @taskWidgetTitleKey.
  ///
  /// In en, this message translates to:
  /// **'Task created by'**
  String get taskWidgetTitleKey;

  /// No description provided for @datePickerBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get datePickerBottomSheetTitle;

  /// No description provided for @assigneeBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Assignee'**
  String get assigneeBottomSheetTitle;

  /// No description provided for @assigneeSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Users'**
  String get assigneeSearchTextFieldLabel;

  /// No description provided for @filterBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Options'**
  String get filterBottomSheetTitle;

  /// No description provided for @dateTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateTileTitle;

  /// No description provided for @companyTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyTileTitle;

  /// No description provided for @taskTypeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Type'**
  String get taskTypeTileTitle;

  /// No description provided for @emailTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTileTitle;

  /// No description provided for @lifeCycleTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Life Cycle'**
  String get lifeCycleTileTitle;

  /// No description provided for @secondaryFilterBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Secondary Filter Options'**
  String get secondaryFilterBottomSheetTitle;

  /// No description provided for @allTileTitle.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTileTitle;

  /// No description provided for @addedByMeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Added by Me'**
  String get addedByMeTileTitle;

  /// No description provided for @archivedTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archivedTileTitle;

  /// No description provided for @unassignedTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassignedTileTitle;

  /// No description provided for @assigneeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignee'**
  String get assigneeTileTitle;

  /// No description provided for @priorityTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityTileTitle;

  /// No description provided for @taskStatusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Status'**
  String get taskStatusTileTitle;

  /// No description provided for @priorityBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Priority'**
  String get priorityBottomSheetTitle;

  /// No description provided for @prioritySearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Priority'**
  String get prioritySearchTextFieldLabel;

  /// No description provided for @taskStatusBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Task Status'**
  String get taskStatusBottomSheetTitle;

  /// No description provided for @taskStatusSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Task Status'**
  String get taskStatusSearchTextFieldLabel;

  /// No description provided for @onTrackTaskStatusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'On Track'**
  String get onTrackTaskStatusTileTitle;

  /// No description provided for @dueTaskStatusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get dueTaskStatusTileTitle;

  /// No description provided for @overdueTaskStatusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdueTaskStatusTileTitle;

  /// No description provided for @completedTaskStatusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedTaskStatusTileTitle;

  /// No description provided for @taskTypeBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Task Type'**
  String get taskTypeBottomSheetTitle;

  /// No description provided for @taskTypeSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Search Task Type'**
  String get taskTypeSearchTextFieldLabel;

  /// No description provided for @callTaskTypeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get callTaskTypeTileTitle;

  /// No description provided for @meetingTaskTypeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get meetingTaskTypeTileTitle;

  /// No description provided for @messageTaskTypeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageTaskTypeTileTitle;

  /// No description provided for @emailTaskTypeTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTaskTypeTileTitle;

  /// No description provided for @activeInactiveStatusSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Active/Inactive Status'**
  String get activeInactiveStatusSearchTextFieldLabel;

  /// No description provided for @jobTitleBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitleBottomSheetTitle;

  /// No description provided for @dealStageTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Deal Stage'**
  String get dealStageTileTitle;

  /// No description provided for @userBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userBottomSheetTitle;

  /// No description provided for @dealStageBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Deal Stage'**
  String get dealStageBottomSheetTitle;

  /// No description provided for @creatorTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get creatorTileTitle;

  /// No description provided for @jobTitleTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitleTileTitle;

  /// No description provided for @activeInactiveStatusBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Active/Inactive Status'**
  String get activeInactiveStatusBottomSheetTitle;

  /// No description provided for @jobTitleSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitleSearchTextFieldLabel;

  /// No description provided for @statusTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusTileTitle;

  /// No description provided for @lifeCycleBottomSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Life Cycle'**
  String get lifeCycleBottomSheetTitle;

  /// No description provided for @userSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userSearchTextFieldLabel;

  /// No description provided for @lifeCycleSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Life Cycle'**
  String get lifeCycleSearchTextFieldLabel;

  /// No description provided for @dealStageSearchTextFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Deal Stage'**
  String get dealStageSearchTextFieldLabel;

  /// No description provided for @noInternetConnectionSnackBarErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network settings.'**
  String get noInternetConnectionSnackBarErrorMessage;

  /// No description provided for @userExpiredSnackBarErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Your membership has expired'**
  String get userExpiredSnackBarErrorMessage;

  /// No description provided for @contactsCustomDropdownLabel.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsCustomDropdownLabel;

  /// No description provided for @dealsCustomDropdownLabel.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get dealsCustomDropdownLabel;

  /// No description provided for @companiesCustomDropdownLabel.
  ///
  /// In en, this message translates to:
  /// **'Companies'**
  String get companiesCustomDropdownLabel;

  /// No description provided for @successSnackBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Operation was successful.'**
  String get successSnackBarMessage;

  /// No description provided for @emptyTaskLogListIndicator.
  ///
  /// In en, this message translates to:
  /// **'No tasks available'**
  String get emptyTaskLogListIndicator;
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
