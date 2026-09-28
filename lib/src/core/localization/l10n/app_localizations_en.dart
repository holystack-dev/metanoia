// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Welcome';

  @override
  String get examineTitle => 'Examine';

  @override
  String get confessTitle => 'Confess';

  @override
  String get prayersTitle => 'Prayers';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get examinationTitle => 'Examination';

  @override
  String get commandment => 'Commandment';

  @override
  String get guideTitle => 'Guide';

  @override
  String get faqTitle => 'Understanding Confession';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose your preferred language';

  @override
  String get theme => 'Theme';

  @override
  String get chooseTheme => 'Choose your preferred theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get reminders => 'Reminders';

  @override
  String get getReminded => 'Get reminded to go to confession';

  @override
  String get enableReminders => 'Enable Reminders';

  @override
  String get weekly => 'Weekly';

  @override
  String get biweekly => 'Bi-weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get quarterly => 'Quarterly';

  @override
  String get day => 'Day';

  @override
  String get time => 'Time';

  @override
  String get remindMe => 'Remind me';

  @override
  String get onTheDay => 'On the day';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days before',
      one: '1 day before',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get lastConfession => 'Last Confession';

  @override
  String get noneYet => 'None yet';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Next Reminder';

  @override
  String get off => 'Off';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get appLanguage => 'App Language';

  @override
  String get appLanguageSubtitle => 'Language for buttons, labels, and menus';

  @override
  String get contentLanguage => 'Content Language';

  @override
  String get contentLanguageSubtitle =>
      'Language for examination questions, FAQs, and prayers';

  @override
  String get version => 'Version';

  @override
  String get selectDay => 'Select Day';

  @override
  String selected(num count) {
    return '$count selected';
  }

  @override
  String get selectedLabel => 'selected';

  @override
  String get counter => 'Counter';

  @override
  String get searchPlaceholder => 'Search commandments or questions...';

  @override
  String get noResults => 'No results found';

  @override
  String get viewHistory => 'View History';

  @override
  String get noActiveConfession => 'No active confession';

  @override
  String get startExaminationPrompt => 'Start an examination to add sins here.';

  @override
  String get startExamination => 'Start Examination';

  @override
  String get finishConfessionTitle => 'Finish Confession?';

  @override
  String get finishConfessionContent =>
      'This will mark the confession as completed and move it to your history.';

  @override
  String get cancel => 'Cancel';

  @override
  String get finish => 'Finish';

  @override
  String get confessionCompletedMessage =>
      'Confession completed! God bless you.';

  @override
  String get finishConfession => 'Finish Confession';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get dailyQuoteError => 'Today\'s quote couldn\'t be loaded.';

  @override
  String get keepHistory => 'Keep Confession History';

  @override
  String get keepHistorySubtitle =>
      'Save your sins along with the date. If disabled, only the date will be saved.';

  @override
  String get deleteConfession => 'Delete Confession';

  @override
  String get deleteConfessionContent =>
      'This will permanently delete this confession and all its items from your history. This action cannot be undone.';

  @override
  String get tutorialExamineDesc =>
      'Start here to examine your conscience before confession.';

  @override
  String get tutorialConfessDesc =>
      'Use this during confession to track your sins.';

  @override
  String get tutorialPrayersDesc =>
      'Find common prayers for before and after confession.';

  @override
  String get tutorialGuideDesc =>
      'Find encouragement, step-by-step confession guide, and FAQs here.';

  @override
  String get tutorialSettingsDesc =>
      'Customize your experience here: change language, theme, set reminders, and manage security settings.';

  @override
  String get tutorialSwipeDesc =>
      'Swipe left or right to navigate between commandments.';

  @override
  String get tutorialSelectDesc =>
      'Tap any question to select it for your confession.';

  @override
  String get tutorialFinishDesc =>
      'When done, tap here to finish and proceed to confession.';

  @override
  String get tutorialCounterDesc =>
      'This shows how many items you\'ve selected for confession.';

  @override
  String get tutorialMenuDesc =>
      'Access custom sins and clear your selections from here.';

  @override
  String get tutorialPenanceDesc =>
      'Track penances given by your confessor here.';

  @override
  String get tutorialInsightsDesc =>
      'View your confession journey statistics and streaks.';

  @override
  String get tutorialHistoryDesc =>
      'Access your past confessions and their dates.';

  @override
  String get replayTutorial => 'Replay Tutorial';

  @override
  String get replayTutorialDesc => 'View the app tutorial again';

  @override
  String get tutorialReset => 'Tutorial reset! You\'ll see the guides again.';

  @override
  String get about => 'About';

  @override
  String get aboutSubtitle => 'Version, license, and source code';

  @override
  String get shareApp => 'Share App';

  @override
  String get shareAppSubtitle => 'Share with friends and family';

  @override
  String get rateApp => 'Rate App';

  @override
  String get spreadShareTitle => 'Share Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Know someone who\'s been away from confession? Help them find their way back.';

  @override
  String get spreadShareAction => 'Share';

  @override
  String get spreadRateSubtitle =>
      'If Metanoia has helped you prepare for confession, a rating helps others find it.';

  @override
  String get spreadRateAction => 'Rate';

  @override
  String get rateGateHint => 'How would you rate your experience?';

  @override
  String get rateGateLowest => 'Lowest';

  @override
  String get rateGateHighest => 'Highest';

  @override
  String get rateGateThanks => 'Thank you — your feedback means a lot to us.';

  @override
  String rateAppSubtitle(String store) {
    return 'Rate us on the $store';
  }

  @override
  String get website => 'Website';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get madeWithLove => 'Made with ❤️ by holystack.dev';

  @override
  String get rateDialogTitle => 'Enjoying Metanoia?';

  @override
  String get rateDialogContent =>
      'If you find this app helpful, please take a moment to rate it. It helps us a lot!';

  @override
  String get rateDialogYes => 'Rate Now';

  @override
  String get rateDialogNo => 'No, thanks';

  @override
  String get rateDialogLater => 'Remind me later';

  @override
  String get greekLabel => 'Greek';

  @override
  String get nounLabel => 'noun';

  @override
  String get metanoiaDefinition =>
      'A profound change of mind and heart; a spiritual awakening that transforms one\'s entire being and redirects their life toward God.';

  @override
  String get turnBackToGrace => 'Turn Back to Grace';

  @override
  String get welcomeSubtitle => 'Your guide for a meaningful confession';

  @override
  String get discoverInnerGrace => 'Discover Inner Grace';

  @override
  String get sacredJourneyBegins =>
      'A sacred journey of reconciliation begins.';

  @override
  String get beginJourney => 'Begin Journey';

  @override
  String get getStarted => 'Get Started';

  @override
  String get chooseContentLanguage => 'Choose Content Language';

  @override
  String get contentLanguageDescription =>
      'Select language for prayers, conscience examination, and guides';

  @override
  String get changeAnytimeNote => 'You can change this anytime in Settings';

  @override
  String get continueButton => 'Continue';

  @override
  String get examineDescription =>
      'Examine your conscience using the Ten Commandments before confession';

  @override
  String get confessDescription =>
      'Track your sins during confession to ensure nothing is forgotten';

  @override
  String get prayersDescription =>
      'Access prayers for before and after confession, and penance prayers';

  @override
  String get remindersDescription =>
      'Set regular reminders in Settings so you never forget to go to confession';

  @override
  String get nextButton => 'Next';

  @override
  String get customSins => 'Custom Sins';

  @override
  String get manageCustomSins => 'Manage Custom Sins';

  @override
  String get addCustomSin => 'Add Custom Sin';

  @override
  String get editCustomSin => 'Edit Custom Sin';

  @override
  String get deleteCustomSin => 'Delete Custom Sin';

  @override
  String get sinDescription => 'Sin Description';

  @override
  String get sinDescriptionHint => 'Describe the sin you want to remember';

  @override
  String get sinDescriptionRequired => 'Please enter a sin description';

  @override
  String get optionalNote => 'Optional Note';

  @override
  String get optionalNoteHint => 'Add any additional details';

  @override
  String get selectCommandment => 'Select Commandment (Optional)';

  @override
  String get noCommandment => 'General / No Commandment';

  @override
  String get customSinAdded => 'Custom sin added';

  @override
  String get customSinUpdated => 'Custom sin updated';

  @override
  String get customSinDeleted => 'Custom sin deleted';

  @override
  String get deleteCustomSinConfirm =>
      'Are you sure you want to delete this custom sin?';

  @override
  String get noCustomSins => 'No custom sins yet';

  @override
  String get noCustomSinsDesc =>
      'Add custom sins to personalize your examination';

  @override
  String get customVersion => 'Custom (Edited)';

  @override
  String get searchCustomSins => 'Search custom sins...';

  @override
  String get addButton => 'Add';

  @override
  String get updateButton => 'Update';

  @override
  String get deleteButton => 'Delete';

  @override
  String get addYourOwn => 'Add your own...';

  @override
  String get penance => 'Penance';

  @override
  String get penanceTracker => 'Penance Tracker';

  @override
  String get addPenance => 'Add Penance';

  @override
  String get editPenance => 'Edit Penance';

  @override
  String get penanceDescription => 'What penance were you given?';

  @override
  String get penanceHint =>
      'e.g., Say 3 Hail Marys, Read a Scripture passage...';

  @override
  String get penanceAdded => 'Penance added';

  @override
  String get penanceUpdated => 'Penance updated';

  @override
  String get penanceCompleted => 'Penance completed! God bless you.';

  @override
  String get markAsComplete => 'Mark as Complete';

  @override
  String get pendingPenances => 'Pending Penances';

  @override
  String get noPendingPenances => 'No pending penances';

  @override
  String get noPendingPenancesDesc =>
      'All your penances are completed. God bless!';

  @override
  String completedOn(Object date) {
    return 'Completed on $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Assigned on $date';
  }

  @override
  String get skipPenance => 'Skip';

  @override
  String get savePenance => 'Save Penance';

  @override
  String get insights => 'Insights';

  @override
  String get confessionInsights => 'Confession Insights';

  @override
  String get totalConfessions => 'Total Confessions';

  @override
  String get averageFrequency => 'Average Frequency';

  @override
  String everyXDays(Object count) {
    return 'Every $count days';
  }

  @override
  String get daysSinceLastConfession => 'Days Since Last';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Monthly Activity';

  @override
  String get confessionsThisYear => 'Confessions This Year';

  @override
  String get noInsightsYet => 'No insights yet';

  @override
  String get noInsightsYetDesc =>
      'Complete your first confession to see your spiritual journey stats';

  @override
  String get totalItemsConfessed => 'Total Items Confessed';

  @override
  String get firstConfession => 'First Confession';

  @override
  String get spiritualJourney => 'Your Spiritual Journey';

  @override
  String get listView => 'List';

  @override
  String get guidedView => 'Guided';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current of $total';
  }

  @override
  String get previousCommandment => 'Previous';

  @override
  String get nextCommandment => 'Next';

  @override
  String get finishExamination => 'Finish';

  @override
  String get noQuestionsSelected => 'No questions selected in this section';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count selected';
  }

  @override
  String get examinationSummary => 'Examination Summary';

  @override
  String get examinationNote =>
      'A thorough examination of conscience goes beyond any list. Reflect prayerfully on your state of life and circumstances.';

  @override
  String selectedCount(Object count) {
    return '$count items selected';
  }

  @override
  String get noSinsSelected => 'No sins selected';

  @override
  String get continueEditing => 'Continue Editing';

  @override
  String get proceedToConfess => 'Proceed';

  @override
  String get clearDraftTitle => 'Clear Draft?';

  @override
  String get clearDraftMessage =>
      'This will remove all selected questions. Are you sure?';

  @override
  String get clearDraft => 'Clear Draft';

  @override
  String get clear => 'Clear';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restored $count items from your last session',
      one: 'Restored 1 item from your last session',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object count) {
    return '${count}m ago';
  }

  @override
  String hoursAgo(Object count) {
    return '${count}h ago';
  }

  @override
  String get general => 'General';

  @override
  String get noQuestionsInSection => 'No questions in this section';

  @override
  String get skip => 'Skip';

  @override
  String get back => 'Back';

  @override
  String get skipOnboardingTitle => 'Skip Introduction?';

  @override
  String get skipOnboardingMessage =>
      'You\'ll go straight to the last page. Nothing is set up here — you can change everything later in Settings.';

  @override
  String get confessionHistoryTitle => 'Confession History';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get editDate => 'Edit Date';

  @override
  String get confessionDate => 'Confession Date';

  @override
  String get dateUpdated => 'Date updated';

  @override
  String get changeDateConfirmTitle => 'Change Date?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Change confession date to $date?';
  }

  @override
  String get noGuideContent => 'No guide content available';

  @override
  String get noGuideContentDesc => 'Guide content will appear here';

  @override
  String get noFaqContent => 'No FAQs available';

  @override
  String get noFaqContentDesc => 'Frequently asked questions will appear here';

  @override
  String get faqSubtitle => 'A guide to the Sacrament of Reconciliation';

  @override
  String get tapToExpand => 'Tap to read more';

  @override
  String get continueExamination => 'Continue Examination';

  @override
  String get continueExaminationDesc => 'You have an examination in progress';

  @override
  String examinationProgress(Object count) {
    return '$count items selected';
  }

  @override
  String get security => 'Security';

  @override
  String get securitySubtitle => 'Protect your personal data';

  @override
  String get pinAndBiometric => 'PIN & Biometric';

  @override
  String get pinAndBiometricSubtitle => 'Configure app lock settings';

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get createPin => 'Create PIN';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get incorrectPin => 'Incorrect PIN';

  @override
  String get pinMismatch => 'PINs don\'t match';

  @override
  String get biometricUnlock => 'Biometric Unlock';

  @override
  String get autoLockTimeout => 'Auto-Lock Timeout';

  @override
  String get tooManyAttempts => 'Too many failed attempts';

  @override
  String tryAgainIn(Object time) {
    return 'Try again in $time';
  }

  @override
  String get useBiometricUnlock => 'Use Biometric Unlock';

  @override
  String get unlockWithFingerprintOrFace => 'Unlock with fingerprint or face';

  @override
  String get biometricAccessWarning =>
      'Anyone with a registered fingerprint or face on this device will be able to access the app';

  @override
  String get lockAfter => 'Lock After';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Time in background before locking';

  @override
  String get changePin => 'Change PIN';

  @override
  String get updateYourSecurityPin => 'Update your security PIN';

  @override
  String get enterCurrentPin => 'Enter Current PIN';

  @override
  String get enterNewPin => 'Enter New PIN';

  @override
  String get confirmNewPin => 'Confirm New PIN';

  @override
  String get pinChangedSuccessfully => 'PIN changed successfully';

  @override
  String get currentPinIncorrect => 'Current PIN is incorrect';

  @override
  String get enableBiometricUnlock => 'Enable Biometric Unlock?';

  @override
  String get biometricDescription =>
      'Use your fingerprint or face to unlock the app quickly and securely.';

  @override
  String get notNow => 'Not Now';

  @override
  String get enable => 'Enable';

  @override
  String get setUpPin => 'Set Up PIN';

  @override
  String get createSixDigitPin => 'Create a 6-digit PIN';

  @override
  String get pinProtectData => 'This PIN will be used to protect your data';

  @override
  String get confirmYourPin => 'Confirm your PIN';

  @override
  String get enterSamePinAgain => 'Enter the same PIN again to confirm';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Enter your PIN to unlock';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts remaining',
      one: '1 attempt remaining',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seconds',
      one: '1 second',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '1 minute',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Undo';

  @override
  String get confessionDeleted => 'Confession deleted';

  @override
  String get noConfessionHistory => 'No confession history';

  @override
  String get noConfessionHistoryDesc =>
      'Completed confessions will appear here';

  @override
  String get fontSize => 'Font Size';

  @override
  String get fontSizeSubtitle => 'Adjust text size for better readability';

  @override
  String get fontSizeSmall => 'Small';

  @override
  String get fontSizeMedium => 'Medium';

  @override
  String get fontSizeLarge => 'Large';

  @override
  String get fontSizeExtraLarge => 'Extra Large';

  @override
  String get forgotPin => 'Forgot PIN?';

  @override
  String get resetPinTitle => 'Reset PIN';

  @override
  String get resetPinWarning =>
      'Warning: This will permanently delete all your data';

  @override
  String get resetPinDescription =>
      'If you reset your PIN, all your confessions, custom sins, penances, and other personal data will be permanently deleted. This action cannot be undone.';

  @override
  String get resetPinConfirmation => 'Type DELETE to confirm';

  @override
  String get resetPinButton => 'Reset PIN & Delete Data';

  @override
  String get resetPinSuccess =>
      'PIN reset successfully. Please set up a new PIN.';

  @override
  String get resetPinError => 'Failed to reset PIN. Please try again.';

  @override
  String get deleteConfirmationText => 'DELETE';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Please wait $seconds seconds';
  }

  @override
  String get resetPinBiometricPrompt => 'Verify your identity to reset PIN';

  @override
  String get confessionGuideTitle => 'How to Make a Good Confession';

  @override
  String get shortFilmTitle => 'Confession: A Short Film';

  @override
  String get shortFilmSubtitle =>
      'Created by Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, United Kingdom';

  @override
  String get confessionGuideSubtitle => 'Step-by-step guide to the Sacrament';

  @override
  String get invitationTitle => 'Returning to Confession?';

  @override
  String get invitationSubtitle => 'A word of encouragement for you';

  @override
  String get invitationDialogTitle => 'Welcome';

  @override
  String get invitationDialogContent =>
      'Is this your first confession in a while, or are you feeling anxious about going?';

  @override
  String get invitationDialogYes => 'Yes, I\'d like some encouragement';

  @override
  String get invitationDialogNo => 'No, I\'m ready to begin';

  @override
  String get invitationDialogDontShowAgain => 'Don\'t show this again';

  @override
  String get searchPrayers => 'Search prayers...';

  @override
  String get allCategories => 'All';

  @override
  String get appDisclaimer =>
      'This app is a spiritual aid for confession preparation. It is not a substitute for the Sacrament of Reconciliation with a priest.';

  @override
  String get onboardingDisclaimer =>
      'A spiritual companion for confession—not a replacement for it.';

  @override
  String get readyToBegin => 'You\'re All Set';

  @override
  String get readyToBeginSubtitle =>
      'May your journey toward reconciliation be filled with grace and peace.';

  @override
  String get onboardingOverviewTitle => 'What this app does';

  @override
  String get onboardingOverviewExamine =>
      'Prepare your conscience, at your pace.';

  @override
  String get onboardingOverviewConfess =>
      'A discreet checklist, so nothing is forgotten.';

  @override
  String get onboardingOverviewJournal =>
      'A short evening reflection, to keep growing between confessions.';

  @override
  String get onboardingOverviewFootnote =>
      'Prayers, guides and optional reminders are inside.';

  @override
  String get onboardingPrivacyTitle => 'Private by design';

  @override
  String get onboardingPrivacyLocal =>
      'Everything stays on this phone. No account, no cloud.';

  @override
  String get onboardingPrivacyEncrypted => 'Encrypted on your device.';

  @override
  String get onboardingPrivacyPin =>
      'You\'ll create a PIN the first time you open an examination or your journal.';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get contentReferences => 'Content References';

  @override
  String get examinationModeTitle => 'How would you like to examine?';

  @override
  String get quickReviewMode => 'Quick Review';

  @override
  String get quickReviewDescription => 'Scan through all questions by category';

  @override
  String get deepReflectionMode => 'Deep Reflection';

  @override
  String get deepReflectionDescription =>
      'One question at a time for thoughtful examination';

  @override
  String get contemplativePrayerTitle => 'Come, Holy Spirit';

  @override
  String get contemplativePrayerText =>
      'Fill my heart and kindle in me the fire of Your love. Enlighten my mind that I may see my sins clearly.';

  @override
  String get imReady => 'I\'m Ready';

  @override
  String get skipPrayer => 'Skip';

  @override
  String get yesThisApplies => 'Yes';

  @override
  String get noThisDoesnt => 'No';

  @override
  String get skipQuestion => 'Skip';

  @override
  String questionProgress(int current, int total) {
    return '$current of $total';
  }

  @override
  String get examinationComplete => 'Examination Complete';

  @override
  String get reviewYourSelections => 'Review your selections';

  @override
  String get examinationModeSettingTitle => 'Examination Mode';

  @override
  String get examinationModeSettingSubtitle =>
      'Choose how you\'d like to examine your conscience';

  @override
  String get askEveryTime => 'Ask Every Time';

  @override
  String get reminderNotificationTitle => 'Time for Confession';

  @override
  String get reminderNotificationBody =>
      'Remember to examine your conscience and prepare for confession';

  @override
  String get notificationPermissionDenied =>
      'Notifications are turned off. Allow notifications for Metanoia in your device settings to receive confession reminders.';

  @override
  String get openSourceLicenses => 'Open Source Licenses';

  @override
  String get couldNotOpenLink => 'Could not open the link';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items confessed',
      one: '1 item confessed',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penances',
      one: '1 penance',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending',
      one: '1 pending',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count total',
      one: '1 total',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wks',
      one: '1 wk',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Delete All Confessions?';

  @override
  String get deleteAllConfessionsContent =>
      'This will permanently delete all your confession history. This action cannot be undone.';

  @override
  String get allConfessionsDeleted => 'All confessions deleted';

  @override
  String get deletePenanceConfirm =>
      'Are you sure you want to delete this penance?';

  @override
  String get completed => 'Completed';

  @override
  String get tapToCollapse => 'Tap to collapse';

  @override
  String get dismiss => 'Dismiss';

  @override
  String showcaseStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get done => 'Done';

  @override
  String get navigate => 'Navigate';

  @override
  String get encouragement => 'Encouragement';

  @override
  String get biometricPromptReason => 'Authenticate to access Metanoia';

  @override
  String get tryAgainInLabel => 'Try again in';

  @override
  String get errorLoadingLanguage => 'Error loading language';

  @override
  String get detailsNotSaved => 'Details not saved';

  @override
  String get discardStoredSinsTitle => 'Discard saved sins?';

  @override
  String get discardStoredSinsContent =>
      'Confession history is now off. The sins already saved from past confessions are still stored. Discard them? The dates will be kept, so your insights and streaks stay intact.';

  @override
  String get keepThem => 'Keep them';

  @override
  String get discard => 'Discard';

  @override
  String get storedSinsDiscarded =>
      'Saved sins discarded. Confession dates were kept.';

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalHomeCardTitle => 'Evening reflection';

  @override
  String get journalHomeCardSubtitle => 'How was today?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Days of reflection in a row';

  @override
  String get journalContinueToday => 'Continue today\'s entry';

  @override
  String get journalPreviousMonth => 'Previous month';

  @override
  String get journalNextMonth => 'Next month';

  @override
  String get journalGratitudeTitle => 'Gratitude';

  @override
  String get journalGratitudePrompt => 'Where did I see God today?';

  @override
  String get journalGratitudeHint => 'A grace I want to thank Him for…';

  @override
  String get journalPresenceLead =>
      'God is here with you. Be still before Him, and give thanks.';

  @override
  String get journalPresenceVerse => 'Be still, and know that I am God.';

  @override
  String get journalPresenceRef => 'Psalm 46:10';

  @override
  String get journalLightTitle => 'Ask for Light';

  @override
  String get journalLightLead =>
      'Ask the Holy Spirit for light to see your day as God sees it.';

  @override
  String get journalLightVerse =>
      'Come, Holy Spirit, fill the hearts of your faithful, and kindle in them the fire of your love.';

  @override
  String get journalReviewTitle => 'Review with God';

  @override
  String get journalReviewLead =>
      'Walk back through your day with the Lord — where love came to you, where you gave it, and where you turned away.';

  @override
  String get journalReviewVerse =>
      'Search me, O God, and know my heart; test me and know my thoughts. See if there is any wicked way in me, and lead me in the way everlasting.';

  @override
  String get journalReviewRef => 'Psalm 139:23–24';

  @override
  String get journalReviewHint => 'Speak to Him about your day…';

  @override
  String get journalReviewBringSin =>
      'Is there anything you want to bring to Him?';

  @override
  String get journalContritionTitle => 'Contrition';

  @override
  String get journalContritionLead =>
      'Bring what you have found to the Father, who runs to meet you.';

  @override
  String get journalContritionVerse =>
      'Have mercy on me, O God, in your goodness; in your abundant compassion, blot out my offenses.';

  @override
  String get journalContritionRef => 'Psalm 51:1';

  @override
  String get journalContritionPray => 'Pray the Act of Contrition';

  @override
  String get journalContritionMercy =>
      'Sorrow born of love for God, with the resolve to confess, opens your heart to His mercy tonight — and its fullness awaits you in Confession, in the words of absolution.';

  @override
  String get journalResolutionLead =>
      'Rest in His mercy. Tomorrow begins again in Him.';

  @override
  String get journalResolutionVerse =>
      'The steadfast love of the Lord never ceases; his mercies are new every morning; great is your faithfulness.';

  @override
  String get journalResolutionRef => 'Lamentations 3:22–23';

  @override
  String get journalReflectionTitle => 'Reflection';

  @override
  String get journalReflectionPrompt => 'How was your day?';

  @override
  String get journalReflectionHint => 'Write freely...';

  @override
  String get journalSinsTitle => 'Mark sins';

  @override
  String get journalSinsPrompt => 'Where did I fall short today?';

  @override
  String get journalNoSinsMarked => 'Nothing marked yet';

  @override
  String get journalAddSin => 'Mark a sin';

  @override
  String get journalRemoveSin => 'Remove';

  @override
  String get journalResolutionTitle => 'Hope & Resolution';

  @override
  String get journalResolutionPrompt => 'One gift for tomorrow';

  @override
  String get journalResolutionHint => 'With Your grace, tomorrow I will…';

  @override
  String get journalMoodTitle => 'Mood';

  @override
  String get journalMoodPrompt => 'How is your soul tonight?';

  @override
  String get journalMoodDesolate => 'Desolate';

  @override
  String get journalMoodStruggling => 'Struggling';

  @override
  String get journalMoodSteady => 'Steady';

  @override
  String get journalMoodGrateful => 'Grateful';

  @override
  String get journalMoodConsoled => 'Consoled';

  @override
  String get journalSaved => 'Saved';

  @override
  String get journalSaving => 'Saving...';

  @override
  String get journalDeleteEntry => 'Delete entry';

  @override
  String get journalDeleteEntryConfirm =>
      'Delete this day\'s entry? This cannot be undone.';

  @override
  String get journalEntryDeleted => 'Entry deleted';

  @override
  String get journalPickerQuestions => 'Questions';

  @override
  String get journalPickerMySins => 'My sins';

  @override
  String get journalPickerOwnWords => 'In my own words';

  @override
  String get journalPickerFreeTextHint => 'Describe it in your own words';

  @override
  String get journalSearchSins => 'Search sins...';

  @override
  String get journalAbsolved => 'Confessed';

  @override
  String get journalSinCleared => 'A sin you brought to confession';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Include the $count sins you marked in your journal',
      one: 'Include the sin you marked in your journal',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Include';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sins added from your journal',
      one: '1 sin added from your journal',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Struggle areas';

  @override
  String get journalStruggleAreasSubtitle =>
      'Most often marked in your journal';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marks',
      one: '1 mark',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Journal reminder';

  @override
  String get journalReminderSubtitle =>
      'A nightly nudge to reflect on your day';

  @override
  String get enableJournalReminder => 'Enable journal reminder';

  @override
  String get journalReminderNotificationTitle => 'Evening reflection';

  @override
  String get journalReminderNotificationBody =>
      'Take a moment to look back on your day with God';

  @override
  String get confessionDayMode => 'Confession Mode';

  @override
  String get confessionDayModeDescription =>
      'Large, distraction-free text for the confessional';

  @override
  String get exitConfessionMode => 'Exit confession mode';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get next => 'Next';

  @override
  String get actOfContrition => 'Act of Contrition';

  @override
  String get actOfContritionUnavailable =>
      'The Act of Contrition is unavailable';

  @override
  String get confessionDaySinsTitle => 'Sins to confess';

  @override
  String get confessionDayOpeningTitle => 'Opening';

  @override
  String get confessionDayOpeningIntro =>
      'Make the Sign of the Cross, then begin:';

  @override
  String get confessionDayOpeningFormula =>
      'Bless me, Father, for I have sinned.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'It has been $duration since my last confession.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'It has been [days/weeks/months/years] since my last confession.';

  @override
  String get confessionDaySinsClosing =>
      'For these and all my sins, I am truly sorry.';

  @override
  String get confessionDayThanksgivingTitle => 'Go in peace';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Give thanks to the Lord, for He is good.';

  @override
  String get confessionDayThanksgivingResponse => 'His mercy endures forever.';

  @override
  String get confessionDayThanksgivingBody =>
      'You have been washed clean. Complete your penance, and go forward in the peace of Christ.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '1 month',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '1 year',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Lent';

  @override
  String get seasonHolyWeek => 'Holy Week';

  @override
  String get seasonAdvent => 'Advent';

  @override
  String get seasonChristmas => 'Christmas';

  @override
  String get seasonEaster => 'Easter';

  @override
  String get seasonOrdinaryTime => 'Ordinary Time';

  @override
  String get feastAshWednesday => 'Ash Wednesday';

  @override
  String get feastPalmSunday => 'Palm Sunday';

  @override
  String get feastEaster => 'Easter';

  @override
  String get feastPentecost => 'Pentecost';

  @override
  String get feastAssumption => 'The Assumption';

  @override
  String get feastAllSaints => 'All Saints';

  @override
  String get feastImmaculateConception => 'The Immaculate Conception';

  @override
  String get feastFirstSundayOfAdvent => 'The First Sunday of Advent';

  @override
  String get feastChristmas => 'Christmas';

  @override
  String get liturgicalLentTitle => 'Lent has begun';

  @override
  String get liturgicalLentBody =>
      'A season of returning. Many begin it with confession.';

  @override
  String get liturgicalHolyWeekTitle => 'Holy Week has begun';

  @override
  String get liturgicalHolyWeekBody =>
      'The Church walks toward Easter. There is still time to prepare your heart.';

  @override
  String get liturgicalAdventTitle => 'Advent has begun';

  @override
  String get liturgicalAdventBody =>
      'A season of waiting. Many prepare their hearts with confession.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast is near';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days away — prepare your heart.',
      one: 'One day away — prepare your heart.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'It has been $count weeks since your last confession',
      one: 'It has been a week since your last confession',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Whenever you are ready, mercy is waiting. Would you like to prepare?';

  @override
  String get promptPrepare => 'Prepare';

  @override
  String get dataUnrecoverableTitle => 'Your data cannot be unlocked';

  @override
  String get dataUnrecoverableBody =>
      'The key that protects your confessions is no longer available on this device. This can happen after restoring from a backup, or if the device security settings were reset.\n\nBecause your data is encrypted, it cannot be recovered without that key — not even by us. You can erase it and begin again.';

  @override
  String get eraseAndStartOver => 'Erase and start over';

  @override
  String get eraseAndStartOverConfirm =>
      'This permanently erases everything stored on this device and starts the app fresh. It cannot be undone.';

  @override
  String get penanceSaveFailed =>
      'Could not save the penance. Please try again.';

  @override
  String get confessionReminderChannelName => 'Confession Reminders';

  @override
  String get confessionReminderChannelDescription => 'Reminders for confession';

  @override
  String get journalReminderChannelName => 'Journal Reminders';

  @override
  String get journalReminderChannelDescription =>
      'Daily reminder to write the evening reflection';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count named so far',
      one: 'One named so far',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Before you begin';

  @override
  String get invitationCardAction => 'Encourage me';

  @override
  String get homeCtaBeginTitle => 'Begin your examination';

  @override
  String get homeCtaBeginSubtitle => 'Prepare your heart before confession';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue your examination ($count selected)',
      one: 'Continue your examination (1 selected)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Pick up where you left off';

  @override
  String get homeCtaReadyTitle => 'You\'re ready';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sins are waiting in your confession list',
      one: '1 sin is waiting in your confession list',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Complete your penance';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penances are still waiting',
      one: '1 penance is still waiting',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Encouragement, a step-by-step guide, prayers and FAQs';

  @override
  String get homeQuoteReadMore => 'Read more';

  @override
  String get homeQuoteShowLess => 'Show less';

  @override
  String get tutorialJournalDesc =>
      'Look back on your day each evening: a short reflection, and your streak.';
}
