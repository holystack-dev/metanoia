// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'வரவேற்பு';

  @override
  String get examineTitle => 'பரிசோதனை';

  @override
  String get confessTitle => 'பாவ அறிக்கை';

  @override
  String get prayersTitle => 'செபங்கள்';

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get examinationTitle => 'ஆன்ம பரிசோதனை';

  @override
  String get commandment => 'கட்டளை';

  @override
  String get guideTitle => 'வழிகாட்டி';

  @override
  String get faqTitle => 'பாவ அறிக்கையைப் புரிந்துகொள்ளுதல்';

  @override
  String get language => 'மொழி';

  @override
  String get chooseLanguage => 'உங்களுக்கு விருப்பமான மொழியைத் தேர்ந்தெடுங்கள்';

  @override
  String get theme => 'தோற்றம்';

  @override
  String get chooseTheme => 'உங்களுக்கு விருப்பமான தோற்றத்தைத் தேர்ந்தெடுங்கள்';

  @override
  String get system => 'சாதன அமைப்பு';

  @override
  String get light => 'ஒளி';

  @override
  String get dark => 'இருள்';

  @override
  String get reminders => 'நினைவூட்டல்கள்';

  @override
  String get getReminded => 'பாவ அறிக்கைக்குச் செல்ல நினைவூட்டல் பெறுங்கள்';

  @override
  String get enableReminders => 'நினைவூட்டல்களை இயக்கவும்';

  @override
  String get weekly => 'வாராந்திரம்';

  @override
  String get biweekly => 'இரு வாரங்களுக்கு ஒருமுறை';

  @override
  String get monthly => 'மாதாந்திரம்';

  @override
  String get quarterly => 'மும்மாதம் ஒருமுறை';

  @override
  String get day => 'நாள்';

  @override
  String get time => 'நேரம்';

  @override
  String get remindMe => 'எனக்கு நினைவூட்டவும்';

  @override
  String get onTheDay => 'அன்றைய நாளில்';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாள்களுக்கு முன்',
      one: '1 நாளுக்கு முன்',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'விரைவுச் செயல்கள்';

  @override
  String get lastConfession => 'கடைசி பாவ அறிக்கை';

  @override
  String get noneYet => 'இதுவரை இல்லை';

  @override
  String get today => 'இன்று';

  @override
  String get yesterday => 'நேற்று';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாள்கள் முன்பு',
      one: '1 நாள் முன்பு',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'அடுத்த நினைவூட்டல்';

  @override
  String get off => 'இல்லை';

  @override
  String get mon => 'திங்';

  @override
  String get tue => 'செவ்';

  @override
  String get wed => 'புத';

  @override
  String get thu => 'வியா';

  @override
  String get fri => 'வெள்';

  @override
  String get sat => 'சனி';

  @override
  String get sun => 'ஞாயி';

  @override
  String get monday => 'திங்கள்';

  @override
  String get tuesday => 'செவ்வாய்';

  @override
  String get wednesday => 'புதன்';

  @override
  String get thursday => 'வியாழன்';

  @override
  String get friday => 'வெள்ளி';

  @override
  String get saturday => 'சனி';

  @override
  String get sunday => 'ஞாயிறு';

  @override
  String get appLanguage => 'செயலி மொழி';

  @override
  String get appLanguageSubtitle =>
      'பொத்தான்கள், தலைப்புகள், பட்டிகளுக்கான மொழி';

  @override
  String get contentLanguage => 'உள்ளடக்க மொழி';

  @override
  String get contentLanguageSubtitle =>
      'ஆன்ம பரிசோதனைக் கேள்விகள், அடிக்கடி கேட்கப்படும் கேள்விகள், செபங்களுக்கான மொழி';

  @override
  String get version => 'பதிப்பு';

  @override
  String get selectDay => 'நாளைத் தேர்ந்தெடுங்கள்';

  @override
  String selected(num count) {
    return '$count தேர்ந்தெடுக்கப்பட்டது';
  }

  @override
  String get selectedLabel => 'தேர்ந்தெடுக்கப்பட்டது';

  @override
  String get counter => 'எண்ணிக்கை';

  @override
  String get searchPlaceholder => 'கட்டளைகள் அல்லது கேள்விகளைத் தேடுங்கள்...';

  @override
  String get noResults => 'முடிவுகள் எதுவும் இல்லை';

  @override
  String get viewHistory => 'வரலாற்றைக் காண்க';

  @override
  String get noActiveConfession => 'செயலில் உள்ள பாவ அறிக்கை இல்லை';

  @override
  String get startExaminationPrompt =>
      'இங்கே பாவங்களைச் சேர்க்க ஆன்ம பரிசோதனையைத் தொடங்குங்கள்.';

  @override
  String get startExamination => 'ஆன்ம பரிசோதனையைத் தொடங்குங்கள்';

  @override
  String get finishConfessionTitle => 'பாவ அறிக்கையை முடிக்கவா?';

  @override
  String get finishConfessionContent =>
      'இது இந்தப் பாவ அறிக்கையை நிறைவுற்றதாகக் குறித்து, உங்கள் வரலாற்றுக்கு நகர்த்தும்.';

  @override
  String get cancel => 'ரத்து செய்';

  @override
  String get finish => 'முடிக்க';

  @override
  String get confessionCompletedMessage =>
      'பாவ அறிக்கை நிறைவுற்றது! கடவுள் உங்களை ஆசீர்வதிப்பாராக.';

  @override
  String get finishConfession => 'பாவ அறிக்கையை முடிக்கவும்';

  @override
  String get error => 'பிழை';

  @override
  String get retry => 'மீண்டும் முயலவும்';

  @override
  String get dailyQuoteError => 'இன்றைய மேற்கோளை ஏற்ற முடியவில்லை.';

  @override
  String get keepHistory => 'பாவ அறிக்கை வரலாற்றைச் சேமிக்கவும்';

  @override
  String get keepHistorySubtitle =>
      'உங்கள் பாவங்களைத் தேதியுடன் சேமிக்கும். முடக்கினால், தேதி மட்டுமே சேமிக்கப்படும்.';

  @override
  String get deleteConfession => 'பாவ அறிக்கையை நீக்கவும்';

  @override
  String get deleteConfessionContent =>
      'இது இந்தப் பாவ அறிக்கையையும் அதிலுள்ள அனைத்தையும் உங்கள் வரலாற்றிலிருந்து நிரந்தரமாக நீக்கும். இந்தச் செயலைத் திரும்பப் பெற முடியாது.';

  @override
  String get tutorialExamineDesc =>
      'பாவ அறிக்கைக்கு முன் உங்கள் மனசாட்சியை ஆராய இங்கே தொடங்குங்கள்.';

  @override
  String get tutorialConfessDesc =>
      'பாவ அறிக்கையின் போது உங்கள் பாவங்களைக் கண்காணிக்க இதைப் பயன்படுத்துங்கள்.';

  @override
  String get tutorialPrayersDesc =>
      'பாவ அறிக்கைக்கு முன்னும் பின்னும் சொல்லும் செபங்களை இங்கே காணுங்கள்.';

  @override
  String get tutorialGuideDesc =>
      'ஊக்கமளிக்கும் வார்த்தைகள், படிப்படியான பாவ அறிக்கை வழிகாட்டி, அடிக்கடி கேட்கப்படும் கேள்விகள் ஆகியவை இங்கே உள்ளன.';

  @override
  String get tutorialSettingsDesc =>
      'உங்கள் அனுபவத்தை இங்கே தனிப்பயனாக்குங்கள்: மொழி, தோற்றம் ஆகியவற்றை மாற்றலாம், நினைவூட்டல்களை அமைக்கலாம், பாதுகாப்பு அமைப்புகளை நிர்வகிக்கலாம்.';

  @override
  String get tutorialSwipeDesc =>
      'கட்டளைகளுக்கு இடையே செல்ல இடது அல்லது வலது புறமாக விரலைத் தேய்த்து நகர்த்துங்கள்.';

  @override
  String get tutorialSelectDesc =>
      'உங்கள் பாவ அறிக்கைக்காக ஒரு கேள்வியைத் தேர்ந்தெடுக்க அதைத் தட்டுங்கள்.';

  @override
  String get tutorialFinishDesc =>
      'முடிந்ததும், நிறைவு செய்து பாவ அறிக்கைக்குச் செல்ல இங்கே தட்டுங்கள்.';

  @override
  String get tutorialCounterDesc =>
      'பாவ அறிக்கைக்காக நீங்கள் எத்தனை தேர்ந்தெடுத்துள்ளீர்கள் என்பதை இது காட்டுகிறது.';

  @override
  String get tutorialMenuDesc =>
      'சொந்தப் பாவங்களைச் சேர்க்கவும் உங்கள் தேர்வுகளை அழிக்கவும் இங்கிருந்து செல்லுங்கள்.';

  @override
  String get tutorialPenanceDesc =>
      'உங்கள் குரு அளித்த பரிகாரங்களை இங்கே கண்காணியுங்கள்.';

  @override
  String get tutorialInsightsDesc =>
      'உங்கள் பாவ அறிக்கைப் பயணத்தின் புள்ளிவிவரங்களையும் தொடர்ச்சிகளையும் இங்கே காணுங்கள்.';

  @override
  String get tutorialHistoryDesc =>
      'உங்கள் கடந்த கால பாவ அறிக்கைகளையும் அவற்றின் தேதிகளையும் இங்கே காணுங்கள்.';

  @override
  String get replayTutorial => 'அறிமுக வழிகாட்டியை மீண்டும் காண்க';

  @override
  String get replayTutorialDesc =>
      'செயலியின் அறிமுக வழிகாட்டியை மீண்டும் பாருங்கள்';

  @override
  String get tutorialReset =>
      'அறிமுக வழிகாட்டி மீட்டமைக்கப்பட்டது! வழிகாட்டுதல்களை மீண்டும் காண்பீர்கள்.';

  @override
  String get about => 'செயலி பற்றி';

  @override
  String get aboutSubtitle => 'பதிப்பு, உரிமம் மற்றும் மூலக் குறியீடு';

  @override
  String get shareApp => 'செயலியைப் பகிரவும்';

  @override
  String get shareAppSubtitle => 'நண்பர்களுடனும் குடும்பத்தினருடனும் பகிரவும்';

  @override
  String get rateApp => 'செயலிக்கு மதிப்பீடு அளிக்கவும்';

  @override
  String get spreadShareTitle => 'Metanoia-வைப் பகிருங்கள்';

  @override
  String get spreadShareSubtitle =>
      'பாவ அறிக்கையிலிருந்து விலகியிருக்கும் யாரையாவது அறிவீர்களா? அவர்கள் திரும்பி வர உதவுங்கள்.';

  @override
  String get spreadShareAction => 'பகிர்';

  @override
  String get spreadRateSubtitle =>
      'பாவ அறிக்கைக்குத் தயாராவதற்கு Metanoia உங்களுக்கு உதவினால், ஒரு மதிப்பீடு மற்றவர்கள் இதைக் கண்டறிய உதவும்.';

  @override
  String get spreadRateAction => 'மதிப்பிடு';

  @override
  String get rateGateHint => 'உங்கள் அனுபவத்தை எப்படி மதிப்பிடுவீர்கள்?';

  @override
  String get rateGateLowest => 'மிகக் குறைவு';

  @override
  String get rateGateHighest => 'மிக அதிகம்';

  @override
  String get rateGateThanks =>
      'நன்றி — உங்கள் கருத்து எங்களுக்கு மிகவும் முக்கியம்.';

  @override
  String rateAppSubtitle(String store) {
    return '$store-இல் எங்களுக்கு மதிப்பீடு அளியுங்கள்';
  }

  @override
  String get website => 'இணையதளம்';

  @override
  String get privacyPolicy => 'தனியுரிமைக் கொள்கை';

  @override
  String get madeWithLove => 'holystack.dev அன்புடன் உருவாக்கியது ❤️';

  @override
  String get rateDialogTitle => 'Metanoia உங்களுக்குப் பயனளிக்கிறதா?';

  @override
  String get rateDialogContent =>
      'இந்தச் செயலி உங்களுக்கு உதவியாக இருந்தால், சிறிது நேரம் ஒதுக்கி மதிப்பீடு அளியுங்கள். இது எங்களுக்குப் பெரிதும் உதவும்!';

  @override
  String get rateDialogYes => 'இப்போது மதிப்பிடுங்கள்';

  @override
  String get rateDialogNo => 'வேண்டாம், நன்றி';

  @override
  String get rateDialogLater => 'பிறகு நினைவூட்டவும்';

  @override
  String get greekLabel => 'கிரேக்கம்';

  @override
  String get nounLabel => 'பெயர்ச்சொல்';

  @override
  String get metanoiaDefinition =>
      'மனதிலும் இதயத்திலும் ஏற்படும் ஆழமான மாற்றம்; ஒருவரின் முழு இருப்பையும் புதுப்பித்து, அவரது வாழ்வை இறைவனை நோக்கித் திருப்பும் ஆன்மீக விழிப்பு.';

  @override
  String get turnBackToGrace => 'அருளை நோக்கித் திரும்புங்கள்';

  @override
  String get welcomeSubtitle => 'அர்த்தமுள்ள பாவ அறிக்கைக்கான உங்கள் வழிகாட்டி';

  @override
  String get discoverInnerGrace => 'உள்ளான அருளைக் கண்டடையுங்கள்';

  @override
  String get sacredJourneyBegins => 'ஒப்புரவின் புனிதப் பயணம் தொடங்குகிறது.';

  @override
  String get beginJourney => 'பயணத்தைத் தொடங்குங்கள்';

  @override
  String get getStarted => 'தொடங்குங்கள்';

  @override
  String get chooseContentLanguage => 'உள்ளடக்க மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get contentLanguageDescription =>
      'செபங்கள், ஆன்ம பரிசோதனை மற்றும் வழிகாட்டிகளுக்கான மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get changeAnytimeNote =>
      'அமைப்புகளில் இதை எப்போது வேண்டுமானாலும் மாற்றலாம்';

  @override
  String get continueButton => 'தொடரவும்';

  @override
  String get examineDescription =>
      'பாவ அறிக்கைக்கு முன், பத்துக் கட்டளைகளின் அடிப்படையில் உங்கள் ஆன்மாவைப் பரிசோதியுங்கள்';

  @override
  String get confessDescription =>
      'பாவ அறிக்கையின்போது எதுவும் மறக்கப்படாமல் இருக்க, உங்கள் பாவங்களைக் கண்காணியுங்கள்';

  @override
  String get prayersDescription =>
      'பாவ அறிக்கைக்கு முன்பும் பின்பும் உள்ள செபங்களையும், பரிகாரச் செபங்களையும் அணுகுங்கள்';

  @override
  String get remindersDescription =>
      'பாவ அறிக்கைக்குச் செல்ல மறக்காதிருக்க, அமைப்புகளில் வழக்கமான நினைவூட்டல்களை அமையுங்கள்';

  @override
  String get nextButton => 'அடுத்து';

  @override
  String get customSins => 'தனிப்பயன் பாவங்கள்';

  @override
  String get manageCustomSins => 'தனிப்பயன் பாவங்களை நிர்வகிக்கவும்';

  @override
  String get addCustomSin => 'தனிப்பயன் பாவத்தைச் சேர்க்கவும்';

  @override
  String get editCustomSin => 'தனிப்பயன் பாவத்தைத் திருத்தவும்';

  @override
  String get deleteCustomSin => 'தனிப்பயன் பாவத்தை நீக்கவும்';

  @override
  String get sinDescription => 'பாவ விவரம்';

  @override
  String get sinDescriptionHint =>
      'நீங்கள் நினைவில் கொள்ள விரும்பும் பாவத்தை விவரியுங்கள்';

  @override
  String get sinDescriptionRequired => 'பாவ விவரத்தை உள்ளிடவும்';

  @override
  String get optionalNote => 'விருப்பக் குறிப்பு';

  @override
  String get optionalNoteHint => 'கூடுதல் விவரங்களைச் சேர்க்கவும்';

  @override
  String get selectCommandment =>
      'கட்டளையைத் தேர்ந்தெடுக்கவும் (விருப்பத்திற்குரியது)';

  @override
  String get noCommandment => 'பொதுவானது / கட்டளை இல்லை';

  @override
  String get customSinAdded => 'தனிப்பயன் பாவம் சேர்க்கப்பட்டது';

  @override
  String get customSinUpdated => 'தனிப்பயன் பாவம் புதுப்பிக்கப்பட்டது';

  @override
  String get customSinDeleted => 'தனிப்பயன் பாவம் நீக்கப்பட்டது';

  @override
  String get deleteCustomSinConfirm =>
      'இந்தத் தனிப்பயன் பாவத்தை நீக்க விரும்புகிறீர்களா?';

  @override
  String get noCustomSins => 'தனிப்பயன் பாவங்கள் எதுவும் இல்லை';

  @override
  String get noCustomSinsDesc =>
      'உங்கள் ஆன்ம பரிசோதனையைத் தனிப்பயனாக்க தனிப்பயன் பாவங்களைச் சேர்க்கவும்';

  @override
  String get customVersion => 'தனிப்பயன் (திருத்தப்பட்டது)';

  @override
  String get searchCustomSins => 'தனிப்பயன் பாவங்களைத் தேடுங்கள்...';

  @override
  String get addButton => 'சேர்';

  @override
  String get updateButton => 'புதுப்பி';

  @override
  String get deleteButton => 'நீக்கு';

  @override
  String get addYourOwn => 'உங்கள் சொந்தப் பாவத்தைச் சேர்க்கவும்...';

  @override
  String get penance => 'பரிகாரம்';

  @override
  String get penanceTracker => 'பரிகாரக் கண்காணிப்பு';

  @override
  String get addPenance => 'பரிகாரத்தைச் சேர்க்கவும்';

  @override
  String get editPenance => 'பரிகாரத்தைத் திருத்தவும்';

  @override
  String get penanceDescription => 'உங்களுக்கு அளிக்கப்பட்ட பரிகாரம் என்ன?';

  @override
  String get penanceHint =>
      'எ.கா., 3 அருள் நிறை மந்திரம் செபிக்கவும், ஒரு விவிலியப் பகுதியை வாசிக்கவும்...';

  @override
  String get penanceAdded => 'பரிகாரம் சேர்க்கப்பட்டது';

  @override
  String get penanceUpdated => 'பரிகாரம் புதுப்பிக்கப்பட்டது';

  @override
  String get penanceCompleted =>
      'பரிகாரம் நிறைவேற்றப்பட்டது! இறைவன் உங்களை ஆசீர்வதிப்பாராக.';

  @override
  String get markAsComplete => 'நிறைவுற்றதாகக் குறிக்கவும்';

  @override
  String get pendingPenances => 'நிலுவையிலுள்ள பரிகாரங்கள்';

  @override
  String get noPendingPenances => 'நிலுவையில் பரிகாரங்கள் எதுவும் இல்லை';

  @override
  String get noPendingPenancesDesc =>
      'உங்கள் பரிகாரங்கள் அனைத்தும் நிறைவேற்றப்பட்டுவிட்டன. இறைவன் ஆசீர்வதிப்பாராக!';

  @override
  String completedOn(Object date) {
    return '$date அன்று நிறைவேற்றப்பட்டது';
  }

  @override
  String assignedOn(Object date) {
    return '$date அன்று அளிக்கப்பட்டது';
  }

  @override
  String get skipPenance => 'தவிர்';

  @override
  String get savePenance => 'பரிகாரத்தைச் சேமிக்கவும்';

  @override
  String get insights => 'புள்ளிவிவரங்கள்';

  @override
  String get confessionInsights => 'பாவ அறிக்கை புள்ளிவிவரங்கள்';

  @override
  String get totalConfessions => 'மொத்தப் பாவ அறிக்கைகள்';

  @override
  String get averageFrequency => 'சராசரி இடைவெளி';

  @override
  String everyXDays(Object count) {
    return 'ஒவ்வொரு $count நாட்களுக்கும்';
  }

  @override
  String get daysSinceLastConfession => 'கடைசியிலிருந்து நாட்கள்';

  @override
  String get currentStreak => 'தற்போதைய தொடர்';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count வாரங்கள்',
      one: '1 வாரம்',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'மாதாந்திரச் செயல்பாடு';

  @override
  String get confessionsThisYear => 'இந்த ஆண்டின் பாவ அறிக்கைகள்';

  @override
  String get noInsightsYet => 'இன்னும் புள்ளிவிவரங்கள் இல்லை';

  @override
  String get noInsightsYetDesc =>
      'உங்கள் ஆன்மீகப் பயணப் புள்ளிவிவரங்களைக் காண, முதல் பாவ அறிக்கையை நிறைவு செய்யுங்கள்';

  @override
  String get totalItemsConfessed => 'அறிக்கையிடப்பட்ட மொத்தப் பாவங்கள்';

  @override
  String get firstConfession => 'முதல் பாவ அறிக்கை';

  @override
  String get spiritualJourney => 'உங்கள் ஆன்மீகப் பயணம்';

  @override
  String get listView => 'பட்டியல்';

  @override
  String get guidedView => 'வழிகாட்டுதல்';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$total-இல் $current';
  }

  @override
  String get previousCommandment => 'முந்தைய';

  @override
  String get nextCommandment => 'அடுத்து';

  @override
  String get finishExamination => 'முடிக்கவும்';

  @override
  String get noQuestionsSelected =>
      'இந்தப் பகுதியில் எந்தக் கேள்வியும் தேர்ந்தெடுக்கப்படவில்லை';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count தேர்ந்தெடுக்கப்பட்டுள்ளன';
  }

  @override
  String get examinationSummary => 'ஆன்ம பரிசோதனைச் சுருக்கம்';

  @override
  String get examinationNote =>
      'முழுமையான ஆன்ம பரிசோதனை எந்தப் பட்டியலையும் தாண்டியது. உங்கள் வாழ்க்கை நிலையையும் சூழ்நிலைகளையும் செபத்துடன் சிந்தித்துப் பாருங்கள்.';

  @override
  String selectedCount(Object count) {
    return '$count உருப்படிகள் தேர்ந்தெடுக்கப்பட்டுள்ளன';
  }

  @override
  String get noSinsSelected => 'பாவங்கள் எதுவும் தேர்ந்தெடுக்கப்படவில்லை';

  @override
  String get continueEditing => 'தொடர்ந்து திருத்து';

  @override
  String get proceedToConfess => 'தொடரவும்';

  @override
  String get clearDraftTitle => 'வரைவை அழிக்கவா?';

  @override
  String get clearDraftMessage =>
      'தேர்ந்தெடுக்கப்பட்ட அனைத்துக் கேள்விகளும் நீக்கப்படும். உறுதியாக இருக்கிறீர்களா?';

  @override
  String get clearDraft => 'வரைவை அழி';

  @override
  String get clear => 'அழி';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'உங்கள் கடைசி அமர்விலிருந்து $count உருப்படிகள் மீட்கப்பட்டன',
      one: 'உங்கள் கடைசி அமர்விலிருந்து 1 உருப்படி மீட்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'இப்போதுதான்';

  @override
  String minutesAgo(Object count) {
    return '$count நிமிடங்களுக்கு முன்';
  }

  @override
  String hoursAgo(Object count) {
    return '$count மணி நேரத்திற்கு முன்';
  }

  @override
  String get general => 'பொது';

  @override
  String get noQuestionsInSection => 'இந்தப் பகுதியில் கேள்விகள் இல்லை';

  @override
  String get skip => 'தவிர்';

  @override
  String get back => 'பின்';

  @override
  String get skipOnboardingTitle => 'அறிமுகத்தைத் தவிர்க்கவா?';

  @override
  String get skipOnboardingMessage =>
      'நேரடியாகக் கடைசிப் பக்கத்திற்குச் செல்வீர்கள். இங்கு எதுவும் அமைக்கப்படவில்லை — அனைத்தையும் பின்னர் அமைப்புகளில் மாற்றிக்கொள்ளலாம்.';

  @override
  String get confessionHistoryTitle => 'பாவ அறிக்கை வரலாறு';

  @override
  String get deleteAll => 'அனைத்தையும் நீக்கு';

  @override
  String get editDate => 'தேதியைத் திருத்து';

  @override
  String get confessionDate => 'பாவ அறிக்கை தேதி';

  @override
  String get dateUpdated => 'தேதி புதுப்பிக்கப்பட்டது';

  @override
  String get changeDateConfirmTitle => 'தேதியை மாற்றவா?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'பாவ அறிக்கை தேதியை $date என மாற்றவா?';
  }

  @override
  String get noGuideContent => 'வழிகாட்டி உள்ளடக்கம் எதுவும் இல்லை';

  @override
  String get noGuideContentDesc => 'வழிகாட்டி உள்ளடக்கம் இங்கே தோன்றும்';

  @override
  String get noFaqContent => 'கேள்வி-பதில்கள் எதுவும் இல்லை';

  @override
  String get noFaqContentDesc =>
      'அடிக்கடி கேட்கப்படும் கேள்விகள் இங்கே தோன்றும்';

  @override
  String get faqSubtitle => 'ஒப்புரவு அருளடையாளத்திற்கான வழிகாட்டி';

  @override
  String get tapToExpand => 'மேலும் படிக்கத் தட்டவும்';

  @override
  String get continueExamination => 'ஆன்ம பரிசோதனையைத் தொடரவும்';

  @override
  String get continueExaminationDesc =>
      'நீங்கள் ஒரு ஆன்ம பரிசோதனையை நடுவில் விட்டுள்ளீர்கள்';

  @override
  String examinationProgress(Object count) {
    return '$count உருப்படிகள் தேர்ந்தெடுக்கப்பட்டுள்ளன';
  }

  @override
  String get security => 'பாதுகாப்பு';

  @override
  String get securitySubtitle => 'உங்கள் தனிப்பட்ட தரவைப் பாதுகாக்கவும்';

  @override
  String get pinAndBiometric => 'PIN மற்றும் உயிரியளவை';

  @override
  String get pinAndBiometricSubtitle =>
      'செயலிப் பூட்டு அமைப்புகளை உள்ளமைக்கவும்';

  @override
  String get enterPin => 'PIN ஐ உள்ளிடவும்';

  @override
  String get createPin => 'PIN ஐ உருவாக்கவும்';

  @override
  String get confirmPin => 'PIN ஐ உறுதிப்படுத்தவும்';

  @override
  String get incorrectPin => 'தவறான PIN';

  @override
  String get pinMismatch => 'PIN கள் பொருந்தவில்லை';

  @override
  String get biometricUnlock => 'உயிரியளவைத் திறப்பு';

  @override
  String get autoLockTimeout => 'தானியங்கிப் பூட்டு நேரம்';

  @override
  String get tooManyAttempts => 'பல முறை தவறாக முயற்சித்துள்ளீர்கள்';

  @override
  String tryAgainIn(Object time) {
    return '$time கழித்து மீண்டும் முயற்சிக்கவும்';
  }

  @override
  String get useBiometricUnlock => 'உயிரியளவைத் திறப்பைப் பயன்படுத்தவும்';

  @override
  String get unlockWithFingerprintOrFace =>
      'கைரேகை அல்லது முகத்தால் திறக்கவும்';

  @override
  String get biometricAccessWarning =>
      'இந்தச் சாதனத்தில் பதிவு செய்யப்பட்ட கைரேகை அல்லது முகம் உள்ள எவரும் இந்தச் செயலியை அணுக முடியும்';

  @override
  String get lockAfter => 'பூட்டும் நேரம்';

  @override
  String get timeInBackgroundBeforeLocking =>
      'பூட்டுவதற்கு முன் பின்னணியில் இருக்கும் நேரம்';

  @override
  String get changePin => 'PIN ஐ மாற்று';

  @override
  String get updateYourSecurityPin =>
      'உங்கள் பாதுகாப்பு PIN ஐப் புதுப்பிக்கவும்';

  @override
  String get enterCurrentPin => 'தற்போதைய PIN ஐ உள்ளிடவும்';

  @override
  String get enterNewPin => 'புதிய PIN ஐ உள்ளிடவும்';

  @override
  String get confirmNewPin => 'புதிய PIN ஐ உறுதிப்படுத்தவும்';

  @override
  String get pinChangedSuccessfully => 'PIN வெற்றிகரமாக மாற்றப்பட்டது';

  @override
  String get currentPinIncorrect => 'தற்போதைய PIN தவறானது';

  @override
  String get enableBiometricUnlock => 'உயிரியளவைத் திறப்பை இயக்கவா?';

  @override
  String get biometricDescription =>
      'செயலியை விரைவாகவும் பாதுகாப்பாகவும் திறக்க உங்கள் கைரேகையையோ முகத்தையோ பயன்படுத்துங்கள்.';

  @override
  String get notNow => 'இப்போது வேண்டாம்';

  @override
  String get enable => 'இயக்கு';

  @override
  String get setUpPin => 'PIN ஐ அமைக்கவும்';

  @override
  String get createSixDigitPin => '6 இலக்க PIN ஐ உருவாக்கவும்';

  @override
  String get pinProtectData =>
      'உங்கள் தரவைப் பாதுகாக்க இந்த PIN பயன்படுத்தப்படும்';

  @override
  String get confirmYourPin => 'உங்கள் PIN ஐ உறுதிப்படுத்தவும்';

  @override
  String get enterSamePinAgain => 'உறுதிப்படுத்த அதே PIN ஐ மீண்டும் உள்ளிடவும்';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'திறக்க உங்கள் PIN ஐ உள்ளிடவும்';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count முயற்சிகள் மீதமுள்ளன',
      one: '1 முயற்சி மீதமுள்ளது',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count வினாடிகள்',
      one: '1 வினாடி',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நிமிடங்கள்',
      one: '1 நிமிடம்',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'செயல்தவிர்';

  @override
  String get confessionDeleted => 'பாவ அறிக்கை நீக்கப்பட்டது';

  @override
  String get noConfessionHistory => 'பாவ அறிக்கை வரலாறு இல்லை';

  @override
  String get noConfessionHistoryDesc =>
      'நிறைவு செய்யப்பட்ட பாவ அறிக்கைகள் இங்கே தோன்றும்';

  @override
  String get fontSize => 'எழுத்து அளவு';

  @override
  String get fontSizeSubtitle => 'நன்கு படிக்க எழுத்து அளவை மாற்றவும்';

  @override
  String get fontSizeSmall => 'சிறியது';

  @override
  String get fontSizeMedium => 'நடுத்தரம்';

  @override
  String get fontSizeLarge => 'பெரியது';

  @override
  String get fontSizeExtraLarge => 'மிகப் பெரியது';

  @override
  String get forgotPin => 'PIN மறந்துவிட்டதா?';

  @override
  String get resetPinTitle => 'PIN ஐ மீட்டமை';

  @override
  String get resetPinWarning =>
      'எச்சரிக்கை: இது உங்கள் அனைத்துத் தரவையும் நிரந்தரமாக நீக்கிவிடும்';

  @override
  String get resetPinDescription =>
      'நீங்கள் PIN ஐ மீட்டமைத்தால், உங்கள் அனைத்துப் பாவ அறிக்கைகள், தனிப்பயன் பாவங்கள், பரிகாரங்கள் மற்றும் பிற தனிப்பட்ட தரவு நிரந்தரமாக நீக்கப்படும். இச்செயலைத் திரும்பப் பெற முடியாது.';

  @override
  String get resetPinConfirmation =>
      'உறுதிப்படுத்த DELETE எனத் தட்டச்சு செய்யவும்';

  @override
  String get resetPinButton => 'PIN ஐ மீட்டமைத்து தரவை நீக்கு';

  @override
  String get resetPinSuccess =>
      'PIN வெற்றிகரமாக மீட்டமைக்கப்பட்டது. புதிய PIN ஐ அமைக்கவும்.';

  @override
  String get resetPinError =>
      'PIN ஐ மீட்டமைக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get deleteConfirmationText => 'DELETE';

  @override
  String resetPinWaitTimer(int seconds) {
    return '$seconds வினாடிகள் காத்திருக்கவும்';
  }

  @override
  String get resetPinBiometricPrompt =>
      'PIN மீட்டமைக்க உங்கள் அடையாளத்தை உறுதிப்படுத்தவும்';

  @override
  String get confessionGuideTitle => 'நல்ல பாவ அறிக்கை எவ்வாறு செய்வது';

  @override
  String get shortFilmTitle => 'பாவ அறிக்கை: ஒரு குறும்படம்';

  @override
  String get shortFilmSubtitle =>
      'Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, ஐக்கிய இராச்சியம் தயாரித்தது';

  @override
  String get confessionGuideSubtitle =>
      'ஒப்புரவு அருளடையாளத்திற்கான படிப்படியான வழிகாட்டி';

  @override
  String get invitationTitle =>
      'நீண்ட நாட்களுக்குப் பின் பாவ அறிக்கைக்கு வருகிறீர்களா?';

  @override
  String get invitationSubtitle => 'உங்களுக்கு ஒரு ஊக்கமூட்டும் வார்த்தை';

  @override
  String get invitationDialogTitle => 'வருக, வரவேற்கிறோம்';

  @override
  String get invitationDialogContent =>
      'நீண்ட காலத்திற்குப் பிறகு பாவ அறிக்கை செய்யப் போகிறீர்களா, அல்லது செல்வதைப் பற்றிக் கவலையாக உணர்கிறீர்களா?';

  @override
  String get invitationDialogYes => 'ஆம், எனக்குச் சிறிது ஊக்கம் வேண்டும்';

  @override
  String get invitationDialogNo => 'இல்லை, நான் தொடங்கத் தயார்';

  @override
  String get invitationDialogDontShowAgain => 'இதை மீண்டும் காட்ட வேண்டாம்';

  @override
  String get searchPrayers => 'செபங்களைத் தேடுங்கள்...';

  @override
  String get allCategories => 'அனைத்தும்';

  @override
  String get appDisclaimer =>
      'இந்தச் செயலி பாவ அறிக்கைக்குத் தயாராவதற்கான ஓர் ஆன்மீக உதவி மட்டுமே. குருவிடம் பெறும் ஒப்புரவு அருளடையாளத்திற்கு இது ஈடு அல்ல.';

  @override
  String get onboardingDisclaimer =>
      'பாவ அறிக்கைக்கு ஓர் ஆன்மீகத் துணை—அதற்கு ஈடு அல்ல.';

  @override
  String get readyToBegin => 'நீங்கள் தயார்';

  @override
  String get readyToBeginSubtitle =>
      'ஒப்புரவை நோக்கிய உங்கள் பயணம் அருளாலும் அமைதியாலும் நிறையட்டும்.';

  @override
  String get onboardingOverviewTitle => 'இந்தச் செயலி என்ன செய்கிறது';

  @override
  String get onboardingOverviewExamine =>
      'உங்கள் மனசாட்சியை உங்கள் வேகத்தில் ஆயத்தப்படுத்துங்கள்.';

  @override
  String get onboardingOverviewConfess =>
      'எதுவும் மறந்துபோகாதிருக்க, ஒரு தனிப்பட்ட பட்டியல்.';

  @override
  String get onboardingOverviewJournal =>
      'இரு பாவ அறிக்கைகளுக்கு இடையில் தொடர்ந்து வளர, ஒரு சிறு மாலைத் தியானம்.';

  @override
  String get onboardingOverviewFootnote =>
      'செபங்கள், வழிகாட்டிகள் மற்றும் விருப்பத் தூண்டுதல்கள் உள்ளே உள்ளன.';

  @override
  String get onboardingPrivacyTitle => 'தனியுரிமையுடன் வடிவமைக்கப்பட்டது';

  @override
  String get onboardingPrivacyLocal =>
      'அனைத்தும் இந்த ஃபோனிலேயே இருக்கும். கணக்கு இல்லை, கிளவுட் இல்லை.';

  @override
  String get onboardingPrivacyEncrypted =>
      'உங்கள் சாதனத்தில் மறையாக்கம் செய்யப்படுகிறது.';

  @override
  String get onboardingPrivacyPin =>
      'ஆன்ம பரிசோதனையையோ உங்கள் நாட்குறிப்பையோ முதல் முறை திறக்கும்போது நீங்கள் ஒரு PIN உருவாக்குவீர்கள்.';

  @override
  String get sourceCode => 'மூலக் குறியீடு';

  @override
  String get contentReferences => 'உள்ளடக்க மேற்கோள்கள்';

  @override
  String get examinationModeTitle =>
      'எவ்வாறு ஆன்ம பரிசோதனை செய்ய விரும்புகிறீர்கள்?';

  @override
  String get quickReviewMode => 'விரைவு மீளாய்வு';

  @override
  String get quickReviewDescription =>
      'அனைத்துக் கேள்விகளையும் பிரிவு வாரியாகப் பார்வையிடுங்கள்';

  @override
  String get deepReflectionMode => 'ஆழ்ந்த சிந்தனை';

  @override
  String get deepReflectionDescription =>
      'சிந்தனையுடன் பரிசோதிக்க ஒரு நேரத்தில் ஒரு கேள்வி';

  @override
  String get contemplativePrayerTitle => 'வாரும், தூய ஆவியே';

  @override
  String get contemplativePrayerText =>
      'என் இதயத்தை நிரப்பி, உம் அன்பின் நெருப்பை என்னில் பற்றவையும். என் பாவங்களைத் தெளிவாகக் காணும்படி என் மனதை ஒளிரச் செய்யும்.';

  @override
  String get imReady => 'நான் தயார்';

  @override
  String get skipPrayer => 'தவிர்';

  @override
  String get yesThisApplies => 'ஆம்';

  @override
  String get noThisDoesnt => 'இல்லை';

  @override
  String get skipQuestion => 'தவிர்';

  @override
  String questionProgress(int current, int total) {
    return '$total இல் $current';
  }

  @override
  String get examinationComplete => 'ஆன்ம பரிசோதனை நிறைவடைந்தது';

  @override
  String get reviewYourSelections => 'உங்கள் தேர்வுகளை மீளாய்வு செய்யுங்கள்';

  @override
  String get examinationModeSettingTitle => 'பரிசோதனை முறை';

  @override
  String get examinationModeSettingSubtitle =>
      'ஆன்ம பரிசோதனையை எவ்வாறு செய்ய விரும்புகிறீர்கள் என்பதைத் தேர்ந்தெடுங்கள்';

  @override
  String get askEveryTime => 'ஒவ்வொரு முறையும் கேளுங்கள்';

  @override
  String get reminderNotificationTitle => 'பாவ அறிக்கைக்கான நேரம்';

  @override
  String get reminderNotificationBody =>
      'ஆன்ம பரிசோதனை செய்து பாவ அறிக்கைக்குத் தயாராக நினைவில் கொள்ளுங்கள்';

  @override
  String get notificationPermissionDenied =>
      'அறிவிப்புகள் முடக்கப்பட்டுள்ளன. பாவ அறிக்கை நினைவூட்டல்களைப் பெற, உங்கள் சாதன அமைப்புகளில் Metanoia-வுக்கு அறிவிப்புகளை அனுமதிக்கவும்.';

  @override
  String get openSourceLicenses => 'திறந்த மூல உரிமங்கள்';

  @override
  String get couldNotOpenLink => 'இணைப்பைத் திறக்க முடியவில்லை';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பாவங்கள் அறிக்கையிடப்பட்டன',
      one: '1 பாவம் அறிக்கையிடப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பரிகாரங்கள்',
      one: '1 பரிகாரம்',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நிலுவையில்',
      one: '1 நிலுவையில்',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'மொத்தம் $count',
      one: 'மொத்தம் 1',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count உருப்படிகள்',
      one: '1 உருப்படி',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாட்கள்',
      one: '1 நாள்',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count வா',
      one: '1 வா',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle =>
      'அனைத்துப் பாவ அறிக்கைகளையும் நீக்கவா?';

  @override
  String get deleteAllConfessionsContent =>
      'இது உங்கள் பாவ அறிக்கை வரலாறு முழுவதையும் நிரந்தரமாக நீக்கிவிடும். இச்செயலைத் திரும்பப் பெற முடியாது.';

  @override
  String get allConfessionsDeleted => 'அனைத்துப் பாவ அறிக்கைகளும் நீக்கப்பட்டன';

  @override
  String get deletePenanceConfirm =>
      'இந்தப் பரிகாரத்தை நிச்சயம் நீக்க வேண்டுமா?';

  @override
  String get completed => 'நிறைவடைந்தது';

  @override
  String get tapToCollapse => 'மூடத் தட்டவும்';

  @override
  String get dismiss => 'நிராகரி';

  @override
  String showcaseStep(int current, int total) {
    return 'படி $current / $total';
  }

  @override
  String get done => 'முடிந்தது';

  @override
  String get navigate => 'செல்';

  @override
  String get encouragement => 'ஊக்கம்';

  @override
  String get biometricPromptReason =>
      'Metanoia-வை அணுக அடையாளத்தை உறுதிப்படுத்தவும்';

  @override
  String get tryAgainInLabel => 'மீண்டும் முயற்சிக்க';

  @override
  String get errorLoadingLanguage => 'மொழியை ஏற்றுவதில் பிழை';

  @override
  String get detailsNotSaved => 'விவரங்கள் சேமிக்கப்படவில்லை';

  @override
  String get discardStoredSinsTitle => 'சேமிக்கப்பட்ட பாவங்களை நீக்கவா?';

  @override
  String get discardStoredSinsContent =>
      'பாவ அறிக்கை வரலாறு இப்போது முடக்கப்பட்டுள்ளது. கடந்த பாவ அறிக்கைகளிலிருந்து ஏற்கெனவே சேமிக்கப்பட்ட பாவங்கள் இன்னும் இருக்கின்றன. அவற்றை நீக்கவா? தேதிகள் வைத்துக்கொள்ளப்படும், எனவே உங்கள் புள்ளிவிவரங்களும் தொடர் நாட்களும் பாதிக்கப்படாது.';

  @override
  String get keepThem => 'வைத்திரு';

  @override
  String get discard => 'நீக்கு';

  @override
  String get storedSinsDiscarded =>
      'சேமிக்கப்பட்ட பாவங்கள் நீக்கப்பட்டன. பாவ அறிக்கைத் தேதிகள் வைத்துக்கொள்ளப்பட்டன.';

  @override
  String get journalTitle => 'நாட்குறிப்பு';

  @override
  String get journalHomeCardTitle => 'மாலைத் தியானம்';

  @override
  String get journalHomeCardSubtitle => 'இன்று எப்படி இருந்தது?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாட்கள்',
      one: '$count நாள்',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'தொடர்ச்சியாகத் தியானம் செய்த நாட்கள்';

  @override
  String get journalContinueToday => 'இன்றைய பதிவைத் தொடரவும்';

  @override
  String get journalPreviousMonth => 'முந்தைய மாதம்';

  @override
  String get journalNextMonth => 'அடுத்த மாதம்';

  @override
  String get journalGratitudeTitle => 'நன்றி';

  @override
  String get journalGratitudePrompt => 'இன்று நான் கடவுளை எங்கே கண்டேன்?';

  @override
  String get journalGratitudeHint =>
      'நான் அவருக்கு நன்றி கூற விரும்பும் ஓர் அருள்…';

  @override
  String get journalPresenceLead =>
      'கடவுள் இங்கே உங்களோடு இருக்கிறார். அவர்முன் அமைதியாய் இருந்து நன்றி கூறுங்கள்.';

  @override
  String get journalPresenceVerse =>
      'அமைதி கொண்டு, நானே கடவுள் என உணர்ந்து கொள்ளுங்கள்.';

  @override
  String get journalPresenceRef => 'திருப்பாடல் 46:10';

  @override
  String get journalLightTitle => 'ஒளியை வேண்டுங்கள்';

  @override
  String get journalLightLead =>
      'கடவுள் பார்ப்பதுபோல் உங்கள் நாளைப் பார்க்க, தூய ஆவியிடம் ஒளியை வேண்டுங்கள்.';

  @override
  String get journalLightVerse =>
      'தூய ஆவியே, எழுந்தருளி வாரும், உம்மில் நம்பிக்கை கொண்டோரின் இதயங்களை நிரப்பியருளும், அவற்றில் உமது அன்பின் தீ பற்றியெரியச் செய்தருளும்.';

  @override
  String get journalReviewTitle => 'கடவுளோடு நினைவுகூருங்கள்';

  @override
  String get journalReviewLead =>
      'ஆண்டவரோடு உங்கள் நாளை மீண்டும் கடந்து செல்லுங்கள்: அன்பு உங்களிடம் வந்த இடம், நீங்கள் அதை அளித்த இடம், நீங்கள் விலகிச் சென்ற இடம்.';

  @override
  String get journalReviewVerse =>
      'இறைவா! நீர் என் உள்ளத்தை ஆய்ந்து அறியும்; என் எண்ணங்களை அறியுமாறு என்னைச் சோதித்துப் பாரும். உம்மை வருத்தும் வழியில் நான் செல்கின்றேனோ என்று பாரும்; என்றுமுள வழியில் என்னை நடத்தியருளும்.';

  @override
  String get journalReviewRef => 'திருப்பாடல் 139:23-24';

  @override
  String get journalReviewHint => 'உங்கள் நாளைப் பற்றி அவரிடம் பேசுங்கள்…';

  @override
  String get journalReviewBringSin =>
      'அவரிடம் கொண்டுவர விரும்புவது ஏதேனும் உண்டா?';

  @override
  String get journalContritionTitle => 'மனஸ்தாபம்';

  @override
  String get journalContritionLead =>
      'நீங்கள் கண்டடைந்ததைத் தந்தையிடம் கொண்டுவாருங்கள்; அவர் உங்களை எதிர்கொண்டு ஓடிவருகிறார்.';

  @override
  String get journalContritionVerse =>
      'கடவுளே! உமது பேரன்புக்கேற்ப எனக்கு இரங்கும்; உமது அளவற்ற இரக்கத்திற்கேற்ப என் குற்றங்களைத் துடைத்தருளும்.';

  @override
  String get journalContritionRef => 'திருப்பாடல் 51:1';

  @override
  String get journalContritionPray => 'மனஸ்தாபச் செபம் சொல்லுங்கள்';

  @override
  String get journalContritionMercy =>
      'கடவுள்மீதுள்ள அன்பிலிருந்து பிறக்கும் மனஸ்தாபமும், பாவ அறிக்கை செய்யும் உறுதியும், இன்றிரவு உங்கள் இதயத்தை அவரது இரக்கத்திற்குத் திறக்கின்றன; அதன் நிறைவோ பாவ அறிக்கையில், பாவ மன்னிப்பின் வார்த்தைகளில், உங்களுக்காகக் காத்திருக்கிறது.';

  @override
  String get journalResolutionLead =>
      'அவரது இரக்கத்தில் இளைப்பாறுங்கள். நாளை அவரில் மீண்டும் தொடங்குகிறது.';

  @override
  String get journalResolutionVerse =>
      'ஆண்டவரின் பேரன்பு முடிவுறவில்லை! அவரது இரக்கம் தீர்ந்துபோகவில்லை! காலைதோறும் அவை புதுப்பிக்கப்படுகின்றன! நீர் பெரிதும் நம்பிக்கைக்குரியவர்!';

  @override
  String get journalResolutionRef => 'புலம்பல் 3:22-23';

  @override
  String get journalReflectionTitle => 'சிந்தனை';

  @override
  String get journalReflectionPrompt => 'உங்கள் நாள் எப்படி இருந்தது?';

  @override
  String get journalReflectionHint => 'தயங்காமல் எழுதுங்கள்...';

  @override
  String get journalSinsTitle => 'பாவங்களைக் குறியிடுங்கள்';

  @override
  String get journalSinsPrompt => 'இன்று நான் எங்கே தவறினேன்?';

  @override
  String get journalNoSinsMarked => 'இன்னும் எதுவும் குறியிடப்படவில்லை';

  @override
  String get journalAddSin => 'ஒரு பாவத்தைக் குறிக்கவும்';

  @override
  String get journalRemoveSin => 'நீக்கு';

  @override
  String get journalResolutionTitle => 'நம்பிக்கையும் உறுதியும்';

  @override
  String get journalResolutionPrompt => 'நாளைக்கான ஓர் அருட்கொடை';

  @override
  String get journalResolutionHint => 'உம் அருளால், நாளை நான்…';

  @override
  String get journalMoodTitle => 'மனநிலை';

  @override
  String get journalMoodPrompt => 'இன்றிரவு உங்கள் ஆன்மா எப்படி இருக்கிறது?';

  @override
  String get journalMoodDesolate => 'வெறுமை';

  @override
  String get journalMoodStruggling => 'போராட்டம்';

  @override
  String get journalMoodSteady => 'சமநிலை';

  @override
  String get journalMoodGrateful => 'நன்றியுணர்வு';

  @override
  String get journalMoodConsoled => 'ஆறுதல்';

  @override
  String get journalSaved => 'சேமிக்கப்பட்டது';

  @override
  String get journalSaving => 'சேமிக்கிறது...';

  @override
  String get journalDeleteEntry => 'பதிவை நீக்கு';

  @override
  String get journalDeleteEntryConfirm =>
      'இந்நாளின் பதிவை நீக்கவா? இதைத் திரும்பப் பெற முடியாது.';

  @override
  String get journalEntryDeleted => 'பதிவு நீக்கப்பட்டது';

  @override
  String get journalPickerQuestions => 'கேள்விகள்';

  @override
  String get journalPickerMySins => 'என் பாவங்கள்';

  @override
  String get journalPickerOwnWords => 'என் சொந்த வார்த்தைகளில்';

  @override
  String get journalPickerFreeTextHint =>
      'உங்கள் சொந்த வார்த்தைகளில் விவரிக்கவும்';

  @override
  String get journalSearchSins => 'பாவங்களைத் தேடுங்கள்...';

  @override
  String get journalAbsolved => 'அறிக்கையிடப்பட்டது';

  @override
  String get journalSinCleared => 'பாவ அறிக்கையில் நீங்கள் சொன்ன ஒரு பாவம்';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'உங்கள் நாட்குறிப்பில் குறித்த $count பாவங்களைச் சேர்க்கவும்',
      one: 'உங்கள் நாட்குறிப்பில் குறித்த பாவத்தைச் சேர்க்கவும்',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'சேர்';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'நாட்குறிப்பிலிருந்து $count பாவங்கள் சேர்க்கப்பட்டன',
      one: 'நாட்குறிப்பிலிருந்து 1 பாவம் சேர்க்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'போராட்டப் பகுதிகள்';

  @override
  String get journalStruggleAreasSubtitle =>
      'உங்கள் நாட்குறிப்பில் அதிகமாகக் குறிக்கப்பட்டவை';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count முறை குறிக்கப்பட்டது',
      one: '1 முறை குறிக்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'நாட்குறிப்பு நினைவூட்டல்';

  @override
  String get journalReminderSubtitle =>
      'உங்கள் நாளைச் சிந்திக்க இரவு நேர நினைவூட்டல்';

  @override
  String get enableJournalReminder => 'நாட்குறிப்பு நினைவூட்டலை இயக்கு';

  @override
  String get journalReminderNotificationTitle => 'மாலைத் தியானம்';

  @override
  String get journalReminderNotificationBody =>
      'இறைவனோடு உங்கள் நாளைத் திரும்பிப் பார்க்க சிறிது நேரம் ஒதுக்குங்கள்';

  @override
  String get confessionDayMode => 'பாவ அறிக்கைப் பயன்முறை';

  @override
  String get confessionDayModeDescription =>
      'பாவ அறிக்கை அறைக்கான பெரிய, கவனச்சிதறல் இல்லாத எழுத்து';

  @override
  String get exitConfessionMode => 'பாவ அறிக்கைப் பயன்முறையிலிருந்து வெளியேறு';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'படி $current / $total';
  }

  @override
  String get next => 'அடுத்து';

  @override
  String get actOfContrition => 'மனஸ்தாபச் செபம்';

  @override
  String get actOfContritionUnavailable => 'மனஸ்தாபச் செபம் கிடைக்கவில்லை';

  @override
  String get confessionDaySinsTitle => 'அறிக்கையிட வேண்டிய பாவங்கள்';

  @override
  String get confessionDayOpeningTitle => 'தொடக்கம்';

  @override
  String get confessionDayOpeningIntro =>
      'சிலுவை அடையாளம் இட்டு, பின்னர் தொடங்குங்கள்:';

  @override
  String get confessionDayOpeningFormula =>
      'சுவாமி, பாவியாகிய என்னை ஆசீர்வதியும்.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'நான் பாவ அறிக்கை செய்து $duration ஆகிறது.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'நான் பாவ அறிக்கை செய்து [நாட்கள்/வாரங்கள்/மாதங்கள்/ஆண்டுகள்] ஆகிறது.';

  @override
  String get confessionDaySinsClosing =>
      'இவற்றுக்காகவும் நான் மறந்த எல்லாப் பாவங்களுக்காகவும் மனம் வருந்துகிறேன்; பாவ மன்னிப்பும் பரிகாரமும் தந்தருளும்.';

  @override
  String get confessionDayThanksgivingTitle => 'அமைதியுடன் செல்லுங்கள்';

  @override
  String get confessionDayThanksgivingVersicle =>
      'ஆண்டவருக்கு நன்றி செலுத்துங்கள், ஏனெனில் அவர் நல்லவர்.';

  @override
  String get confessionDayThanksgivingResponse =>
      'அவரது இரக்கம் என்றென்றும் நிலைத்திருக்கிறது.';

  @override
  String get confessionDayThanksgivingBody =>
      'உங்கள் ஆன்மா தூய்மையாக்கப்பட்டுள்ளது. உங்கள் பரிகாரத்தை நிறைவேற்றி, கிறிஸ்துவின் அமைதியில் முன்னேறுங்கள்.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count வாரங்கள்',
      one: '1 வாரம்',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count மாதங்கள்',
      one: '1 மாதம்',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ஆண்டுகள்',
      one: '1 ஆண்டு',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'தவக்காலம்';

  @override
  String get seasonHolyWeek => 'பெரிய வாரம்';

  @override
  String get seasonAdvent => 'திருவருகைக் காலம்';

  @override
  String get seasonChristmas => 'கிறிஸ்து பிறப்புக் காலம்';

  @override
  String get seasonEaster => 'உயிர்ப்புக் காலம்';

  @override
  String get seasonOrdinaryTime => 'பொதுக் காலம்';

  @override
  String get feastAshWednesday => 'திருநீற்றுப் புதன்';

  @override
  String get feastPalmSunday => 'குருத்து ஞாயிறு';

  @override
  String get feastEaster => 'உயிர்ப்புப் பெருவிழா';

  @override
  String get feastPentecost => 'பெந்தக்கோஸ்தே';

  @override
  String get feastAssumption => 'அன்னை மரியாவின் விண்ணேற்பு';

  @override
  String get feastAllSaints => 'அனைத்துப் புனிதர்கள் விழா';

  @override
  String get feastImmaculateConception => 'அமலோற்பவ அன்னை விழா';

  @override
  String get feastFirstSundayOfAdvent => 'திருவருகைக் காலத்தின் முதல் ஞாயிறு';

  @override
  String get feastChristmas => 'கிறிஸ்து பிறப்புப் பெருவிழா';

  @override
  String get liturgicalLentTitle => 'தவக்காலம் தொடங்கிவிட்டது';

  @override
  String get liturgicalLentBody =>
      'இது இறைவனிடம் திரும்பும் காலம். பலர் இதைப் பாவ அறிக்கையோடு தொடங்குகிறார்கள்.';

  @override
  String get liturgicalHolyWeekTitle => 'பெரிய வாரம் தொடங்கிவிட்டது';

  @override
  String get liturgicalHolyWeekBody =>
      'திருச்சபை உயிர்ப்பை நோக்கி நடக்கிறது. உங்கள் இதயத்தை ஆயத்தப்படுத்த இன்னும் நேரம் இருக்கிறது.';

  @override
  String get liturgicalAdventTitle => 'திருவருகைக் காலம் தொடங்கிவிட்டது';

  @override
  String get liturgicalAdventBody =>
      'இது காத்திருப்பின் காலம். பலர் தங்கள் இதயத்தைப் பாவ அறிக்கையால் ஆயத்தப்படுத்துகிறார்கள்.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast நெருங்கிவிட்டது';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count நாட்கள் உள்ளன — உங்கள் இதயத்தை ஆயத்தப்படுத்துங்கள்.',
      one: 'ஒரு நாள் மட்டுமே — உங்கள் இதயத்தை ஆயத்தப்படுத்துங்கள்.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'உங்கள் கடைசிப் பாவ அறிக்கைக்குப் பின் $count வாரங்கள் ஆகிவிட்டன',
      one: 'உங்கள் கடைசிப் பாவ அறிக்கைக்குப் பின் ஒரு வாரம் ஆகிவிட்டது',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'நீங்கள் ஆயத்தமாகும் எந்த நேரத்திலும் இறை இரக்கம் காத்திருக்கிறது. ஆயத்தப்பட விரும்புகிறீர்களா?';

  @override
  String get promptPrepare => 'ஆயத்தப்படுங்கள்';

  @override
  String get dataUnrecoverableTitle => 'உங்கள் தரவைத் திறக்க முடியவில்லை';

  @override
  String get dataUnrecoverableBody =>
      'உங்கள் பாவ அறிக்கைகளைப் பாதுகாக்கும் திறவுகோல் இந்தச் சாதனத்தில் இனி இல்லை. காப்புப் பிரதியிலிருந்து மீட்டெடுத்த பிறகு, அல்லது சாதனத்தின் பாதுகாப்பு அமைப்புகள் மீட்டமைக்கப்பட்டால் இது நிகழலாம்.\n\nஉங்கள் தரவு மறையாக்கம் செய்யப்பட்டுள்ளதால், அந்தத் திறவுகோல் இல்லாமல் அதை மீட்க முடியாது — எங்களாலும் முடியாது. நீங்கள் அதை அழித்துவிட்டு மீண்டும் தொடங்கலாம்.';

  @override
  String get eraseAndStartOver => 'அழித்து மீண்டும் தொடங்கு';

  @override
  String get eraseAndStartOverConfirm =>
      'இது இந்தச் சாதனத்தில் சேமிக்கப்பட்ட அனைத்தையும் நிரந்தரமாக அழித்து, செயலியைப் புதிதாகத் தொடங்கும். இதைத் திரும்பப் பெற முடியாது.';

  @override
  String get penanceSaveFailed =>
      'பரிகாரத்தைச் சேமிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get confessionReminderChannelName => 'பாவ அறிக்கை நினைவூட்டல்கள்';

  @override
  String get confessionReminderChannelDescription =>
      'பாவ அறிக்கைக்கான நினைவூட்டல்கள்';

  @override
  String get journalReminderChannelName => 'நாட்குறிப்பு நினைவூட்டல்கள்';

  @override
  String get journalReminderChannelDescription =>
      'மாலைச் சிந்தனையை எழுதத் தினசரி நினைவூட்டல்';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'இதுவரை $count குறிக்கப்பட்டன',
      one: 'இதுவரை ஒன்று குறிக்கப்பட்டது',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'நீங்கள் தொடங்கும் முன்';

  @override
  String get invitationCardAction => 'எனக்கு ஊக்கமளியுங்கள்';

  @override
  String get homeCtaBeginTitle => 'உங்கள் ஆன்ம பரிசோதனையைத் தொடங்குங்கள்';

  @override
  String get homeCtaBeginSubtitle =>
      'பாவ அறிக்கைக்கு முன் உங்கள் இதயத்தை ஆயத்தப்படுத்துங்கள்';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'உங்கள் ஆன்ம பரிசோதனையைத் தொடருங்கள் ($count தேர்ந்தெடுக்கப்பட்டன)',
      one: 'உங்கள் ஆன்ம பரிசோதனையைத் தொடருங்கள் (1 தேர்ந்தெடுக்கப்பட்டது)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'நிறுத்திய இடத்திலிருந்து தொடருங்கள்';

  @override
  String get homeCtaReadyTitle => 'நீங்கள் ஆயத்தமாகிவிட்டீர்கள்';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'உங்கள் பாவ அறிக்கைப் பட்டியலில் $count பாவங்கள் காத்திருக்கின்றன',
      one: 'உங்கள் பாவ அறிக்கைப் பட்டியலில் 1 பாவம் காத்திருக்கிறது',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'உங்கள் பரிகாரத்தை நிறைவேற்றுங்கள்';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count பரிகாரங்கள் இன்னும் காத்திருக்கின்றன',
      one: '1 பரிகாரம் இன்னும் காத்திருக்கிறது',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'ஊக்கம், படிப்படியான வழிகாட்டி, செபங்கள் மற்றும் அடிக்கடி கேட்கப்படும் கேள்விகள்';

  @override
  String get homeQuoteReadMore => 'மேலும் படிக்க';

  @override
  String get homeQuoteShowLess => 'சுருக்கு';

  @override
  String get tutorialJournalDesc =>
      'ஒவ்வொரு மாலையும் உங்கள் நாளைத் திரும்பிப் பாருங்கள்: ஒரு சிறு சிந்தனையும், உங்கள் தொடர் நாட்களும்.';
}
