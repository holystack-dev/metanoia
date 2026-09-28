import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_vi.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ko'),
    Locale('ml'),
    Locale('pl'),
    Locale('pt'),
    Locale('ta'),
    Locale('vi'),
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

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dailyQuoteError.
  ///
  /// In en, this message translates to:
  /// **'Today\'s quote couldn\'t be loaded.'**
  String get dailyQuoteError;

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

  /// No description provided for @spreadShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Metanoia'**
  String get spreadShareTitle;

  /// No description provided for @spreadShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Know someone who\'s been away from confession? Help them find their way back.'**
  String get spreadShareSubtitle;

  /// No description provided for @spreadShareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get spreadShareAction;

  /// No description provided for @spreadRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If Metanoia has helped you prepare for confession, a rating helps others find it.'**
  String get spreadRateSubtitle;

  /// No description provided for @spreadRateAction.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get spreadRateAction;

  /// No description provided for @rateGateHint.
  ///
  /// In en, this message translates to:
  /// **'How would you rate your experience?'**
  String get rateGateHint;

  /// No description provided for @rateGateLowest.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get rateGateLowest;

  /// No description provided for @rateGateHighest.
  ///
  /// In en, this message translates to:
  /// **'Highest'**
  String get rateGateHighest;

  /// No description provided for @rateGateThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you — your feedback means a lot to us.'**
  String get rateGateThanks;

  /// Subtitle under Rate App. {store} is the platform's app store name (a brand name, not translated): App Store on iOS, Google Play on Android.
  ///
  /// In en, this message translates to:
  /// **'Rate us on the {store}'**
  String rateAppSubtitle(String store);

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
  /// **'You\'ll go straight to the last page. Nothing is set up here — you can change everything later in Settings.'**
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

  /// Title of the Guide card that links to a confession short film on YouTube
  ///
  /// In en, this message translates to:
  /// **'Confession: A Short Film'**
  String get shortFilmTitle;

  /// Courtesy/attribution line on the short film card; keep the proper nouns 'Blazing Youth Wembley', 'St Joseph's RC Church' and 'Wembley' untranslated; the country name 'United Kingdom' may be localized
  ///
  /// In en, this message translates to:
  /// **'Created by Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, United Kingdom'**
  String get shortFilmSubtitle;

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

  /// Heading of the onboarding page that summarises the app
  ///
  /// In en, this message translates to:
  /// **'What this app does'**
  String get onboardingOverviewTitle;

  /// Onboarding overview: what the Examine tab is for
  ///
  /// In en, this message translates to:
  /// **'Prepare your conscience, at your pace.'**
  String get onboardingOverviewExamine;

  /// Onboarding overview: what the Confess tab is for
  ///
  /// In en, this message translates to:
  /// **'A discreet checklist, so nothing is forgotten.'**
  String get onboardingOverviewConfess;

  /// Onboarding overview: what the Journal tab is for
  ///
  /// In en, this message translates to:
  /// **'A short evening reflection, to keep growing between confessions.'**
  String get onboardingOverviewJournal;

  /// Muted footnote listing the features that are not tabs
  ///
  /// In en, this message translates to:
  /// **'Prayers, guides and optional reminders are inside.'**
  String get onboardingOverviewFootnote;

  /// Heading of the onboarding privacy page
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get onboardingPrivacyTitle;

  /// Onboarding privacy: data never leaves the device
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this phone. No account, no cloud.'**
  String get onboardingPrivacyLocal;

  /// Onboarding privacy: the database is encrypted at rest
  ///
  /// In en, this message translates to:
  /// **'Encrypted on your device.'**
  String get onboardingPrivacyEncrypted;

  /// Onboarding privacy: sets the expectation that a PIN is created later
  ///
  /// In en, this message translates to:
  /// **'You\'ll create a PIN the first time you open an examination or your journal.'**
  String get onboardingPrivacyPin;

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

  /// Title of the scheduled confession reminder notification
  ///
  /// In en, this message translates to:
  /// **'Time for Confession'**
  String get reminderNotificationTitle;

  /// Body of the scheduled confession reminder notification
  ///
  /// In en, this message translates to:
  /// **'Remember to examine your conscience and prepare for confession'**
  String get reminderNotificationBody;

  /// Shown when the user denies the notification permission while enabling reminders
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off. Allow notifications for Metanoia in your device settings to receive confession reminders.'**
  String get notificationPermissionDenied;

  /// Title of the open source licenses list tile on the About screen
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicenses;

  /// Shown when an external link fails to open
  ///
  /// In en, this message translates to:
  /// **'Could not open the link'**
  String get couldNotOpenLink;

  /// Number of items confessed in a past confession
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item confessed} other{{count} items confessed}}'**
  String itemsConfessed(int count);

  /// Number of penances
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 penance} other{{count} penances}}'**
  String penancesCount(int count);

  /// Number of pending items
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 pending} other{{count} pending}}'**
  String pendingCount(int count);

  /// Total number of confessions in history
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 total} other{{count} total}}'**
  String totalCount(int count);

  /// Number of items
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String itemsCount(int count);

  /// Number of days, used as a statistic value
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String daysCount(int count);

  /// Abbreviated number of weeks, used as a statistic value
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 wk} other{{count} wks}}'**
  String weeksShort(int count);

  /// Title of the delete all confessions confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete All Confessions?'**
  String get deleteAllConfessionsTitle;

  /// Body of the delete all confessions confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all your confession history. This action cannot be undone.'**
  String get deleteAllConfessionsContent;

  /// Confirmation shown after deleting all confessions
  ///
  /// In en, this message translates to:
  /// **'All confessions deleted'**
  String get allConfessionsDeleted;

  /// Body of the delete penance confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this penance?'**
  String get deletePenanceConfirm;

  /// Badge shown on a completed penance
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Hint on an expanded prayer card
  ///
  /// In en, this message translates to:
  /// **'Tap to collapse'**
  String get tapToCollapse;

  /// Tooltip of a button that dismisses a note
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// Step indicator in the tutorial showcase tooltip
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String showcaseStep(int current, int total);

  /// Label of the button that finishes the tutorial
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Accessibility label of a chevron that opens a screen
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// Accessibility label of the encouragement card icon
  ///
  /// In en, this message translates to:
  /// **'Encouragement'**
  String get encouragement;

  /// Reason shown in the system biometric prompt when unlocking the app
  ///
  /// In en, this message translates to:
  /// **'Authenticate to access Metanoia'**
  String get biometricPromptReason;

  /// Label above the lockout countdown
  ///
  /// In en, this message translates to:
  /// **'Try again in'**
  String get tryAgainInLabel;

  /// Shown when the language list fails to load
  ///
  /// In en, this message translates to:
  /// **'Error loading language'**
  String get errorLoadingLanguage;

  /// Shown for a confession recorded while "Keep confession history" was off, so only its date exists
  ///
  /// In en, this message translates to:
  /// **'Details not saved'**
  String get detailsNotSaved;

  /// Title of the dialog offering to purge already-stored sins when confession history is switched off
  ///
  /// In en, this message translates to:
  /// **'Discard saved sins?'**
  String get discardStoredSinsTitle;

  /// Body of that dialog
  ///
  /// In en, this message translates to:
  /// **'Confession history is now off. The sins already saved from past confessions are still stored. Discard them? The dates will be kept, so your insights and streaks stay intact.'**
  String get discardStoredSinsContent;

  /// Button: keep the already-stored sins
  ///
  /// In en, this message translates to:
  /// **'Keep them'**
  String get keepThem;

  /// Button: discard the already-stored sins
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// Confirmation that the stored sins were discarded
  ///
  /// In en, this message translates to:
  /// **'Saved sins discarded. Confession dates were kept.'**
  String get storedSinsDiscarded;

  /// Title of the daily journal screen
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journalTitle;

  /// Title of the journal card on the home screen
  ///
  /// In en, this message translates to:
  /// **'Evening reflection'**
  String get journalHomeCardTitle;

  /// Subtitle of the journal card on the home screen
  ///
  /// In en, this message translates to:
  /// **'How was today?'**
  String get journalHomeCardSubtitle;

  /// Number of consecutive days with a journal entry
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String journalStreakDays(int count);

  /// Accessibility label of the reflection streak badge
  ///
  /// In en, this message translates to:
  /// **'Days of reflection in a row'**
  String get journalStreakLabel;

  /// Call to action when today's journal entry has already been started
  ///
  /// In en, this message translates to:
  /// **'Continue today\'s entry'**
  String get journalContinueToday;

  /// Tooltip of the previous month button in the journal calendar
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get journalPreviousMonth;

  /// Tooltip of the next month button in the journal calendar
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get journalNextMonth;

  /// Title of the gratitude step of the journal entry flow
  ///
  /// In en, this message translates to:
  /// **'Gratitude'**
  String get journalGratitudeTitle;

  /// Prompt of the gratitude step
  ///
  /// In en, this message translates to:
  /// **'Where did I see God today?'**
  String get journalGratitudePrompt;

  /// Hint text of the optional gratitude field
  ///
  /// In en, this message translates to:
  /// **'A grace I want to thank Him for…'**
  String get journalGratitudeHint;

  /// Short, plain instruction opening the gratitude movement (Lato). Keep it simple and unadorned.
  ///
  /// In en, this message translates to:
  /// **'God is here with you. Be still before Him, and give thanks.'**
  String get journalPresenceLead;

  /// Scripture shown for the gratitude movement (Psalm 46:10). Use the exact wording of this verse from the language's approved Catholic Bible translation — do NOT paraphrase or re-translate.
  ///
  /// In en, this message translates to:
  /// **'Be still, and know that I am God.'**
  String get journalPresenceVerse;

  /// Citation of the gratitude Scripture. Localise the book name and numbering to the language's convention (e.g. 'Salmo 46,10').
  ///
  /// In en, this message translates to:
  /// **'Psalm 46:10'**
  String get journalPresenceRef;

  /// Title of the second Examen movement: a prayer to the Holy Spirit for light
  ///
  /// In en, this message translates to:
  /// **'Ask for Light'**
  String get journalLightTitle;

  /// Short, plain instruction for the Ask-for-Light movement (Lato).
  ///
  /// In en, this message translates to:
  /// **'Ask the Holy Spirit for light to see your day as God sees it.'**
  String get journalLightLead;

  /// The traditional 'Come, Holy Spirit' prayer (the Veni Sancte Spiritus versicle). Use the language's received, familiar Catholic wording of this well-known prayer — do NOT translate it afresh.
  ///
  /// In en, this message translates to:
  /// **'Come, Holy Spirit, fill the hearts of your faithful, and kindle in them the fire of your love.'**
  String get journalLightVerse;

  /// Title of the review movement: walking back through the day with God
  ///
  /// In en, this message translates to:
  /// **'Review with God'**
  String get journalReviewTitle;

  /// Short, plain instruction for the review movement (Lato).
  ///
  /// In en, this message translates to:
  /// **'Walk back through your day with the Lord — where love came to you, where you gave it, and where you turned away.'**
  String get journalReviewLead;

  /// Scripture for the review movement (Psalm 139:23-24). Use the exact wording from the language's approved Catholic Bible translation — do NOT paraphrase.
  ///
  /// In en, this message translates to:
  /// **'Search me, O God, and know my heart; test me and know my thoughts. See if there is any wicked way in me, and lead me in the way everlasting.'**
  String get journalReviewVerse;

  /// Citation of the review Scripture. Localise the book name and numbering.
  ///
  /// In en, this message translates to:
  /// **'Psalm 139:23–24'**
  String get journalReviewRef;

  /// Hint text of the optional reflection field in the review movement
  ///
  /// In en, this message translates to:
  /// **'Speak to Him about your day…'**
  String get journalReviewHint;

  /// Gentle label above the optional sin-marking action in the review movement
  ///
  /// In en, this message translates to:
  /// **'Is there anything you want to bring to Him?'**
  String get journalReviewBringSin;

  /// Title of the contrition movement: sorrow for sin, turned toward God
  ///
  /// In en, this message translates to:
  /// **'Contrition'**
  String get journalContritionTitle;

  /// Short, plain instruction for the contrition movement, echoing Luke 15:20 (Lato).
  ///
  /// In en, this message translates to:
  /// **'Bring what you have found to the Father, who runs to meet you.'**
  String get journalContritionLead;

  /// Scripture for the contrition movement (Psalm 51:1, the Miserere). Use the exact wording from the language's approved Catholic Bible translation — do NOT paraphrase.
  ///
  /// In en, this message translates to:
  /// **'Have mercy on me, O God, in your goodness; in your abundant compassion, blot out my offenses.'**
  String get journalContritionVerse;

  /// Citation of the contrition Scripture. Localise the book name and numbering.
  ///
  /// In en, this message translates to:
  /// **'Psalm 51:1'**
  String get journalContritionRef;

  /// Label inviting the user to pray the Act of Contrition, which is shown below it
  ///
  /// In en, this message translates to:
  /// **'Pray the Act of Contrition'**
  String get journalContritionPray;

  /// A gentle line on God's mercy that always points toward sacramental Confession. THEOLOGICALLY LOAD-BEARING (perfect contrition, Catechism 1452): it must NOT tell the user they are now in a state of grace — only that contrition opens the heart to God's mercy and always leads on to Confession. Translate with a native Catholic's care.
  ///
  /// In en, this message translates to:
  /// **'Sorrow born of love for God, with the resolve to confess, opens your heart to His mercy tonight — and its fullness awaits you in Confession, in the words of absolution.'**
  String get journalContritionMercy;

  /// Short, plain instruction for the final movement (Lato).
  ///
  /// In en, this message translates to:
  /// **'Rest in His mercy. Tomorrow begins again in Him.'**
  String get journalResolutionLead;

  /// Scripture for the final movement (Lamentations 3:22-23). Use the exact wording from the language's approved Catholic Bible translation — do NOT paraphrase.
  ///
  /// In en, this message translates to:
  /// **'The steadfast love of the Lord never ceases; his mercies are new every morning; great is your faithfulness.'**
  String get journalResolutionVerse;

  /// Citation of the resolution Scripture. Localise the book name and numbering.
  ///
  /// In en, this message translates to:
  /// **'Lamentations 3:22–23'**
  String get journalResolutionRef;

  /// Title of the reflection step of the journal entry flow
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get journalReflectionTitle;

  /// Prompt of the reflection step
  ///
  /// In en, this message translates to:
  /// **'How was your day?'**
  String get journalReflectionPrompt;

  /// Hint text of the free reflection field
  ///
  /// In en, this message translates to:
  /// **'Write freely...'**
  String get journalReflectionHint;

  /// Title of the sin marking step of the journal entry flow
  ///
  /// In en, this message translates to:
  /// **'Mark sins'**
  String get journalSinsTitle;

  /// Prompt of the sin marking step
  ///
  /// In en, this message translates to:
  /// **'Where did I fall short today?'**
  String get journalSinsPrompt;

  /// Shown when no sins have been marked on a journal day
  ///
  /// In en, this message translates to:
  /// **'Nothing marked yet'**
  String get journalNoSinsMarked;

  /// Label of the button that opens the sin picker
  ///
  /// In en, this message translates to:
  /// **'Mark a sin'**
  String get journalAddSin;

  /// Tooltip of the button that removes a marked sin
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get journalRemoveSin;

  /// Title of the final Examen movement: resting in mercy and resolving for tomorrow
  ///
  /// In en, this message translates to:
  /// **'Hope & Resolution'**
  String get journalResolutionTitle;

  /// Prompt of the resolution movement
  ///
  /// In en, this message translates to:
  /// **'One gift for tomorrow'**
  String get journalResolutionPrompt;

  /// Hint text of the optional resolution field
  ///
  /// In en, this message translates to:
  /// **'With Your grace, tomorrow I will…'**
  String get journalResolutionHint;

  /// Title of the mood step of the journal entry flow
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get journalMoodTitle;

  /// Prompt of the mood step
  ///
  /// In en, this message translates to:
  /// **'How is your soul tonight?'**
  String get journalMoodPrompt;

  /// Mood option 1 of 5
  ///
  /// In en, this message translates to:
  /// **'Desolate'**
  String get journalMoodDesolate;

  /// Mood option 2 of 5
  ///
  /// In en, this message translates to:
  /// **'Struggling'**
  String get journalMoodStruggling;

  /// Mood option 3 of 5
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get journalMoodSteady;

  /// Mood option 4 of 5
  ///
  /// In en, this message translates to:
  /// **'Grateful'**
  String get journalMoodGrateful;

  /// Mood option 5 of 5
  ///
  /// In en, this message translates to:
  /// **'Consoled'**
  String get journalMoodConsoled;

  /// Autosave indicator shown once the entry has been written
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get journalSaved;

  /// Autosave indicator shown while a write is pending
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get journalSaving;

  /// Tooltip and title of the delete journal entry action
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get journalDeleteEntry;

  /// Body of the delete journal entry confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete this day\'s entry? This cannot be undone.'**
  String get journalDeleteEntryConfirm;

  /// Confirmation shown after deleting a journal entry
  ///
  /// In en, this message translates to:
  /// **'Entry deleted'**
  String get journalEntryDeleted;

  /// Tab of the sin picker listing the standard question bank
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get journalPickerQuestions;

  /// Tab of the sin picker listing the user's custom sins
  ///
  /// In en, this message translates to:
  /// **'My sins'**
  String get journalPickerMySins;

  /// Tab of the sin picker for typing a free-text sin
  ///
  /// In en, this message translates to:
  /// **'In my own words'**
  String get journalPickerOwnWords;

  /// Hint text of the free-text sin field
  ///
  /// In en, this message translates to:
  /// **'Describe it in your own words'**
  String get journalPickerFreeTextHint;

  /// Hint text of the sin picker search field
  ///
  /// In en, this message translates to:
  /// **'Search sins...'**
  String get journalSearchSins;

  /// Badge on a journal sin that has been carried into a confession
  ///
  /// In en, this message translates to:
  /// **'Confessed'**
  String get journalAbsolved;

  /// Shown in place of a confessed journal sin whose text was cleared because confession history is off
  ///
  /// In en, this message translates to:
  /// **'A sin you brought to confession'**
  String get journalSinCleared;

  /// Banner offering to carry journal sin marks into the examination
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Include the sin you marked in your journal} other{Include the {count} sins you marked in your journal}}'**
  String journalPreloadTitle(int count);

  /// Button that carries the journal sin marks into the examination
  ///
  /// In en, this message translates to:
  /// **'Include'**
  String get journalPreloadAction;

  /// Confirmation shown after journal sins are added to the examination
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 sin added from your journal} other{{count} sins added from your journal}}'**
  String journalPreloadAdded(int count);

  /// Title of the insights section grouping journal sin marks by commandment
  ///
  /// In en, this message translates to:
  /// **'Struggle areas'**
  String get journalStruggleAreas;

  /// Subtitle of the struggle areas insights section
  ///
  /// In en, this message translates to:
  /// **'Most often marked in your journal'**
  String get journalStruggleAreasSubtitle;

  /// Number of journal sin marks under one commandment
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 mark} other{{count} marks}}'**
  String journalMarksCount(int count);

  /// Title of the daily journal reminder settings card
  ///
  /// In en, this message translates to:
  /// **'Journal reminder'**
  String get journalReminder;

  /// Subtitle of the daily journal reminder settings card
  ///
  /// In en, this message translates to:
  /// **'A nightly nudge to reflect on your day'**
  String get journalReminderSubtitle;

  /// Label of the switch that turns the daily journal reminder on
  ///
  /// In en, this message translates to:
  /// **'Enable journal reminder'**
  String get enableJournalReminder;

  /// Title of the daily journal reminder notification
  ///
  /// In en, this message translates to:
  /// **'Evening reflection'**
  String get journalReminderNotificationTitle;

  /// Body of the daily journal reminder notification
  ///
  /// In en, this message translates to:
  /// **'Take a moment to look back on your day with God'**
  String get journalReminderNotificationBody;

  /// Title of the distraction-free mode used in the confessional
  ///
  /// In en, this message translates to:
  /// **'Confession Mode'**
  String get confessionDayMode;

  /// No description provided for @confessionDayModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Large, distraction-free text for the confessional'**
  String get confessionDayModeDescription;

  /// No description provided for @exitConfessionMode.
  ///
  /// In en, this message translates to:
  /// **'Exit confession mode'**
  String get exitConfessionMode;

  /// Step counter in confession mode
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String confessionDayStepOf(int current, int total);

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @actOfContrition.
  ///
  /// In en, this message translates to:
  /// **'Act of Contrition'**
  String get actOfContrition;

  /// No description provided for @actOfContritionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The Act of Contrition is unavailable'**
  String get actOfContritionUnavailable;

  /// No description provided for @confessionDaySinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sins to confess'**
  String get confessionDaySinsTitle;

  /// No description provided for @confessionDayOpeningTitle.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get confessionDayOpeningTitle;

  /// No description provided for @confessionDayOpeningIntro.
  ///
  /// In en, this message translates to:
  /// **'Make the Sign of the Cross, then begin:'**
  String get confessionDayOpeningIntro;

  /// No description provided for @confessionDayOpeningFormula.
  ///
  /// In en, this message translates to:
  /// **'Bless me, Father, for I have sinned.'**
  String get confessionDayOpeningFormula;

  /// The second line of the opening formula. {duration} is a human phrase like '2 months' or '3 weeks', computed from the previous confession. Sacramental wording — source from an approved translation, do not paraphrase.
  ///
  /// In en, this message translates to:
  /// **'It has been {duration} since my last confession.'**
  String confessionDaySinceLast(String duration);

  /// Opening formula's second line when there is no earlier confession on record. A fill-in-the-blank template for the penitent to complete, not an assertion — keep the bracketed unit list, which follows the rite guide's 'give the number of weeks, months or years'. Take the unit names from this language's bundled confession guide. Sacramental wording — source from an approved translation.
  ///
  /// In en, this message translates to:
  /// **'It has been [days/weeks/months/years] since my last confession.'**
  String get confessionDaySinceLastUnknown;

  /// The line a penitent says after confessing their sins. Sacramental wording — source from an approved translation, do not paraphrase.
  ///
  /// In en, this message translates to:
  /// **'For these and all my sins, I am truly sorry.'**
  String get confessionDaySinsClosing;

  /// No description provided for @confessionDayThanksgivingTitle.
  ///
  /// In en, this message translates to:
  /// **'Go in peace'**
  String get confessionDayThanksgivingTitle;

  /// The priest's dismissal versicle. Liturgical text — source from the approved translation of the Rite of Penance, do not paraphrase.
  ///
  /// In en, this message translates to:
  /// **'Give thanks to the Lord, for He is good.'**
  String get confessionDayThanksgivingVersicle;

  /// The penitent's response to the dismissal versicle. Liturgical text — source from the approved translation of the Rite of Penance.
  ///
  /// In en, this message translates to:
  /// **'His mercy endures forever.'**
  String get confessionDayThanksgivingResponse;

  /// A gentle pastoral closing shown after absolution, encouraging thanksgiving and completing the penance.
  ///
  /// In en, this message translates to:
  /// **'You have been washed clean. Complete your penance, and go forward in the peace of Christ.'**
  String get confessionDayThanksgivingBody;

  /// A duration in weeks, e.g. for time since last confession
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 week} other{{count} weeks}}'**
  String weeksCount(int count);

  /// A duration in months, e.g. for time since last confession
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month} other{{count} months}}'**
  String monthsCount(int count);

  /// A duration in years, e.g. for time since last confession
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year} other{{count} years}}'**
  String yearsCount(int count);

  /// Name of the liturgical season of Lent
  ///
  /// In en, this message translates to:
  /// **'Lent'**
  String get seasonLent;

  /// Name of the liturgical season of Holy Week
  ///
  /// In en, this message translates to:
  /// **'Holy Week'**
  String get seasonHolyWeek;

  /// Name of the liturgical season of Advent
  ///
  /// In en, this message translates to:
  /// **'Advent'**
  String get seasonAdvent;

  /// Name of the liturgical season of Christmas
  ///
  /// In en, this message translates to:
  /// **'Christmas'**
  String get seasonChristmas;

  /// Name of the liturgical season of Easter
  ///
  /// In en, this message translates to:
  /// **'Easter'**
  String get seasonEaster;

  /// Name of the liturgical season of Ordinary Time
  ///
  /// In en, this message translates to:
  /// **'Ordinary Time'**
  String get seasonOrdinaryTime;

  /// Name of the feast of Ash Wednesday
  ///
  /// In en, this message translates to:
  /// **'Ash Wednesday'**
  String get feastAshWednesday;

  /// Name of the feast of Palm Sunday
  ///
  /// In en, this message translates to:
  /// **'Palm Sunday'**
  String get feastPalmSunday;

  /// Name of the feast of Easter
  ///
  /// In en, this message translates to:
  /// **'Easter'**
  String get feastEaster;

  /// Name of the feast of Pentecost
  ///
  /// In en, this message translates to:
  /// **'Pentecost'**
  String get feastPentecost;

  /// Name of the feast of the Assumption of Mary (15 August)
  ///
  /// In en, this message translates to:
  /// **'The Assumption'**
  String get feastAssumption;

  /// Name of the feast of All Saints (1 November)
  ///
  /// In en, this message translates to:
  /// **'All Saints'**
  String get feastAllSaints;

  /// Name of the feast of the Immaculate Conception (8 December)
  ///
  /// In en, this message translates to:
  /// **'The Immaculate Conception'**
  String get feastImmaculateConception;

  /// Name of the First Sunday of Advent
  ///
  /// In en, this message translates to:
  /// **'The First Sunday of Advent'**
  String get feastFirstSundayOfAdvent;

  /// Name of the feast of Christmas
  ///
  /// In en, this message translates to:
  /// **'Christmas'**
  String get feastChristmas;

  /// Title of the home card shown in the first days of Lent
  ///
  /// In en, this message translates to:
  /// **'Lent has begun'**
  String get liturgicalLentTitle;

  /// Body of the home card shown in the first days of Lent
  ///
  /// In en, this message translates to:
  /// **'A season of returning. Many begin it with confession.'**
  String get liturgicalLentBody;

  /// Title of the home card shown during Holy Week
  ///
  /// In en, this message translates to:
  /// **'Holy Week has begun'**
  String get liturgicalHolyWeekTitle;

  /// Body of the home card shown during Holy Week
  ///
  /// In en, this message translates to:
  /// **'The Church walks toward Easter. There is still time to prepare your heart.'**
  String get liturgicalHolyWeekBody;

  /// Title of the home card shown in the first days of Advent
  ///
  /// In en, this message translates to:
  /// **'Advent has begun'**
  String get liturgicalAdventTitle;

  /// Body of the home card shown in the first days of Advent
  ///
  /// In en, this message translates to:
  /// **'A season of waiting. Many prepare their hearts with confession.'**
  String get liturgicalAdventBody;

  /// Title of the home card shown in the days before a major feast
  ///
  /// In en, this message translates to:
  /// **'{feast} is near'**
  String liturgicalFeastNearTitle(String feast);

  /// Body of the home card shown in the days before a major feast
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{One day away — prepare your heart.} other{{count} days away — prepare your heart.}}'**
  String liturgicalFeastNearBody(int count);

  /// Title of the home card inviting the user to confession after an unusually long gap
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{It has been a week since your last confession} other{It has been {count} weeks since your last confession}}'**
  String anniversaryTitle(int count);

  /// Body of the home card inviting the user to confession after an unusually long gap
  ///
  /// In en, this message translates to:
  /// **'Whenever you are ready, mercy is waiting. Would you like to prepare?'**
  String get anniversaryBody;

  /// Call to action on the liturgical and anniversary home cards
  ///
  /// In en, this message translates to:
  /// **'Prepare'**
  String get promptPrepare;

  /// Title shown when the database encryption key is unrecoverable
  ///
  /// In en, this message translates to:
  /// **'Your data cannot be unlocked'**
  String get dataUnrecoverableTitle;

  /// Explains that encrypted data cannot be recovered without its key
  ///
  /// In en, this message translates to:
  /// **'The key that protects your confessions is no longer available on this device. This can happen after restoring from a backup, or if the device security settings were reset.\n\nBecause your data is encrypted, it cannot be recovered without that key — not even by us. You can erase it and begin again.'**
  String get dataUnrecoverableBody;

  /// Button that erases all local data and restarts the app fresh
  ///
  /// In en, this message translates to:
  /// **'Erase and start over'**
  String get eraseAndStartOver;

  /// Confirmation body for erasing all local data
  ///
  /// In en, this message translates to:
  /// **'This permanently erases everything stored on this device and starts the app fresh. It cannot be undone.'**
  String get eraseAndStartOverConfirm;

  /// Shown when the penance could not be written to the database
  ///
  /// In en, this message translates to:
  /// **'Could not save the penance. Please try again.'**
  String get penanceSaveFailed;

  /// Android notification channel name for confession reminders, shown in system settings
  ///
  /// In en, this message translates to:
  /// **'Confession Reminders'**
  String get confessionReminderChannelName;

  /// Android notification channel description for confession reminders, shown in system settings
  ///
  /// In en, this message translates to:
  /// **'Reminders for confession'**
  String get confessionReminderChannelDescription;

  /// Android notification channel name for the daily journal reminder, shown in system settings
  ///
  /// In en, this message translates to:
  /// **'Journal Reminders'**
  String get journalReminderChannelName;

  /// Android notification channel description for the daily journal reminder, shown in system settings
  ///
  /// In en, this message translates to:
  /// **'Daily reminder to write the evening reflection'**
  String get journalReminderChannelDescription;

  /// The single, quiet progress line during the guided examination: how many sins the user has named so far
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{One named so far} other{{count} named so far}}'**
  String namedSoFar(int count);

  /// Title of the dismissible inline card offering encouragement at the top of the examination
  ///
  /// In en, this message translates to:
  /// **'Before you begin'**
  String get invitationCardTitle;

  /// Action on the inline encouragement card; opens the invitation guide
  ///
  /// In en, this message translates to:
  /// **'Encourage me'**
  String get invitationCardAction;

  /// Primary home call to action for a user with nothing in progress
  ///
  /// In en, this message translates to:
  /// **'Begin your examination'**
  String get homeCtaBeginTitle;

  /// Subtitle of the home call to action inviting an examination
  ///
  /// In en, this message translates to:
  /// **'Prepare your heart before confession'**
  String get homeCtaBeginSubtitle;

  /// Primary home call to action when an examination draft is in progress
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Continue your examination (1 selected)} other{Continue your examination ({count} selected)}}'**
  String homeCtaContinueTitle(int count);

  /// Subtitle of the home call to action resuming an examination
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off'**
  String get homeCtaContinueSubtitle;

  /// Title of the home call to action when the examination is done but the confession has not been made
  ///
  /// In en, this message translates to:
  /// **'You\'re ready'**
  String get homeCtaReadyTitle;

  /// Subtitle of the home call to action pointing at the confession list
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 sin is waiting in your confession list} other{{count} sins are waiting in your confession list}}'**
  String homeCtaReadySubtitle(int count);

  /// Title of the home call to action for an outstanding penance
  ///
  /// In en, this message translates to:
  /// **'Complete your penance'**
  String get homeCtaPenanceTitle;

  /// Subtitle of the home call to action when penances are still pending
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 penance is still waiting} other{{count} penances are still waiting}}'**
  String homeCtaPenanceSubtitle(int count);

  /// Subtitle of the guide entry point on the home screen
  ///
  /// In en, this message translates to:
  /// **'Encouragement, a step-by-step guide, prayers and FAQs'**
  String get homeGuideCardSubtitle;

  /// Expands the clamped daily quote on the home screen
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get homeQuoteReadMore;

  /// Collapses the expanded daily quote on the home screen
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get homeQuoteShowLess;

  /// Tutorial step describing the journal card on the home screen
  ///
  /// In en, this message translates to:
  /// **'Look back on your day each evening: a short reflection, and your streak.'**
  String get tutorialJournalDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fil',
    'fr',
    'hi',
    'id',
    'it',
    'ko',
    'ml',
    'pl',
    'pt',
    'ta',
    'vi',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ko':
      return AppLocalizationsKo();
    case 'ml':
      return AppLocalizationsMl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ta':
      return AppLocalizationsTa();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
