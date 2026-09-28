// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'स्वागत है';

  @override
  String get examineTitle => 'आत्मपरीक्षण';

  @override
  String get confessTitle => 'पापस्वीकार';

  @override
  String get prayersTitle => 'प्रार्थनाएँ';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get examinationTitle => 'आत्मपरीक्षण';

  @override
  String get commandment => 'आज्ञा';

  @override
  String get guideTitle => 'मार्गदर्शिका';

  @override
  String get faqTitle => 'पापस्वीकार को समझें';

  @override
  String get language => 'भाषा';

  @override
  String get chooseLanguage => 'अपनी पसंदीदा भाषा चुनें';

  @override
  String get theme => 'थीम';

  @override
  String get chooseTheme => 'अपनी पसंदीदा थीम चुनें';

  @override
  String get system => 'सिस्टम';

  @override
  String get light => 'उजली';

  @override
  String get dark => 'गहरी';

  @override
  String get reminders => 'स्मरण-सूचनाएँ';

  @override
  String get getReminded => 'पापस्वीकार के लिए जाने की याद पाएँ';

  @override
  String get enableReminders => 'स्मरण-सूचनाएँ चालू करें';

  @override
  String get weekly => 'साप्ताहिक';

  @override
  String get biweekly => 'पाक्षिक';

  @override
  String get monthly => 'मासिक';

  @override
  String get quarterly => 'त्रैमासिक';

  @override
  String get day => 'दिन';

  @override
  String get time => 'समय';

  @override
  String get remindMe => 'मुझे याद दिलाएँ';

  @override
  String get onTheDay => 'उसी दिन';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन पहले',
      one: '1 दिन पहले',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'त्वरित कार्य';

  @override
  String get lastConfession => 'पिछला पापस्वीकार';

  @override
  String get noneYet => 'अभी तक कोई नहीं';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन पहले',
      one: '1 दिन पहले',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'अगली स्मरण-सूचना';

  @override
  String get off => 'बंद';

  @override
  String get mon => 'सोम';

  @override
  String get tue => 'मंगल';

  @override
  String get wed => 'बुध';

  @override
  String get thu => 'गुरु';

  @override
  String get fri => 'शुक्र';

  @override
  String get sat => 'शनि';

  @override
  String get sun => 'रवि';

  @override
  String get monday => 'सोमवार';

  @override
  String get tuesday => 'मंगलवार';

  @override
  String get wednesday => 'बुधवार';

  @override
  String get thursday => 'गुरुवार';

  @override
  String get friday => 'शुक्रवार';

  @override
  String get saturday => 'शनिवार';

  @override
  String get sunday => 'रविवार';

  @override
  String get appLanguage => 'ऐप की भाषा';

  @override
  String get appLanguageSubtitle => 'बटन, लेबल और मेन्यू की भाषा';

  @override
  String get contentLanguage => 'सामग्री की भाषा';

  @override
  String get contentLanguageSubtitle =>
      'आत्मपरीक्षण के प्रश्नों, सामान्य प्रश्नों और प्रार्थनाओं की भाषा';

  @override
  String get version => 'संस्करण';

  @override
  String get selectDay => 'दिन चुनें';

  @override
  String selected(num count) {
    return '$count चुने गए';
  }

  @override
  String get selectedLabel => 'चुने गए';

  @override
  String get counter => 'गणक';

  @override
  String get searchPlaceholder => 'आज्ञाएँ या प्रश्न खोजें...';

  @override
  String get noResults => 'कोई परिणाम नहीं मिला';

  @override
  String get viewHistory => 'इतिहास देखें';

  @override
  String get noActiveConfession => 'कोई चालू पापस्वीकार नहीं';

  @override
  String get startExaminationPrompt =>
      'यहाँ पाप जोड़ने के लिए आत्मपरीक्षण आरम्भ करें।';

  @override
  String get startExamination => 'आत्मपरीक्षण आरम्भ करें';

  @override
  String get finishConfessionTitle => 'पापस्वीकार पूरा करें?';

  @override
  String get finishConfessionContent =>
      'इससे यह पापस्वीकार पूर्ण के रूप में अंकित होगा और आपके इतिहास में चला जाएगा।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get finish => 'पूरा करें';

  @override
  String get confessionCompletedMessage =>
      'पापस्वीकार पूरा हुआ! ईश्वर आपको आशीष दे।';

  @override
  String get finishConfession => 'पापस्वीकार पूरा करें';

  @override
  String get error => 'त्रुटि';

  @override
  String get retry => 'फिर से कोशिश करें';

  @override
  String get dailyQuoteError => 'आज का वचन लोड नहीं हो सका।';

  @override
  String get keepHistory => 'पापस्वीकार का इतिहास रखें';

  @override
  String get keepHistorySubtitle =>
      'अपने पाप तिथि के साथ सहेजें। बंद रहने पर केवल तिथि सहेजी जाएगी।';

  @override
  String get deleteConfession => 'पापस्वीकार मिटाएँ';

  @override
  String get deleteConfessionContent =>
      'इससे यह पापस्वीकार और इसकी सभी प्रविष्टियाँ आपके इतिहास से हमेशा के लिए मिट जाएँगी। इस कार्य को पलटा नहीं जा सकता।';

  @override
  String get tutorialExamineDesc =>
      'पापस्वीकार से पहले अपने अंतःकरण की जाँच करने के लिए यहाँ से आरम्भ करें।';

  @override
  String get tutorialConfessDesc =>
      'पापस्वीकार के समय अपने पापों का हिसाब रखने के लिए इसका उपयोग करें।';

  @override
  String get tutorialPrayersDesc =>
      'पापस्वीकार से पहले और बाद की सामान्य प्रार्थनाएँ यहाँ पाएँ।';

  @override
  String get tutorialGuideDesc =>
      'यहाँ आपको प्रोत्साहन, पापस्वीकार की चरणबद्ध मार्गदर्शिका और सामान्य प्रश्न मिलेंगे।';

  @override
  String get tutorialSettingsDesc =>
      'यहाँ अपने अनुभव को अपने अनुसार बनाएँ: भाषा और थीम बदलें, स्मरण-सूचनाएँ तय करें और सुरक्षा सेटिंग्स सँभालें।';

  @override
  String get tutorialSwipeDesc =>
      'आज्ञाओं के बीच जाने के लिए बाएँ या दाएँ स्वाइप करें।';

  @override
  String get tutorialSelectDesc =>
      'अपने पापस्वीकार के लिए किसी भी प्रश्न को चुनने हेतु उस पर टैप करें।';

  @override
  String get tutorialFinishDesc =>
      'हो जाने पर, समाप्त कर पापस्वीकार पर जाने के लिए यहाँ टैप करें।';

  @override
  String get tutorialCounterDesc =>
      'यह दिखाता है कि आपने पापस्वीकार के लिए कितनी प्रविष्टियाँ चुनी हैं।';

  @override
  String get tutorialMenuDesc =>
      'यहाँ से अपने स्वयं के पाप जोड़ें और अपने चुनाव मिटाएँ।';

  @override
  String get tutorialPenanceDesc =>
      'पुरोहित द्वारा दिए गए प्रायश्चित्त यहाँ सँभालें।';

  @override
  String get tutorialInsightsDesc =>
      'अपनी पापस्वीकार-यात्रा के आँकड़े और निरंतरता देखें।';

  @override
  String get tutorialHistoryDesc =>
      'अपने पिछले पापस्वीकार और उनकी तिथियाँ यहाँ देखें।';

  @override
  String get replayTutorial => 'परिचय फिर देखें';

  @override
  String get replayTutorialDesc => 'ऐप का परिचय फिर से देखें';

  @override
  String get tutorialReset =>
      'परिचय फिर से सेट हुआ! आपको मार्गदर्शिकाएँ फिर दिखाई देंगी।';

  @override
  String get about => 'ऐप के बारे में';

  @override
  String get aboutSubtitle => 'संस्करण, लाइसेंस और स्रोत कोड';

  @override
  String get shareApp => 'ऐप साझा करें';

  @override
  String get shareAppSubtitle => 'मित्रों और परिवार के साथ साझा करें';

  @override
  String get rateApp => 'ऐप को रेटिंग दें';

  @override
  String get spreadShareTitle => 'Metanoia साझा करें';

  @override
  String get spreadShareSubtitle =>
      'क्या आप किसी ऐसे व्यक्ति को जानते हैं जो पापस्वीकार से दूर हो गया है? उन्हें लौटने में मदद करें।';

  @override
  String get spreadShareAction => 'साझा करें';

  @override
  String get spreadRateSubtitle =>
      'यदि Metanoia ने पापस्वीकार की तैयारी में आपकी मदद की है, तो एक रेटिंग दूसरों को इसे खोजने में मदद करती है।';

  @override
  String get spreadRateAction => 'रेटिंग दें';

  @override
  String get rateGateHint => 'आप अपने अनुभव को कैसे आँकेंगे?';

  @override
  String get rateGateLowest => 'सबसे कम';

  @override
  String get rateGateHighest => 'सबसे अधिक';

  @override
  String get rateGateThanks =>
      'धन्यवाद — आपकी प्रतिक्रिया हमारे लिए बहुत मायने रखती है।';

  @override
  String rateAppSubtitle(String store) {
    return '$store पर हमें रेटिंग दें';
  }

  @override
  String get website => 'वेबसाइट';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get madeWithLove => 'holystack.dev द्वारा ❤️ से बनाया गया';

  @override
  String get rateDialogTitle => 'क्या Metanoia आपके काम आ रहा है?';

  @override
  String get rateDialogContent =>
      'यदि यह ऐप आपके लिए सहायक है, तो कृपया कुछ क्षण निकालकर इसे रेटिंग दें। इससे हमें बहुत सहायता मिलती है!';

  @override
  String get rateDialogYes => 'अभी रेटिंग दें';

  @override
  String get rateDialogNo => 'नहीं, धन्यवाद';

  @override
  String get rateDialogLater => 'बाद में याद दिलाएँ';

  @override
  String get greekLabel => 'यूनानी';

  @override
  String get nounLabel => 'संज्ञा';

  @override
  String get metanoiaDefinition =>
      'मन और हृदय का गहरा परिवर्तन; एक आध्यात्मिक जागृति जो व्यक्ति के सम्पूर्ण अस्तित्व को बदल देती है और उसके जीवन को ईश्वर की ओर मोड़ देती है।';

  @override
  String get turnBackToGrace => 'कृपा की ओर लौटें';

  @override
  String get welcomeSubtitle => 'सार्थक पापस्वीकार के लिए आपकी मार्गदर्शिका';

  @override
  String get discoverInnerGrace => 'भीतर की कृपा को पहचानें';

  @override
  String get sacredJourneyBegins =>
      'मेल-मिलाप की एक पवित्र यात्रा आरम्भ होती है।';

  @override
  String get beginJourney => 'यात्रा आरम्भ करें';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get chooseContentLanguage => 'सामग्री की भाषा चुनें';

  @override
  String get contentLanguageDescription =>
      'प्रार्थनाओं, आत्मपरीक्षण और मार्गदर्शिकाओं के लिए भाषा चुनें';

  @override
  String get changeAnytimeNote => 'आप इसे कभी भी सेटिंग्स में बदल सकते हैं';

  @override
  String get continueButton => 'आगे बढ़ें';

  @override
  String get examineDescription =>
      'पापस्वीकार से पहले दस आज्ञाओं के आधार पर अपना आत्मपरीक्षण करें';

  @override
  String get confessDescription =>
      'पापस्वीकार के दौरान अपने पापों पर निशान लगाएँ ताकि कुछ भी छूट न जाए';

  @override
  String get prayersDescription =>
      'पापस्वीकार से पहले और बाद की प्रार्थनाएँ तथा प्रायश्चित्त की प्रार्थनाएँ पढ़ें';

  @override
  String get remindersDescription =>
      'सेटिंग्स में नियमित अनुस्मारक लगाएँ, ताकि आप पापस्वीकार के लिए जाना कभी न भूलें';

  @override
  String get nextButton => 'आगे';

  @override
  String get customSins => 'स्वयं जोड़े गए पाप';

  @override
  String get manageCustomSins => 'स्वयं जोड़े गए पाप प्रबंधित करें';

  @override
  String get addCustomSin => 'अपना पाप जोड़ें';

  @override
  String get editCustomSin => 'पाप संपादित करें';

  @override
  String get deleteCustomSin => 'पाप हटाएँ';

  @override
  String get sinDescription => 'पाप का विवरण';

  @override
  String get sinDescriptionHint =>
      'जिस पाप को आप याद रखना चाहते हैं, उसका विवरण लिखें';

  @override
  String get sinDescriptionRequired => 'कृपया पाप का विवरण भरें';

  @override
  String get optionalNote => 'वैकल्पिक टिप्पणी';

  @override
  String get optionalNoteHint => 'कोई अतिरिक्त विवरण जोड़ें';

  @override
  String get selectCommandment => 'आज्ञा चुनें (वैकल्पिक)';

  @override
  String get noCommandment => 'सामान्य / कोई आज्ञा नहीं';

  @override
  String get customSinAdded => 'पाप जोड़ा गया';

  @override
  String get customSinUpdated => 'पाप अद्यतन किया गया';

  @override
  String get customSinDeleted => 'पाप हटा दिया गया';

  @override
  String get deleteCustomSinConfirm =>
      'क्या आप वाकई इस पाप को हटाना चाहते हैं?';

  @override
  String get noCustomSins => 'अभी तक कोई पाप नहीं जोड़ा गया';

  @override
  String get noCustomSinsDesc =>
      'अपने आत्मपरीक्षण को व्यक्तिगत बनाने के लिए अपने पाप जोड़ें';

  @override
  String get customVersion => 'स्वयं का (संपादित)';

  @override
  String get searchCustomSins => 'अपने जोड़े गए पाप खोजें...';

  @override
  String get addButton => 'जोड़ें';

  @override
  String get updateButton => 'अद्यतन करें';

  @override
  String get deleteButton => 'हटाएँ';

  @override
  String get addYourOwn => 'अपना जोड़ें...';

  @override
  String get penance => 'प्रायश्चित्त';

  @override
  String get penanceTracker => 'प्रायश्चित्त सूची';

  @override
  String get addPenance => 'प्रायश्चित्त जोड़ें';

  @override
  String get editPenance => 'प्रायश्चित्त संपादित करें';

  @override
  String get penanceDescription => 'आपको कौन-सा प्रायश्चित्त दिया गया?';

  @override
  String get penanceHint => 'जैसे, 3 बार प्रणाम मरिया, कोई बाइबिल पाठ पढ़ना...';

  @override
  String get penanceAdded => 'प्रायश्चित्त जोड़ा गया';

  @override
  String get penanceUpdated => 'प्रायश्चित्त अद्यतन किया गया';

  @override
  String get penanceCompleted => 'प्रायश्चित्त पूरा हुआ! ईश्वर आपको आशीष दे।';

  @override
  String get markAsComplete => 'पूरा हुआ चिह्नित करें';

  @override
  String get pendingPenances => 'शेष प्रायश्चित्त';

  @override
  String get noPendingPenances => 'कोई शेष प्रायश्चित्त नहीं';

  @override
  String get noPendingPenancesDesc =>
      'आपके सभी प्रायश्चित्त पूरे हो चुके हैं। ईश्वर आशीष दे!';

  @override
  String completedOn(Object date) {
    return '$date को पूरा हुआ';
  }

  @override
  String assignedOn(Object date) {
    return '$date को दिया गया';
  }

  @override
  String get skipPenance => 'छोड़ें';

  @override
  String get savePenance => 'प्रायश्चित्त सहेजें';

  @override
  String get insights => 'अंतर्दृष्टि';

  @override
  String get confessionInsights => 'पापस्वीकार की अंतर्दृष्टि';

  @override
  String get totalConfessions => 'कुल पापस्वीकार';

  @override
  String get averageFrequency => 'औसत अंतराल';

  @override
  String everyXDays(Object count) {
    return 'हर $count दिन में';
  }

  @override
  String get daysSinceLastConfession => 'पिछले पापस्वीकार को हुए दिन';

  @override
  String get currentStreak => 'वर्तमान निरंतरता';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सप्ताह',
      one: '1 सप्ताह',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'मासिक गतिविधि';

  @override
  String get confessionsThisYear => 'इस वर्ष के पापस्वीकार';

  @override
  String get noInsightsYet => 'अभी कोई अंतर्दृष्टि नहीं';

  @override
  String get noInsightsYetDesc =>
      'अपनी आध्यात्मिक यात्रा के आँकड़े देखने के लिए अपना पहला पापस्वीकार पूरा करें';

  @override
  String get totalItemsConfessed => 'कुल स्वीकार किए गए पाप';

  @override
  String get firstConfession => 'पहला पापस्वीकार';

  @override
  String get spiritualJourney => 'आपकी आध्यात्मिक यात्रा';

  @override
  String get listView => 'सूची';

  @override
  String get guidedView => 'मार्गदर्शित';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$total में से $current';
  }

  @override
  String get previousCommandment => 'पिछला';

  @override
  String get nextCommandment => 'अगला';

  @override
  String get finishExamination => 'समाप्त करें';

  @override
  String get noQuestionsSelected => 'इस भाग में कोई प्रश्न चुना नहीं गया';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count चुने गए';
  }

  @override
  String get examinationSummary => 'आत्मपरीक्षण का सारांश';

  @override
  String get examinationNote =>
      'गहरा आत्मपरीक्षण किसी भी सूची से आगे जाता है। प्रार्थनापूर्वक अपने जीवन की स्थिति और परिस्थितियों पर मनन करें।';

  @override
  String selectedCount(Object count) {
    return '$count चुने गए';
  }

  @override
  String get noSinsSelected => 'कोई पाप नहीं चुना गया';

  @override
  String get continueEditing => 'सम्पादन जारी रखें';

  @override
  String get proceedToConfess => 'आगे बढ़ें';

  @override
  String get clearDraftTitle => 'प्रारूप हटाएँ?';

  @override
  String get clearDraftMessage =>
      'इससे सभी चुने गए प्रश्न हट जाएँगे। क्या आप निश्चित हैं?';

  @override
  String get clearDraft => 'प्रारूप हटाएँ';

  @override
  String get clear => 'हटाएँ';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'पिछले सत्र से $count बातें पुनः प्राप्त की गईं',
      one: 'पिछले सत्र से 1 बात पुनः प्राप्त की गई',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'अभी-अभी';

  @override
  String minutesAgo(Object count) {
    return '$count मिनट पहले';
  }

  @override
  String hoursAgo(Object count) {
    return '$count घंटे पहले';
  }

  @override
  String get general => 'सामान्य';

  @override
  String get noQuestionsInSection => 'इस भाग में कोई प्रश्न नहीं है';

  @override
  String get skip => 'छोड़ें';

  @override
  String get back => 'पीछे';

  @override
  String get skipOnboardingTitle => 'परिचय छोड़ें?';

  @override
  String get skipOnboardingMessage =>
      'आप सीधे अंतिम पृष्ठ पर पहुँच जाएँगे। यहाँ कुछ भी तय नहीं हो रहा — आप सब कुछ बाद में सेटिंग्स में बदल सकते हैं।';

  @override
  String get confessionHistoryTitle => 'पापस्वीकार का इतिहास';

  @override
  String get deleteAll => 'सब मिटाएँ';

  @override
  String get editDate => 'तिथि बदलें';

  @override
  String get confessionDate => 'पापस्वीकार की तिथि';

  @override
  String get dateUpdated => 'तिथि अद्यतन हो गई';

  @override
  String get changeDateConfirmTitle => 'तिथि बदलें?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'पापस्वीकार की तिथि बदलकर $date करें?';
  }

  @override
  String get noGuideContent => 'कोई मार्गदर्शिका उपलब्ध नहीं';

  @override
  String get noGuideContentDesc => 'मार्गदर्शिका की सामग्री यहाँ दिखाई देगी';

  @override
  String get noFaqContent => 'कोई प्रश्नोत्तर उपलब्ध नहीं';

  @override
  String get noFaqContentDesc => 'अक्सर पूछे जाने वाले प्रश्न यहाँ दिखाई देंगे';

  @override
  String get faqSubtitle => 'मेल-मिलाप संस्कार की मार्गदर्शिका';

  @override
  String get tapToExpand => 'और पढ़ने के लिए स्पर्श करें';

  @override
  String get continueExamination => 'आत्मपरीक्षण जारी रखें';

  @override
  String get continueExaminationDesc => 'आपका एक आत्मपरीक्षण अधूरा है';

  @override
  String examinationProgress(Object count) {
    return '$count चुने गए';
  }

  @override
  String get security => 'सुरक्षा';

  @override
  String get securitySubtitle => 'अपने निजी डेटा की रक्षा करें';

  @override
  String get pinAndBiometric => 'पिन और बायोमेट्रिक';

  @override
  String get pinAndBiometricSubtitle => 'ऐप लॉक की सेटिंग्स तय करें';

  @override
  String get enterPin => 'पिन दर्ज करें';

  @override
  String get createPin => 'पिन बनाएँ';

  @override
  String get confirmPin => 'पिन की पुष्टि करें';

  @override
  String get incorrectPin => 'गलत पिन';

  @override
  String get pinMismatch => 'पिन मेल नहीं खाते';

  @override
  String get biometricUnlock => 'बायोमेट्रिक अनलॉक';

  @override
  String get autoLockTimeout => 'स्वतः लॉक की अवधि';

  @override
  String get tooManyAttempts => 'बहुत बार गलत प्रयास हुए';

  @override
  String tryAgainIn(Object time) {
    return '$time बाद पुनः प्रयास करें';
  }

  @override
  String get useBiometricUnlock => 'बायोमेट्रिक अनलॉक का उपयोग करें';

  @override
  String get unlockWithFingerprintOrFace =>
      'फ़िंगरप्रिंट या चेहरे से अनलॉक करें';

  @override
  String get biometricAccessWarning =>
      'इस डिवाइस पर जिस किसी का भी फ़िंगरप्रिंट या चेहरा पंजीकृत है, वह ऐप खोल सकेगा';

  @override
  String get lockAfter => 'इतने समय बाद लॉक करें';

  @override
  String get timeInBackgroundBeforeLocking =>
      'लॉक होने से पहले पृष्ठभूमि में रहने का समय';

  @override
  String get changePin => 'पिन बदलें';

  @override
  String get updateYourSecurityPin => 'अपना सुरक्षा पिन बदलें';

  @override
  String get enterCurrentPin => 'वर्तमान पिन दर्ज करें';

  @override
  String get enterNewPin => 'नया पिन दर्ज करें';

  @override
  String get confirmNewPin => 'नए पिन की पुष्टि करें';

  @override
  String get pinChangedSuccessfully => 'पिन सफलतापूर्वक बदल गया';

  @override
  String get currentPinIncorrect => 'वर्तमान पिन गलत है';

  @override
  String get enableBiometricUnlock => 'बायोमेट्रिक अनलॉक चालू करें?';

  @override
  String get biometricDescription =>
      'ऐप को शीघ्र और सुरक्षित रूप से खोलने के लिए अपने फ़िंगरप्रिंट या चेहरे का उपयोग करें।';

  @override
  String get notNow => 'अभी नहीं';

  @override
  String get enable => 'चालू करें';

  @override
  String get setUpPin => 'पिन सेट करें';

  @override
  String get createSixDigitPin => '6 अंकों का पिन बनाएँ';

  @override
  String get pinProtectData =>
      'यह पिन आपके डेटा की सुरक्षा के लिए उपयोग किया जाएगा';

  @override
  String get confirmYourPin => 'अपने पिन की पुष्टि करें';

  @override
  String get enterSamePinAgain => 'पुष्टि के लिए वही पिन फिर से दर्ज करें';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'अनलॉक करने के लिए अपना पिन दर्ज करें';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रयास शेष',
      one: '1 प्रयास शेष',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सेकंड',
      one: '1 सेकंड',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count मिनट',
      one: '1 मिनट',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get confessionDeleted => 'पापस्वीकार मिटा दिया गया';

  @override
  String get noConfessionHistory => 'पापस्वीकार का कोई इतिहास नहीं';

  @override
  String get noConfessionHistoryDesc =>
      'पूर्ण किए गए पापस्वीकार यहाँ दिखाई देंगे';

  @override
  String get fontSize => 'अक्षरों का आकार';

  @override
  String get fontSizeSubtitle => 'बेहतर पठनीयता के लिए अक्षरों का आकार बदलें';

  @override
  String get fontSizeSmall => 'छोटा';

  @override
  String get fontSizeMedium => 'मध्यम';

  @override
  String get fontSizeLarge => 'बड़ा';

  @override
  String get fontSizeExtraLarge => 'बहुत बड़ा';

  @override
  String get forgotPin => 'पिन भूल गए?';

  @override
  String get resetPinTitle => 'पिन रीसेट करें';

  @override
  String get resetPinWarning =>
      'चेतावनी: इससे आपका सारा डेटा स्थायी रूप से मिट जाएगा';

  @override
  String get resetPinDescription =>
      'यदि आप अपना पिन रीसेट करते हैं, तो आपके सभी पापस्वीकार, स्वयं जोड़े गए पाप, प्रायश्चित्त और अन्य निजी डेटा स्थायी रूप से मिट जाएँगे। यह क्रिया वापस नहीं ली जा सकती।';

  @override
  String get resetPinConfirmation => 'पुष्टि के लिए DELETE टाइप करें';

  @override
  String get resetPinButton => 'पिन रीसेट करें और डेटा मिटाएँ';

  @override
  String get resetPinSuccess =>
      'पिन सफलतापूर्वक रीसेट हो गया। कृपया नया पिन बनाएँ।';

  @override
  String get resetPinError => 'पिन रीसेट नहीं हो सका। कृपया पुनः प्रयास करें।';

  @override
  String get deleteConfirmationText => 'DELETE';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'कृपया $seconds सेकंड प्रतीक्षा करें';
  }

  @override
  String get resetPinBiometricPrompt =>
      'पिन रीसेट करने के लिए अपनी पहचान सत्यापित करें';

  @override
  String get confessionGuideTitle => 'अच्छा पापस्वीकार कैसे करें';

  @override
  String get shortFilmTitle => 'पापस्वीकार: एक लघु फ़िल्म';

  @override
  String get shortFilmSubtitle =>
      'Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, यूनाइटेड किंगडम द्वारा निर्मित';

  @override
  String get confessionGuideSubtitle => 'संस्कार की चरणबद्ध मार्गदर्शिका';

  @override
  String get invitationTitle => 'बहुत समय बाद पापस्वीकार कर रहे हैं?';

  @override
  String get invitationSubtitle => 'आपके लिए प्रोत्साहन के कुछ शब्द';

  @override
  String get invitationDialogTitle => 'स्वागत है';

  @override
  String get invitationDialogContent =>
      'क्या यह लंबे समय बाद आपका पहला पापस्वीकार है, या जाने को लेकर आप घबराहट महसूस कर रहे हैं?';

  @override
  String get invitationDialogYes => 'हाँ, मुझे थोड़े प्रोत्साहन की ज़रूरत है';

  @override
  String get invitationDialogNo => 'नहीं, मैं आरम्भ करने के लिए तैयार हूँ';

  @override
  String get invitationDialogDontShowAgain => 'इसे फिर न दिखाएँ';

  @override
  String get searchPrayers => 'प्रार्थनाएँ खोजें...';

  @override
  String get allCategories => 'सभी';

  @override
  String get appDisclaimer =>
      'यह ऐप पापस्वीकार की तैयारी के लिए एक आध्यात्मिक सहायक है। यह पुरोहित के सामने किए जाने वाले मेल-मिलाप संस्कार का विकल्प नहीं है।';

  @override
  String get onboardingDisclaimer =>
      'पापस्वीकार में आपका आध्यात्मिक साथी—उसका विकल्प नहीं।';

  @override
  String get readyToBegin => 'आप तैयार हैं';

  @override
  String get readyToBeginSubtitle =>
      'मेल-मिलाप की ओर आपकी यात्रा कृपा और शांति से भरी रहे।';

  @override
  String get onboardingOverviewTitle => 'यह ऐप क्या करता है';

  @override
  String get onboardingOverviewExamine =>
      'अपने अंतःकरण को तैयार करें, अपनी गति से।';

  @override
  String get onboardingOverviewConfess =>
      'एक निजी सूची, ताकि कुछ भी छूट न जाए।';

  @override
  String get onboardingOverviewJournal =>
      'एक छोटा-सा सांध्य चिंतन, ताकि दो पापस्वीकारों के बीच भी आप बढ़ते रहें।';

  @override
  String get onboardingOverviewFootnote =>
      'प्रार्थनाएँ, मार्गदर्शिकाएँ और वैकल्पिक स्मरण भी भीतर मौजूद हैं।';

  @override
  String get onboardingPrivacyTitle => 'निजता, आरम्भ से ही';

  @override
  String get onboardingPrivacyLocal =>
      'सब कुछ इसी फ़ोन में रहता है। न कोई खाता, न कोई क्लाउड।';

  @override
  String get onboardingPrivacyEncrypted => 'आपके फ़ोन में एन्क्रिप्टेड।';

  @override
  String get onboardingPrivacyPin =>
      'जब आप पहली बार कोई आत्मपरीक्षण या अपनी डायरी खोलेंगे, तब आप एक पिन बनाएँगे।';

  @override
  String get sourceCode => 'स्रोत कोड';

  @override
  String get contentReferences => 'सामग्री के सन्दर्भ';

  @override
  String get examinationModeTitle => 'आप आत्मपरीक्षण कैसे करना चाहेंगे?';

  @override
  String get quickReviewMode => 'त्वरित समीक्षा';

  @override
  String get quickReviewDescription =>
      'श्रेणी के अनुसार सभी प्रश्नों पर दृष्टि डालें';

  @override
  String get deepReflectionMode => 'गहन चिंतन';

  @override
  String get deepReflectionDescription =>
      'सोच-समझकर परीक्षण के लिए एक बार में एक प्रश्न';

  @override
  String get contemplativePrayerTitle => 'आ, हे पवित्र आत्मा';

  @override
  String get contemplativePrayerText =>
      'मेरा हृदय भर दे और मुझमें अपने प्रेम की आग जला दे। मेरे मन को प्रकाशित कर, ताकि मैं अपने पापों को स्पष्ट देख सकूँ।';

  @override
  String get imReady => 'मैं तैयार हूँ';

  @override
  String get skipPrayer => 'छोड़ें';

  @override
  String get yesThisApplies => 'हाँ';

  @override
  String get noThisDoesnt => 'नहीं';

  @override
  String get skipQuestion => 'छोड़ें';

  @override
  String questionProgress(int current, int total) {
    return '$total में से $current';
  }

  @override
  String get examinationComplete => 'आत्मपरीक्षण पूरा हुआ';

  @override
  String get reviewYourSelections => 'अपने चयन देखें';

  @override
  String get examinationModeSettingTitle => 'आत्मपरीक्षण की विधि';

  @override
  String get examinationModeSettingSubtitle =>
      'चुनें कि आप अपना आत्मपरीक्षण किस तरह करना चाहेंगे';

  @override
  String get askEveryTime => 'हर बार पूछें';

  @override
  String get reminderNotificationTitle => 'पापस्वीकार का समय';

  @override
  String get reminderNotificationBody =>
      'अपने अंतःकरण का परीक्षण करना और पापस्वीकार की तैयारी करना न भूलें';

  @override
  String get notificationPermissionDenied =>
      'सूचनाएँ बंद हैं। पापस्वीकार के स्मरण पाने के लिए अपने डिवाइस की सेटिंग्स में Metanoia को सूचनाओं की अनुमति दें।';

  @override
  String get openSourceLicenses => 'ओपन सोर्स लाइसेंस';

  @override
  String get couldNotOpenLink => 'लिंक नहीं खुल सका';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बातें स्वीकार की गईं',
      one: '1 बात स्वीकार की गई',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रायश्चित्त',
      one: '1 प्रायश्चित्त',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count शेष',
      one: '1 शेष',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'कुल $count',
      one: 'कुल 1',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बातें',
      one: '1 बात',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '1 दिन',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सप्ता.',
      one: '1 सप्ता.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'सभी पापस्वीकार मिटाएँ?';

  @override
  String get deleteAllConfessionsContent =>
      'इससे आपका पूरा पापस्वीकार इतिहास स्थायी रूप से मिट जाएगा। यह क्रिया वापस नहीं ली जा सकती।';

  @override
  String get allConfessionsDeleted => 'सभी पापस्वीकार मिटा दिए गए';

  @override
  String get deletePenanceConfirm =>
      'क्या आप वाकई यह प्रायश्चित्त मिटाना चाहते हैं?';

  @override
  String get completed => 'पूरा हुआ';

  @override
  String get tapToCollapse => 'बंद करने के लिए टैप करें';

  @override
  String get dismiss => 'हटाएँ';

  @override
  String showcaseStep(int current, int total) {
    return 'चरण $current/$total';
  }

  @override
  String get done => 'हो गया';

  @override
  String get navigate => 'आगे जाएँ';

  @override
  String get encouragement => 'प्रोत्साहन';

  @override
  String get biometricPromptReason => 'Metanoia खोलने के लिए प्रमाणीकरण करें';

  @override
  String get tryAgainInLabel => 'पुनः प्रयास होगा';

  @override
  String get errorLoadingLanguage => 'भाषा लोड करने में त्रुटि';

  @override
  String get detailsNotSaved => 'विवरण सहेजा नहीं गया';

  @override
  String get discardStoredSinsTitle => 'सहेजे गए पाप हटाएँ?';

  @override
  String get discardStoredSinsContent =>
      'पापस्वीकार इतिहास अब बंद है। पिछले पापस्वीकारों से सहेजे गए पाप अब भी संग्रहित हैं। क्या उन्हें हटा दें? तिथियाँ बनी रहेंगी, इसलिए आपकी अंतर्दृष्टियाँ और निरंतरता सुरक्षित रहेंगी।';

  @override
  String get keepThem => 'रहने दें';

  @override
  String get discard => 'हटाएँ';

  @override
  String get storedSinsDiscarded =>
      'सहेजे गए पाप हटा दिए गए। पापस्वीकार की तिथियाँ बनी रहीं।';

  @override
  String get journalTitle => 'डायरी';

  @override
  String get journalHomeCardTitle => 'सांध्य चिंतन';

  @override
  String get journalHomeCardSubtitle => 'आज का दिन कैसा रहा?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '$count दिन',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'लगातार चिंतन के दिन';

  @override
  String get journalContinueToday => 'आज की प्रविष्टि जारी रखें';

  @override
  String get journalPreviousMonth => 'पिछला महीना';

  @override
  String get journalNextMonth => 'अगला महीना';

  @override
  String get journalGratitudeTitle => 'कृतज्ञता';

  @override
  String get journalGratitudePrompt => 'आज मैंने ईश्वर को कहाँ देखा?';

  @override
  String get journalGratitudeHint =>
      'एक कृपा, जिसके लिए मैं उसे धन्यवाद देना चाहूँ…';

  @override
  String get journalPresenceLead =>
      'ईश्वर यहाँ आपके साथ है। उसके सामने शांत होकर धन्यवाद दें।';

  @override
  String get journalPresenceVerse => 'शान्त हो और जान लो कि मैं ही ईश्वर हूँ।';

  @override
  String get journalPresenceRef => 'स्तोत्र 46:11';

  @override
  String get journalLightTitle => 'ज्योति माँगें';

  @override
  String get journalLightLead =>
      'पवित्र आत्मा से ज्योति माँगें, ताकि आप अपने दिन को वैसे देख सकें जैसे ईश्वर देखता है।';

  @override
  String get journalLightVerse =>
      'हे पवित्र आत्मा! आ कर अपने विश्वासियों का हृदय भर दे और उन में अपने प्रेम की आग सुलगा।';

  @override
  String get journalReviewTitle => 'ईश्वर के साथ पुनरावलोकन';

  @override
  String get journalReviewLead =>
      'प्रभु के साथ अपने दिन को फिर से देखें — कहाँ प्रेम आप तक आया, कहाँ आपने उसे दिया, और कहाँ आपने मुँह मोड़ लिया।';

  @override
  String get journalReviewVerse =>
      'ईश्वर! मुझे परख कर मेरे हृदय को पहचान ले; मुझे जाँच कर मेरी चिन्ताओं को जान ले। मेरी रखवाली कर, जिससे मैं कुमार्ग पर पैर न रखूँ; मुझे अनन्त जीवन के मार्ग पर ले चल।';

  @override
  String get journalReviewRef => 'स्तोत्र 139:23-24';

  @override
  String get journalReviewHint => 'अपने दिन के बारे में उससे बात करें…';

  @override
  String get journalReviewBringSin =>
      'क्या कुछ है जिसे आप उसके पास लाना चाहते हैं?';

  @override
  String get journalContritionTitle => 'पश्चात्ताप';

  @override
  String get journalContritionLead =>
      'जो आपने पाया है उसे पिता के पास ले जाएँ; वह आपसे मिलने दौड़ता है।';

  @override
  String get journalContritionVerse =>
      'ईश्वर! तू दयालु है, मुझ पर दया कर। तू दयासागर है, मेरा अपराध क्षमा कर।';

  @override
  String get journalContritionRef => 'स्तोत्र 51:3';

  @override
  String get journalContritionPray => 'मनस्ताप की प्रार्थना करें';

  @override
  String get journalContritionMercy =>
      'ईश्वर के प्रेम से जन्मा पश्चात्ताप, पापस्वीकार करने के संकल्प के साथ, आज रात आपके हृदय को उसकी करुणा के लिए खोल देता है; और उसकी परिपूर्णता पापस्वीकार-संस्कार में, पापमोचन के शब्दों में, आपकी प्रतीक्षा करती है।';

  @override
  String get journalResolutionLead =>
      'उसकी करुणा में विश्राम करें। कल उसी में फिर से आरम्भ होता है।';

  @override
  String get journalResolutionVerse =>
      'प्रभु की कृपा बनी हुई है, उसकी अनुकम्पा समाप्त नहीं हुई है — वह हर सबेरे नयी हो जाती है। उसकी सत्यप्रतिज्ञा अपूर्व है।';

  @override
  String get journalResolutionRef => 'शोक गीत 3:22-23';

  @override
  String get journalReflectionTitle => 'चिंतन';

  @override
  String get journalReflectionPrompt => 'आपका दिन कैसा रहा?';

  @override
  String get journalReflectionHint => 'मुक्त भाव से लिखें...';

  @override
  String get journalSinsTitle => 'पाप अंकित करें';

  @override
  String get journalSinsPrompt => 'आज मैं कहाँ चूक गया/गई?';

  @override
  String get journalNoSinsMarked => 'अभी कुछ अंकित नहीं है';

  @override
  String get journalAddSin => 'पाप अंकित करें';

  @override
  String get journalRemoveSin => 'हटाएँ';

  @override
  String get journalResolutionTitle => 'आशा और संकल्प';

  @override
  String get journalResolutionPrompt => 'कल के लिए एक वरदान';

  @override
  String get journalResolutionHint => 'तेरी कृपा से, कल मैं…';

  @override
  String get journalMoodTitle => 'मनःस्थिति';

  @override
  String get journalMoodPrompt => 'आज रात आपकी आत्मा कैसी है?';

  @override
  String get journalMoodDesolate => 'उदास';

  @override
  String get journalMoodStruggling => 'संघर्षरत';

  @override
  String get journalMoodSteady => 'स्थिर';

  @override
  String get journalMoodGrateful => 'कृतज्ञ';

  @override
  String get journalMoodConsoled => 'सांत्वना से भरी';

  @override
  String get journalSaved => 'सहेजा गया';

  @override
  String get journalSaving => 'सहेजा जा रहा है...';

  @override
  String get journalDeleteEntry => 'प्रविष्टि मिटाएँ';

  @override
  String get journalDeleteEntryConfirm =>
      'इस दिन की प्रविष्टि मिटा दें? इसे वापस नहीं लाया जा सकता।';

  @override
  String get journalEntryDeleted => 'प्रविष्टि मिटा दी गई';

  @override
  String get journalPickerQuestions => 'प्रश्न';

  @override
  String get journalPickerMySins => 'मेरे पाप';

  @override
  String get journalPickerOwnWords => 'अपने शब्दों में';

  @override
  String get journalPickerFreeTextHint => 'इसे अपने शब्दों में लिखें';

  @override
  String get journalSearchSins => 'पाप खोजें...';

  @override
  String get journalAbsolved => 'स्वीकार किया गया';

  @override
  String get journalSinCleared => 'एक पाप जिसे आप पापस्वीकार में लाए थे';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अपनी डायरी में अंकित किए हुए $count पाप शामिल करें',
      one: 'अपनी डायरी में अंकित किया हुआ पाप शामिल करें',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'शामिल करें';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपकी डायरी से $count पाप जोड़े गए',
      one: 'आपकी डायरी से 1 पाप जोड़ा गया',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'संघर्ष के क्षेत्र';

  @override
  String get journalStruggleAreasSubtitle =>
      'आपकी डायरी में सबसे अधिक बार अंकित';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count बार अंकित',
      one: '1 बार अंकित',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'डायरी अनुस्मारक';

  @override
  String get journalReminderSubtitle =>
      'दिन पर चिंतन करने के लिए रात्रि का एक कोमल अनुस्मारक';

  @override
  String get enableJournalReminder => 'डायरी अनुस्मारक चालू करें';

  @override
  String get journalReminderNotificationTitle => 'सांध्य चिंतन';

  @override
  String get journalReminderNotificationBody =>
      'कुछ क्षण निकालकर ईश्वर के साथ अपने दिन पर दृष्टि डालें';

  @override
  String get confessionDayMode => 'पापस्वीकार मोड';

  @override
  String get confessionDayModeDescription =>
      'पापस्वीकार-कक्ष के लिए बड़ा, बिना किसी व्यवधान वाला पाठ';

  @override
  String get exitConfessionMode => 'पापस्वीकार मोड से बाहर निकलें';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'चरण $current / $total';
  }

  @override
  String get next => 'आगे';

  @override
  String get actOfContrition => 'मनस्ताप की प्रार्थना';

  @override
  String get actOfContritionUnavailable =>
      'मनस्ताप की प्रार्थना उपलब्ध नहीं है';

  @override
  String get confessionDaySinsTitle => 'स्वीकार किए जाने वाले पाप';

  @override
  String get confessionDayOpeningTitle => 'आरंभ';

  @override
  String get confessionDayOpeningIntro =>
      'क्रूस का चिन्ह बनाएँ, फिर आरंभ करें:';

  @override
  String get confessionDayOpeningFormula =>
      'फ़ादर, मुझ पापी को आशीर्वाद दीजिए।';

  @override
  String confessionDaySinceLast(String duration) {
    return 'मुझे पापस्वीकार किए हुए $duration हो गए हैं।';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'मुझे पापस्वीकार किए हुए [दिन/सप्ताह/महीने/वर्ष] हो गए हैं।';

  @override
  String get confessionDaySinsClosing =>
      'इन सभी पापों के लिए और जो मुझसे भूल गए हों उनके लिए, मुझे सच्चे हृदय से पश्चात्ताप है। कृपया मुझे पापमोचन और प्रायश्चित्त प्रदान करें।';

  @override
  String get confessionDayThanksgivingTitle => 'शांति से जाइए';

  @override
  String get confessionDayThanksgivingVersicle =>
      'प्रभु को धन्यवाद दो, क्योंकि वह भला है।';

  @override
  String get confessionDayThanksgivingResponse => 'उसकी करुणा सदा बनी रहती है।';

  @override
  String get confessionDayThanksgivingBody =>
      'आपकी आत्मा शुद्ध हो चुकी है। अपना प्रायश्चित्त पूरा करें और मसीह की शांति में आगे बढ़ें।';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सप्ताह',
      one: '1 सप्ताह',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने',
      one: '1 महीना',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वर्ष',
      one: '1 वर्ष',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'चालीसा काल';

  @override
  String get seasonHolyWeek => 'पवित्र सप्ताह';

  @override
  String get seasonAdvent => 'आगमन काल';

  @override
  String get seasonChristmas => 'क्रिसमस';

  @override
  String get seasonEaster => 'पास्का';

  @override
  String get seasonOrdinaryTime => 'सामान्य काल';

  @override
  String get feastAshWednesday => 'राख बुधवार';

  @override
  String get feastPalmSunday => 'खजूर रविवार';

  @override
  String get feastEaster => 'पास्का';

  @override
  String get feastPentecost => 'पेंतेकोस्त';

  @override
  String get feastAssumption => 'माता मरियम का स्वर्गोद्ग्रहण';

  @override
  String get feastAllSaints => 'सभी संतों का पर्व';

  @override
  String get feastImmaculateConception => 'निष्कलंक गर्भागमन';

  @override
  String get feastFirstSundayOfAdvent => 'आगमन काल का प्रथम रविवार';

  @override
  String get feastChristmas => 'क्रिसमस';

  @override
  String get liturgicalLentTitle => 'चालीसा काल आरम्भ हो गया है';

  @override
  String get liturgicalLentBody =>
      'यह लौट आने का समय है। बहुत-से लोग इसका आरम्भ पापस्वीकार से करते हैं।';

  @override
  String get liturgicalHolyWeekTitle => 'पवित्र सप्ताह आरम्भ हो गया है';

  @override
  String get liturgicalHolyWeekBody =>
      'कलीसिया पास्का की ओर बढ़ रही है। अपना हृदय तैयार करने का समय अब भी है।';

  @override
  String get liturgicalAdventTitle => 'आगमन काल आरम्भ हो गया है';

  @override
  String get liturgicalAdventBody =>
      'यह प्रतीक्षा का समय है। बहुत-से लोग पापस्वीकार से अपना हृदय तैयार करते हैं।';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast निकट है';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन शेष — अपना हृदय तैयार करें।',
      one: 'एक दिन शेष — अपना हृदय तैयार करें।',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपके पिछले पापस्वीकार को $count सप्ताह हो गए हैं',
      one: 'आपके पिछले पापस्वीकार को एक सप्ताह हो गया है',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'जब भी आप तैयार हों, दया आपकी प्रतीक्षा कर रही है। क्या आप तैयारी करना चाहेंगे?';

  @override
  String get promptPrepare => 'तैयारी करें';

  @override
  String get dataUnrecoverableTitle => 'आपका डेटा खोला नहीं जा सकता';

  @override
  String get dataUnrecoverableBody =>
      'जो कुंजी आपके पापस्वीकारों की रक्षा करती है, वह अब इस डिवाइस पर उपलब्ध नहीं है। ऐसा बैकअप से पुनर्स्थापित करने के बाद, या डिवाइस की सुरक्षा सेटिंग्स रीसेट होने पर हो सकता है।\n\nचूँकि आपका डेटा एन्क्रिप्टेड है, उस कुंजी के बिना उसे वापस नहीं लाया जा सकता — हमारे द्वारा भी नहीं। आप इसे मिटाकर फिर से आरम्भ कर सकते हैं।';

  @override
  String get eraseAndStartOver => 'मिटाएँ और फिर से आरम्भ करें';

  @override
  String get eraseAndStartOverConfirm =>
      'इससे इस डिवाइस पर संग्रहीत सब कुछ स्थायी रूप से मिट जाएगा और ऐप नए सिरे से आरम्भ होगा। इसे वापस नहीं लाया जा सकता।';

  @override
  String get penanceSaveFailed =>
      'प्रायश्चित्त सहेजा नहीं जा सका। कृपया फिर से प्रयास करें।';

  @override
  String get confessionReminderChannelName => 'पापस्वीकार स्मरण-सूचनाएँ';

  @override
  String get confessionReminderChannelDescription => 'पापस्वीकार के लिए स्मरण';

  @override
  String get journalReminderChannelName => 'डायरी अनुस्मारक';

  @override
  String get journalReminderChannelDescription =>
      'सान्ध्य चिंतन लिखने के लिए दैनिक स्मरण';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अब तक $count बताए गए',
      one: 'अब तक एक बताया गया',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'आरम्भ करने से पहले';

  @override
  String get invitationCardAction => 'मुझे प्रोत्साहित करें';

  @override
  String get homeCtaBeginTitle => 'अपना आत्मपरीक्षण आरम्भ करें';

  @override
  String get homeCtaBeginSubtitle => 'पापस्वीकार से पहले अपना हृदय तैयार करें';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'अपना आत्मपरीक्षण जारी रखें ($count चुने गए)',
      one: 'अपना आत्मपरीक्षण जारी रखें (1 चुना गया)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'जहाँ छोड़ा था, वहीं से आगे बढ़ें';

  @override
  String get homeCtaReadyTitle => 'आप तैयार हैं';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आपकी पापस्वीकार सूची में $count पाप प्रतीक्षा कर रहे हैं',
      one: 'आपकी पापस्वीकार सूची में 1 पाप प्रतीक्षा कर रहा है',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'अपना प्रायश्चित्त पूरा करें';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count प्रायश्चित्त अब भी शेष हैं',
      one: '1 प्रायश्चित्त अब भी शेष है',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'प्रोत्साहन, चरणबद्ध मार्गदर्शिका, प्रार्थनाएँ और सामान्य प्रश्न';

  @override
  String get homeQuoteReadMore => 'और पढ़ें';

  @override
  String get homeQuoteShowLess => 'कम दिखाएँ';

  @override
  String get tutorialJournalDesc =>
      'हर शाम अपने दिन पर दृष्टि डालें: एक छोटा चिंतन, और आपकी निरंतरता।';
}
