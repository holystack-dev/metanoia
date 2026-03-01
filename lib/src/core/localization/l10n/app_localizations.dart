import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ml'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Metanoia'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get homeTitle;

  /// No description provided for @examineTitle.
  ///
  /// In en, this message translates to:
  /// **'Examine'**
  String get examineTitle;

  /// No description provided for @confessTitle.
  ///
  /// In en, this message translates to:
  /// **'Confess'**
  String get confessTitle;

  /// No description provided for @prayersTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayers'**
  String get prayersTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @examinationTitle.
  ///
  /// In en, this message translates to:
  /// **'Examination'**
  String get examinationTitle;

  /// No description provided for @commandment.
  ///
  /// In en, this message translates to:
  /// **'Commandment'**
  String get commandment;

  /// No description provided for @guideTitle.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guideTitle;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding Confession'**
  String get faqTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get chooseLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get chooseTheme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @getReminded.
  ///
  /// In en, this message translates to:
  /// **'Get reminded to go to confession'**
  String get getReminded;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Reminders'**
  String get enableReminders;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @biweekly.
  ///
  /// In en, this message translates to:
  /// **'Bi-weekly'**
  String get biweekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @remindMe.
  ///
  /// In en, this message translates to:
  /// **'Remind me'**
  String get remindMe;

  /// No description provided for @onTheDay.
  ///
  /// In en, this message translates to:
  /// **'On the day'**
  String get onTheDay;

  /// No description provided for @daysBefore.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day before} other{{count} days before}}'**
  String daysBefore(num count);

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @lastConfession.
  ///
  /// In en, this message translates to:
  /// **'Last Confession'**
  String get lastConfession;

  /// No description provided for @noneYet.
  ///
  /// In en, this message translates to:
  /// **'None yet'**
  String get noneYet;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(num count);

  /// No description provided for @nextReminder.
  ///
  /// In en, this message translates to:
  /// **'Next Reminder'**
  String get nextReminder;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @appLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language for buttons, labels, and menus'**
  String get appLanguageSubtitle;

  /// No description provided for @contentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Content Language'**
  String get contentLanguage;

  /// No description provided for @contentLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language for examination questions, FAQs, and prayers'**
  String get contentLanguageSubtitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @selectDay.
  ///
  /// In en, this message translates to:
  /// **'Select Day'**
  String get selectDay;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selected(num count);

  /// No description provided for @selectedLabel.
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get selectedLabel;

  /// No description provided for @counter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counter;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search commandments or questions...'**
  String get searchPlaceholder;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @noActiveConfession.
  ///
  /// In en, this message translates to:
  /// **'No active confession'**
  String get noActiveConfession;

  /// No description provided for @startExaminationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Start an examination to add sins here.'**
  String get startExaminationPrompt;

  /// No description provided for @startExamination.
  ///
  /// In en, this message translates to:
  /// **'Start Examination'**
  String get startExamination;

  /// No description provided for @finishConfessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish Confession?'**
  String get finishConfessionTitle;

  /// No description provided for @finishConfessionContent.
  ///
  /// In en, this message translates to:
  /// **'This will mark the confession as completed and move it to your history.'**
  String get finishConfessionContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @confessionCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Confession completed! God bless you.'**
  String get confessionCompletedMessage;

  /// No description provided for @finishConfession.
  ///
  /// In en, this message translates to:
  /// **'Finish Confession'**
  String get finishConfession;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @keepHistory.
  ///
  /// In en, this message translates to:
  /// **'Keep Confession History'**
  String get keepHistory;

  /// No description provided for @keepHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your sins along with the date. If disabled, only the date will be saved.'**
  String get keepHistorySubtitle;

  /// No description provided for @deleteConfession.
  ///
  /// In en, this message translates to:
  /// **'Delete Confession'**
  String get deleteConfession;

  /// No description provided for @deleteConfessionContent.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete this confession and all its items from your history. This action cannot be undone.'**
  String get deleteConfessionContent;

  /// No description provided for @tutorialExamineDesc.
  ///
  /// In en, this message translates to:
  /// **'Start here to examine your conscience before confession.'**
  String get tutorialExamineDesc;

  /// No description provided for @tutorialConfessDesc.
  ///
  /// In en, this message translates to:
  /// **'Use this during confession to track your sins.'**
  String get tutorialConfessDesc;

  /// No description provided for @tutorialPrayersDesc.
  ///
  /// In en, this message translates to:
  /// **'Find common prayers for before and after confession.'**
  String get tutorialPrayersDesc;

  /// No description provided for @tutorialGuideDesc.
  ///
  /// In en, this message translates to:
  /// **'Find encouragement, step-by-step confession guide, and FAQs here.'**
  String get tutorialGuideDesc;

  /// No description provided for @tutorialSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience here: change language, theme, set reminders, and manage security settings.'**
  String get tutorialSettingsDesc;

  /// No description provided for @tutorialSwipeDesc.
  ///
  /// In en, this message translates to:
  /// **'Swipe left or right to navigate between commandments.'**
  String get tutorialSwipeDesc;

  /// No description provided for @tutorialSelectDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap any question to select it for your confession.'**
  String get tutorialSelectDesc;

  /// No description provided for @tutorialFinishDesc.
  ///
  /// In en, this message translates to:
  /// **'When done, tap here to finish and proceed to confession.'**
  String get tutorialFinishDesc;

  /// No description provided for @tutorialCounterDesc.
  ///
  /// In en, this message translates to:
  /// **'This shows how many items you\'ve selected for confession.'**
  String get tutorialCounterDesc;

  /// No description provided for @tutorialMenuDesc.
  ///
  /// In en, this message translates to:
  /// **'Access custom sins and clear your selections from here.'**
  String get tutorialMenuDesc;

  /// No description provided for @tutorialPenanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Track penances given by your confessor here.'**
  String get tutorialPenanceDesc;

  /// No description provided for @tutorialInsightsDesc.
  ///
  /// In en, this message translates to:
  /// **'View your confession journey statistics and streaks.'**
  String get tutorialInsightsDesc;

  /// No description provided for @tutorialHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Access your past confessions and their dates.'**
  String get tutorialHistoryDesc;

  /// No description provided for @replayTutorial.
  ///
  /// In en, this message translates to:
  /// **'Replay Tutorial'**
  String get replayTutorial;

  /// No description provided for @replayTutorialDesc.
  ///
  /// In en, this message translates to:
  /// **'View the app tutorial again'**
  String get replayTutorialDesc;

  /// No description provided for @tutorialReset.
  ///
  /// In en, this message translates to:
  /// **'Tutorial reset! You\'ll see the guides again.'**
  String get tutorialReset;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version, license, and source code'**
  String get aboutSubtitle;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @shareAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share with friends and family'**
  String get shareAppSubtitle;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @rateAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rate us on the Play Store'**
  String get rateAppSubtitle;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ by holystack.dev'**
  String get madeWithLove;

  /// No description provided for @rateDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying Metanoia?'**
  String get rateDialogTitle;

  /// No description provided for @rateDialogContent.
  ///
  /// In en, this message translates to:
  /// **'If you find this app helpful, please take a moment to rate it. It helps us a lot!'**
  String get rateDialogContent;

  /// No description provided for @rateDialogYes.
  ///
  /// In en, this message translates to:
  /// **'Rate Now'**
  String get rateDialogYes;

  /// No description provided for @rateDialogNo.
  ///
  /// In en, this message translates to:
  /// **'No, thanks'**
  String get rateDialogNo;

  /// No description provided for @rateDialogLater.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get rateDialogLater;

  /// No description provided for @greekLabel.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get greekLabel;

  /// No description provided for @nounLabel.
  ///
  /// In en, this message translates to:
  /// **'noun'**
  String get nounLabel;

  /// No description provided for @metanoiaDefinition.
  ///
  /// In en, this message translates to:
  /// **'A profound change of mind and heart; a spiritual awakening that transforms one\'s entire being and redirects their life toward God.'**
  String get metanoiaDefinition;

  /// No description provided for @turnBackToGrace.
  ///
  /// In en, this message translates to:
  /// **'Turn Back to Grace'**
  String get turnBackToGrace;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your guide for a meaningful confession'**
  String get welcomeSubtitle;

  /// No description provided for @discoverInnerGrace.
  ///
  /// In en, this message translates to:
  /// **'Discover Inner Grace'**
  String get discoverInnerGrace;

  /// No description provided for @sacredJourneyBegins.
  ///
  /// In en, this message translates to:
  /// **'A sacred journey of reconciliation begins.'**
  String get sacredJourneyBegins;

  /// No description provided for @beginJourney.
  ///
  /// In en, this message translates to:
  /// **'Begin Journey'**
  String get beginJourney;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @chooseContentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Content Language'**
  String get chooseContentLanguage;

  /// No description provided for @contentLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Select language for prayers, conscience examination, and guides'**
  String get contentLanguageDescription;

  /// No description provided for @changeAnytimeNote.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in Settings'**
  String get changeAnytimeNote;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @examineDescription.
  ///
  /// In en, this message translates to:
  /// **'Examine your conscience using the Ten Commandments before confession'**
  String get examineDescription;

  /// No description provided for @confessDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your sins during confession to ensure nothing is forgotten'**
  String get confessDescription;

  /// No description provided for @prayersDescription.
  ///
  /// In en, this message translates to:
  /// **'Access prayers for before and after confession, and penance prayers'**
  String get prayersDescription;

  /// No description provided for @remindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Set regular reminders in Settings so you never forget to go to confession'**
  String get remindersDescription;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @customSins.
  ///
  /// In en, this message translates to:
  /// **'Custom Sins'**
  String get customSins;

  /// No description provided for @manageCustomSins.
  ///
  /// In en, this message translates to:
  /// **'Manage Custom Sins'**
  String get manageCustomSins;

  /// No description provided for @addCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Sin'**
  String get addCustomSin;

  /// No description provided for @editCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Edit Custom Sin'**
  String get editCustomSin;

  /// No description provided for @deleteCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Delete Custom Sin'**
  String get deleteCustomSin;

  /// No description provided for @sinDescription.
  ///
  /// In en, this message translates to:
  /// **'Sin Description'**
  String get sinDescription;

  /// No description provided for @sinDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the sin you want to remember'**
  String get sinDescriptionHint;

  /// No description provided for @sinDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a sin description'**
  String get sinDescriptionRequired;

  /// No description provided for @optionalNote.
  ///
  /// In en, this message translates to:
  /// **'Optional Note'**
  String get optionalNote;

  /// No description provided for @optionalNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add any additional details'**
  String get optionalNoteHint;

  /// No description provided for @selectCommandment.
  ///
  /// In en, this message translates to:
  /// **'Select Commandment (Optional)'**
  String get selectCommandment;

  /// No description provided for @noCommandment.
  ///
  /// In en, this message translates to:
  /// **'General / No Commandment'**
  String get noCommandment;

  /// No description provided for @customSinAdded.
  ///
  /// In en, this message translates to:
  /// **'Custom sin added'**
  String get customSinAdded;

  /// No description provided for @customSinUpdated.
  ///
  /// In en, this message translates to:
  /// **'Custom sin updated'**
  String get customSinUpdated;

  /// No description provided for @customSinDeleted.
  ///
  /// In en, this message translates to:
  /// **'Custom sin deleted'**
  String get customSinDeleted;

  /// No description provided for @deleteCustomSinConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this custom sin?'**
  String get deleteCustomSinConfirm;

  /// No description provided for @noCustomSins.
  ///
  /// In en, this message translates to:
  /// **'No custom sins yet'**
  String get noCustomSins;

  /// No description provided for @noCustomSinsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add custom sins to personalize your examination'**
  String get noCustomSinsDesc;

  /// No description provided for @customVersion.
  ///
  /// In en, this message translates to:
  /// **'Custom (Edited)'**
  String get customVersion;

  /// No description provided for @searchCustomSins.
  ///
  /// In en, this message translates to:
  /// **'Search custom sins...'**
  String get searchCustomSins;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @addYourOwn.
  ///
  /// In en, this message translates to:
  /// **'Add your own...'**
  String get addYourOwn;

  /// No description provided for @penance.
  ///
  /// In en, this message translates to:
  /// **'Penance'**
  String get penance;

  /// No description provided for @penanceTracker.
  ///
  /// In en, this message translates to:
  /// **'Penance Tracker'**
  String get penanceTracker;

  /// No description provided for @addPenance.
  ///
  /// In en, this message translates to:
  /// **'Add Penance'**
  String get addPenance;

  /// No description provided for @editPenance.
  ///
  /// In en, this message translates to:
  /// **'Edit Penance'**
  String get editPenance;

  /// No description provided for @penanceDescription.
  ///
  /// In en, this message translates to:
  /// **'What penance were you given?'**
  String get penanceDescription;

  /// No description provided for @penanceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Say 3 Hail Marys, Read a Scripture passage...'**
  String get penanceHint;

  /// No description provided for @penanceAdded.
  ///
  /// In en, this message translates to:
  /// **'Penance added'**
  String get penanceAdded;

  /// No description provided for @penanceUpdated.
  ///
  /// In en, this message translates to:
  /// **'Penance updated'**
  String get penanceUpdated;

  /// No description provided for @penanceCompleted.
  ///
  /// In en, this message translates to:
  /// **'Penance completed! God bless you.'**
  String get penanceCompleted;

  /// No description provided for @markAsComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get markAsComplete;

  /// No description provided for @pendingPenances.
  ///
  /// In en, this message translates to:
  /// **'Pending Penances'**
  String get pendingPenances;

  /// No description provided for @noPendingPenances.
  ///
  /// In en, this message translates to:
  /// **'No pending penances'**
  String get noPendingPenances;

  /// No description provided for @noPendingPenancesDesc.
  ///
  /// In en, this message translates to:
  /// **'All your penances are completed. God bless!'**
  String get noPendingPenancesDesc;

  /// No description provided for @completedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed on {date}'**
  String completedOn(Object date);

  /// No description provided for @assignedOn.
  ///
  /// In en, this message translates to:
  /// **'Assigned on {date}'**
  String assignedOn(Object date);

  /// No description provided for @skipPenance.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipPenance;

  /// No description provided for @savePenance.
  ///
  /// In en, this message translates to:
  /// **'Save Penance'**
  String get savePenance;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @confessionInsights.
  ///
  /// In en, this message translates to:
  /// **'Confession Insights'**
  String get confessionInsights;

  /// No description provided for @totalConfessions.
  ///
  /// In en, this message translates to:
  /// **'Total Confessions'**
  String get totalConfessions;

  /// No description provided for @averageFrequency.
  ///
  /// In en, this message translates to:
  /// **'Average Frequency'**
  String get averageFrequency;

  /// No description provided for @everyXDays.
  ///
  /// In en, this message translates to:
  /// **'Every {count} days'**
  String everyXDays(Object count);

  /// No description provided for @daysSinceLastConfession.
  ///
  /// In en, this message translates to:
  /// **'Days Since Last'**
  String get daysSinceLastConfession;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @weeksStreak.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 week} other{{count} weeks}}'**
  String weeksStreak(num count);

  /// No description provided for @monthlyActivity.
  ///
  /// In en, this message translates to:
  /// **'Monthly Activity'**
  String get monthlyActivity;

  /// No description provided for @confessionsThisYear.
  ///
  /// In en, this message translates to:
  /// **'Confessions This Year'**
  String get confessionsThisYear;

  /// No description provided for @noInsightsYet.
  ///
  /// In en, this message translates to:
  /// **'No insights yet'**
  String get noInsightsYet;

  /// No description provided for @noInsightsYetDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first confession to see your spiritual journey stats'**
  String get noInsightsYetDesc;

  /// No description provided for @totalItemsConfessed.
  ///
  /// In en, this message translates to:
  /// **'Total Items Confessed'**
  String get totalItemsConfessed;

  /// No description provided for @firstConfession.
  ///
  /// In en, this message translates to:
  /// **'First Confession'**
  String get firstConfession;

  /// No description provided for @spiritualJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Spiritual Journey'**
  String get spiritualJourney;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listView;

  /// No description provided for @guidedView.
  ///
  /// In en, this message translates to:
  /// **'Guided'**
  String get guidedView;

  /// No description provided for @commandmentProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String commandmentProgress(Object current, Object total);

  /// No description provided for @previousCommandment.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousCommandment;

  /// No description provided for @nextCommandment.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextCommandment;

  /// No description provided for @finishExamination.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishExamination;

  /// No description provided for @noQuestionsSelected.
  ///
  /// In en, this message translates to:
  /// **'No questions selected in this section'**
  String get noQuestionsSelected;

  /// No description provided for @questionsSelectedInSection.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String questionsSelectedInSection(Object count);

  /// No description provided for @examinationSummary.
  ///
  /// In en, this message translates to:
  /// **'Examination Summary'**
  String get examinationSummary;

  /// No description provided for @examinationNote.
  ///
  /// In en, this message translates to:
  /// **'A thorough examination of conscience goes beyond any list. Reflect prayerfully on your state of life and circumstances.'**
  String get examinationNote;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items selected'**
  String selectedCount(Object count);

  /// No description provided for @noSinsSelected.
  ///
  /// In en, this message translates to:
  /// **'No sins selected'**
  String get noSinsSelected;

  /// No description provided for @continueEditing.
  ///
  /// In en, this message translates to:
  /// **'Continue Editing'**
  String get continueEditing;

  /// No description provided for @proceedToConfess.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceedToConfess;

  /// No description provided for @clearDraftTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Draft?'**
  String get clearDraftTitle;

  /// No description provided for @clearDraftMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove all selected questions. Are you sure?'**
  String get clearDraftMessage;

  /// No description provided for @clearDraft.
  ///
  /// In en, this message translates to:
  /// **'Clear Draft'**
  String get clearDraft;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @draftRestored.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Restored 1 item from your last session} other{Restored {count} items from your last session}}'**
  String draftRestored(num count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String minutesAgo(Object count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(Object count);

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @noQuestionsInSection.
  ///
  /// In en, this message translates to:
  /// **'No questions in this section'**
  String get noQuestionsInSection;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skipOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Skip Introduction?'**
  String get skipOnboardingTitle;

  /// No description provided for @skipOnboardingMessage.
  ///
  /// In en, this message translates to:
  /// **'You can always access help and settings later from the app menu.'**
  String get skipOnboardingMessage;

  /// No description provided for @confessionHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Confession History'**
  String get confessionHistoryTitle;

  /// No description provided for @deleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get deleteAll;

  /// No description provided for @editDate.
  ///
  /// In en, this message translates to:
  /// **'Edit Date'**
  String get editDate;

  /// No description provided for @confessionDate.
  ///
  /// In en, this message translates to:
  /// **'Confession Date'**
  String get confessionDate;

  /// No description provided for @dateUpdated.
  ///
  /// In en, this message translates to:
  /// **'Date updated'**
  String get dateUpdated;

  /// No description provided for @changeDateConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Date?'**
  String get changeDateConfirmTitle;

  /// No description provided for @changeDateConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Change confession date to {date}?'**
  String changeDateConfirmMessage(Object date);

  /// No description provided for @noGuideContent.
  ///
  /// In en, this message translates to:
  /// **'No guide content available'**
  String get noGuideContent;

  /// No description provided for @noGuideContentDesc.
  ///
  /// In en, this message translates to:
  /// **'Guide content will appear here'**
  String get noGuideContentDesc;

  /// No description provided for @noFaqContent.
  ///
  /// In en, this message translates to:
  /// **'No FAQs available'**
  String get noFaqContent;

  /// No description provided for @noFaqContentDesc.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions will appear here'**
  String get noFaqContentDesc;

  /// No description provided for @faqSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A guide to the Sacrament of Reconciliation'**
  String get faqSubtitle;

  /// No description provided for @tapToExpand.
  ///
  /// In en, this message translates to:
  /// **'Tap to read more'**
  String get tapToExpand;

  /// No description provided for @continueExamination.
  ///
  /// In en, this message translates to:
  /// **'Continue Examination'**
  String get continueExamination;

  /// No description provided for @continueExaminationDesc.
  ///
  /// In en, this message translates to:
  /// **'You have an examination in progress'**
  String get continueExaminationDesc;

  /// No description provided for @examinationProgress.
  ///
  /// In en, this message translates to:
  /// **'{count} items selected'**
  String examinationProgress(Object count);

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @securitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protect your personal data'**
  String get securitySubtitle;

  /// No description provided for @pinAndBiometric.
  ///
  /// In en, this message translates to:
  /// **'PIN & Biometric'**
  String get pinAndBiometric;

  /// No description provided for @pinAndBiometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure app lock settings'**
  String get pinAndBiometricSubtitle;

  /// No description provided for @enterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPin;

  /// No description provided for @createPin.
  ///
  /// In en, this message translates to:
  /// **'Create PIN'**
  String get createPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @incorrectPin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN'**
  String get incorrectPin;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs don\'t match'**
  String get pinMismatch;

  /// No description provided for @biometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get biometricUnlock;

  /// No description provided for @autoLockTimeout.
  ///
  /// In en, this message translates to:
  /// **'Auto-Lock Timeout'**
  String get autoLockTimeout;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts'**
  String get tooManyAttempts;

  /// No description provided for @tryAgainIn.
  ///
  /// In en, this message translates to:
  /// **'Try again in {time}'**
  String tryAgainIn(Object time);

  /// No description provided for @useBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Use Biometric Unlock'**
  String get useBiometricUnlock;

  /// No description provided for @unlockWithFingerprintOrFace.
  ///
  /// In en, this message translates to:
  /// **'Unlock with fingerprint or face'**
  String get unlockWithFingerprintOrFace;

  /// No description provided for @biometricAccessWarning.
  ///
  /// In en, this message translates to:
  /// **'Anyone with a registered fingerprint or face on this device will be able to access the app'**
  String get biometricAccessWarning;

  /// No description provided for @lockAfter.
  ///
  /// In en, this message translates to:
  /// **'Lock After'**
  String get lockAfter;

  /// No description provided for @timeInBackgroundBeforeLocking.
  ///
  /// In en, this message translates to:
  /// **'Time in background before locking'**
  String get timeInBackgroundBeforeLocking;

  /// No description provided for @changePin.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changePin;

  /// No description provided for @updateYourSecurityPin.
  ///
  /// In en, this message translates to:
  /// **'Update your security PIN'**
  String get updateYourSecurityPin;

  /// No description provided for @enterCurrentPin.
  ///
  /// In en, this message translates to:
  /// **'Enter Current PIN'**
  String get enterCurrentPin;

  /// No description provided for @enterNewPin.
  ///
  /// In en, this message translates to:
  /// **'Enter New PIN'**
  String get enterNewPin;

  /// No description provided for @confirmNewPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm New PIN'**
  String get confirmNewPin;

  /// No description provided for @pinChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'PIN changed successfully'**
  String get pinChangedSuccessfully;

  /// No description provided for @currentPinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Current PIN is incorrect'**
  String get currentPinIncorrect;

  /// No description provided for @enableBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric Unlock?'**
  String get enableBiometricUnlock;

  /// No description provided for @biometricDescription.
  ///
  /// In en, this message translates to:
  /// **'Use your fingerprint or face to unlock the app quickly and securely.'**
  String get biometricDescription;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @setUpPin.
  ///
  /// In en, this message translates to:
  /// **'Set Up PIN'**
  String get setUpPin;

  /// No description provided for @createSixDigitPin.
  ///
  /// In en, this message translates to:
  /// **'Create a 6-digit PIN'**
  String get createSixDigitPin;

  /// No description provided for @pinProtectData.
  ///
  /// In en, this message translates to:
  /// **'This PIN will be used to protect your data'**
  String get pinProtectData;

  /// No description provided for @confirmYourPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get confirmYourPin;

  /// No description provided for @enterSamePinAgain.
  ///
  /// In en, this message translates to:
  /// **'Enter the same PIN again to confirm'**
  String get enterSamePinAgain;

  /// No description provided for @metanoia.
  ///
  /// In en, this message translates to:
  /// **'Metanoia'**
  String get metanoia;

  /// No description provided for @enterPinToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to unlock'**
  String get enterPinToUnlock;

  /// No description provided for @attemptsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 attempt remaining} other{{count} attempts remaining}}'**
  String attemptsRemaining(num count);

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 second} other{{count} seconds}}'**
  String seconds(num count);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute} other{{count} minutes}}'**
  String minutes(num count);

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @confessionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Confession deleted'**
  String get confessionDeleted;

  /// No description provided for @noConfessionHistory.
  ///
  /// In en, this message translates to:
  /// **'No confession history'**
  String get noConfessionHistory;

  /// No description provided for @noConfessionHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Completed confessions will appear here'**
  String get noConfessionHistoryDesc;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @fontSizeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust text size for better readability'**
  String get fontSizeSubtitle;

  /// No description provided for @fontSizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get fontSizeSmall;

  /// No description provided for @fontSizeMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get fontSizeMedium;

  /// No description provided for @fontSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get fontSizeLarge;

  /// No description provided for @fontSizeExtraLarge.
  ///
  /// In en, this message translates to:
  /// **'Extra Large'**
  String get fontSizeExtraLarge;

  /// No description provided for @forgotPin.
  ///
  /// In en, this message translates to:
  /// **'Forgot PIN?'**
  String get forgotPin;

  /// No description provided for @resetPinTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset PIN'**
  String get resetPinTitle;

  /// No description provided for @resetPinWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: This will permanently delete all your data'**
  String get resetPinWarning;

  /// No description provided for @resetPinDescription.
  ///
  /// In en, this message translates to:
  /// **'If you reset your PIN, all your confessions, custom sins, penances, and other personal data will be permanently deleted. This action cannot be undone.'**
  String get resetPinDescription;

  /// No description provided for @resetPinConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm'**
  String get resetPinConfirmation;

  /// No description provided for @resetPinButton.
  ///
  /// In en, this message translates to:
  /// **'Reset PIN & Delete Data'**
  String get resetPinButton;

  /// No description provided for @resetPinSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN reset successfully. Please set up a new PIN.'**
  String get resetPinSuccess;

  /// No description provided for @resetPinError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset PIN. Please try again.'**
  String get resetPinError;

  /// No description provided for @deleteConfirmationText.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get deleteConfirmationText;

  /// No description provided for @resetPinWaitTimer.
  ///
  /// In en, this message translates to:
  /// **'Please wait {seconds} seconds'**
  String resetPinWaitTimer(int seconds);

  /// No description provided for @resetPinBiometricPrompt.
  ///
  /// In en, this message translates to:
  /// **'Verify your identity to reset PIN'**
  String get resetPinBiometricPrompt;

  /// No description provided for @confessionGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Make a Good Confession'**
  String get confessionGuideTitle;

  /// No description provided for @confessionGuideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step guide to the Sacrament'**
  String get confessionGuideSubtitle;

  /// No description provided for @invitationTitle.
  ///
  /// In en, this message translates to:
  /// **'Returning to Confession?'**
  String get invitationTitle;

  /// No description provided for @invitationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A word of encouragement for you'**
  String get invitationSubtitle;

  /// No description provided for @invitationDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get invitationDialogTitle;

  /// No description provided for @invitationDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Is this your first confession in a while, or are you feeling anxious about going?'**
  String get invitationDialogContent;

  /// No description provided for @invitationDialogYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, I\'d like some encouragement'**
  String get invitationDialogYes;

  /// No description provided for @invitationDialogNo.
  ///
  /// In en, this message translates to:
  /// **'No, I\'m ready to begin'**
  String get invitationDialogNo;

  /// No description provided for @invitationDialogDontShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show this again'**
  String get invitationDialogDontShowAgain;

  /// No description provided for @searchPrayers.
  ///
  /// In en, this message translates to:
  /// **'Search prayers...'**
  String get searchPrayers;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategories;

  /// No description provided for @appDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This app is a spiritual aid for confession preparation. It is not a substitute for the Sacrament of Reconciliation with a priest.'**
  String get appDisclaimer;

  /// No description provided for @onboardingDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'A spiritual companion for confession—not a replacement for it.'**
  String get onboardingDisclaimer;

  /// No description provided for @readyToBegin.
  ///
  /// In en, this message translates to:
  /// **'You\'re All Set'**
  String get readyToBegin;

  /// No description provided for @readyToBeginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'May your journey toward reconciliation be filled with grace and peace.'**
  String get readyToBeginSubtitle;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @contentReferences.
  ///
  /// In en, this message translates to:
  /// **'Content References'**
  String get contentReferences;

  /// No description provided for @examinationModeTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to examine?'**
  String get examinationModeTitle;

  /// No description provided for @quickReviewMode.
  ///
  /// In en, this message translates to:
  /// **'Quick Review'**
  String get quickReviewMode;

  /// No description provided for @quickReviewDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan through all questions by category'**
  String get quickReviewDescription;

  /// No description provided for @deepReflectionMode.
  ///
  /// In en, this message translates to:
  /// **'Deep Reflection'**
  String get deepReflectionMode;

  /// No description provided for @deepReflectionDescription.
  ///
  /// In en, this message translates to:
  /// **'One question at a time for thoughtful examination'**
  String get deepReflectionDescription;

  /// No description provided for @contemplativePrayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Come, Holy Spirit'**
  String get contemplativePrayerTitle;

  /// No description provided for @contemplativePrayerText.
  ///
  /// In en, this message translates to:
  /// **'Fill my heart and kindle in me the fire of Your love. Enlighten my mind that I may see my sins clearly.'**
  String get contemplativePrayerText;

  /// No description provided for @imReady.
  ///
  /// In en, this message translates to:
  /// **'I\'m Ready'**
  String get imReady;

  /// No description provided for @skipPrayer.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipPrayer;

  /// No description provided for @yesThisApplies.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesThisApplies;

  /// No description provided for @noThisDoesnt.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noThisDoesnt;

  /// No description provided for @skipQuestion.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipQuestion;

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String questionProgress(int current, int total);

  /// No description provided for @examinationComplete.
  ///
  /// In en, this message translates to:
  /// **'Examination Complete'**
  String get examinationComplete;

  /// No description provided for @reviewYourSelections.
  ///
  /// In en, this message translates to:
  /// **'Review your selections'**
  String get reviewYourSelections;

  /// No description provided for @examinationModeSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Examination Mode'**
  String get examinationModeSettingTitle;

  /// No description provided for @examinationModeSettingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you\'d like to examine your conscience'**
  String get examinationModeSettingSubtitle;

  /// No description provided for @askEveryTime.
  ///
  /// In en, this message translates to:
  /// **'Ask Every Time'**
  String get askEveryTime;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'ml', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ml':
      return AppLocalizationsMl();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
