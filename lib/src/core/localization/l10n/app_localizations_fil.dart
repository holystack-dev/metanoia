// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Tahanan';

  @override
  String get examineTitle => 'Suriin';

  @override
  String get confessTitle => 'Mangumpisal';

  @override
  String get prayersTitle => 'Mga Panalangin';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get examinationTitle => 'Pagsusuri';

  @override
  String get commandment => 'Utos';

  @override
  String get guideTitle => 'Gabay';

  @override
  String get faqTitle => 'Pag-unawa sa Kumpisal';

  @override
  String get language => 'Wika';

  @override
  String get chooseLanguage => 'Piliin ang wikang nais mo';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Piliin ang temang nais mo';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Maliwanag';

  @override
  String get dark => 'Madilim';

  @override
  String get reminders => 'Mga Paalala';

  @override
  String get getReminded => 'Tumanggap ng paalala upang mangumpisal';

  @override
  String get enableReminders => 'Buksan ang Mga Paalala';

  @override
  String get weekly => 'Lingguhan';

  @override
  String get biweekly => 'Tuwing dalawang linggo';

  @override
  String get monthly => 'Buwanan';

  @override
  String get quarterly => 'Tuwing tatlong buwan';

  @override
  String get day => 'Araw';

  @override
  String get time => 'Oras';

  @override
  String get remindMe => 'Paalalahanan ako';

  @override
  String get onTheDay => 'Sa mismong araw';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count araw bago',
      one: '1 araw bago',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Mabibilis na Gawain';

  @override
  String get lastConfession => 'Huling Kumpisal';

  @override
  String get noneYet => 'Wala pa';

  @override
  String get today => 'Ngayon';

  @override
  String get yesterday => 'Kahapon';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count araw na ang nakalipas',
      one: '1 araw na ang nakalipas',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Susunod na Paalala';

  @override
  String get off => 'Naka-off';

  @override
  String get mon => 'Lun';

  @override
  String get tue => 'Mar';

  @override
  String get wed => 'Miy';

  @override
  String get thu => 'Huw';

  @override
  String get fri => 'Biy';

  @override
  String get sat => 'Sab';

  @override
  String get sun => 'Lin';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miyerkules';

  @override
  String get thursday => 'Huwebes';

  @override
  String get friday => 'Biyernes';

  @override
  String get saturday => 'Sabado';

  @override
  String get sunday => 'Linggo';

  @override
  String get appLanguage => 'Wika ng App';

  @override
  String get appLanguageSubtitle => 'Wika para sa mga button, label, at menu';

  @override
  String get contentLanguage => 'Wika ng Nilalaman';

  @override
  String get contentLanguageSubtitle =>
      'Wika para sa mga tanong sa pagsusuri, FAQ, at panalangin';

  @override
  String get version => 'Bersyon';

  @override
  String get selectDay => 'Piliin ang Araw';

  @override
  String selected(num count) {
    return '$count ang napili';
  }

  @override
  String get selectedLabel => 'napili';

  @override
  String get counter => 'Bilang';

  @override
  String get searchPlaceholder => 'Maghanap ng mga utos o tanong...';

  @override
  String get noResults => 'Walang nahanap na resulta';

  @override
  String get viewHistory => 'Tingnan ang Kasaysayan';

  @override
  String get noActiveConfession => 'Walang kasalukuyang kumpisal';

  @override
  String get startExaminationPrompt =>
      'Magsimula ng pagsusuri upang magdagdag ng mga kasalanan dito.';

  @override
  String get startExamination => 'Simulan ang Pagsusuri';

  @override
  String get finishConfessionTitle => 'Tapusin ang Kumpisal?';

  @override
  String get finishConfessionContent =>
      'Mamarkahang tapos na ang kumpisal na ito at ililipat ito sa iyong kasaysayan.';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get finish => 'Tapusin';

  @override
  String get confessionCompletedMessage =>
      'Tapos na ang kumpisal! Pagpalain ka ng Diyos.';

  @override
  String get finishConfession => 'Tapusin ang Kumpisal';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Subukan Muli';

  @override
  String get dailyQuoteError => 'Hindi ma-load ang sipi para sa araw na ito.';

  @override
  String get keepHistory => 'Panatilihin ang Kasaysayan ng Kumpisal';

  @override
  String get keepHistorySubtitle =>
      'I-save ang iyong mga kasalanan kasama ang petsa. Kung naka-off, ang petsa lamang ang ise-save.';

  @override
  String get deleteConfession => 'Tanggalin ang Kumpisal';

  @override
  String get deleteConfessionContent =>
      'Permanenteng tatanggalin nito ang kumpisal na ito at lahat ng laman nito mula sa iyong kasaysayan. Hindi na ito maibabalik.';

  @override
  String get tutorialExamineDesc =>
      'Magsimula rito upang suriin ang iyong budhi bago mangumpisal.';

  @override
  String get tutorialConfessDesc =>
      'Gamitin ito habang nangungumpisal upang subaybayan ang iyong mga kasalanan.';

  @override
  String get tutorialPrayersDesc =>
      'Hanapin dito ang mga karaniwang panalangin bago at pagkatapos mangumpisal.';

  @override
  String get tutorialGuideDesc =>
      'Hanapin dito ang pampalakas-loob, ang hakbang-hakbang na gabay sa kumpisal, at ang mga FAQ.';

  @override
  String get tutorialSettingsDesc =>
      'Iayon dito ang app sa iyong pangangailangan: palitan ang wika at tema, magtakda ng mga paalala, at pamahalaan ang mga setting ng seguridad.';

  @override
  String get tutorialSwipeDesc =>
      'Mag-swipe pakaliwa o pakanan upang lumipat sa ibang utos.';

  @override
  String get tutorialSelectDesc =>
      'I-tap ang alinmang tanong upang piliin ito para sa iyong kumpisal.';

  @override
  String get tutorialFinishDesc =>
      'Kapag tapos ka na, i-tap ito upang tumuloy sa kumpisal.';

  @override
  String get tutorialCounterDesc =>
      'Ipinapakita nito kung ilan ang napili mo para sa kumpisal.';

  @override
  String get tutorialMenuDesc =>
      'Buksan dito ang sariling mga kasalanan at burahin ang iyong mga napili.';

  @override
  String get tutorialPenanceDesc =>
      'Subaybayan dito ang mga penitensiyang ibinigay ng iyong kumpesor.';

  @override
  String get tutorialInsightsDesc =>
      'Tingnan ang istatistika at mga sunod-sunod na araw sa iyong paglalakbay sa kumpisal.';

  @override
  String get tutorialHistoryDesc =>
      'Tingnan dito ang iyong mga nakaraang kumpisal at ang mga petsa ng mga ito.';

  @override
  String get replayTutorial => 'Ulitin ang Tutorial';

  @override
  String get replayTutorialDesc => 'Panoorin muli ang tutorial ng app';

  @override
  String get tutorialReset =>
      'Na-reset ang tutorial! Makikita mo muli ang mga gabay.';

  @override
  String get about => 'Tungkol Dito';

  @override
  String get aboutSubtitle => 'Bersyon, lisensya, at source code';

  @override
  String get shareApp => 'Ibahagi ang App';

  @override
  String get shareAppSubtitle => 'Ibahagi sa mga kaibigan at pamilya';

  @override
  String get rateApp => 'I-rate ang App';

  @override
  String get spreadShareTitle => 'Ibahagi ang Metanoia';

  @override
  String get spreadShareSubtitle =>
      'May kilala ka bang matagal nang hindi nangungumpisal? Tulungan silang makabalik.';

  @override
  String get spreadShareAction => 'Ibahagi';

  @override
  String get spreadRateSubtitle =>
      'Kung nakatulong ang Metanoia sa iyong paghahanda para sa kumpisal, nakakatulong ang rating para matagpuan ito ng iba.';

  @override
  String get spreadRateAction => 'I-rate';

  @override
  String get rateGateHint => 'Paano mo ire-rate ang iyong karanasan?';

  @override
  String get rateGateLowest => 'Pinakamababa';

  @override
  String get rateGateHighest => 'Pinakamataas';

  @override
  String get rateGateThanks =>
      'Salamat — malaking bagay sa amin ang iyong feedback.';

  @override
  String rateAppSubtitle(String store) {
    return 'I-rate kami sa $store';
  }

  @override
  String get website => 'Website';

  @override
  String get privacyPolicy => 'Patakaran sa Privacy';

  @override
  String get madeWithLove => 'Ginawa nang may ❤️ ng holystack.dev';

  @override
  String get rateDialogTitle => 'Nakakatulong ba sa iyo ang Metanoia?';

  @override
  String get rateDialogContent =>
      'Kung nakatutulong sa iyo ang app na ito, maglaan sana ng sandali upang i-rate ito. Malaki ang maitutulong nito sa amin!';

  @override
  String get rateDialogYes => 'I-rate Ngayon';

  @override
  String get rateDialogNo => 'Huwag na lang';

  @override
  String get rateDialogLater => 'Paalalahanan ako mamaya';

  @override
  String get greekLabel => 'Griyego';

  @override
  String get nounLabel => 'pangngalan';

  @override
  String get metanoiaDefinition =>
      'Isang malalim na pagbabago ng isip at puso; isang espirituwal na paggising na bumabago sa buong pagkatao at nagtutuon ng buhay tungo sa Diyos.';

  @override
  String get turnBackToGrace => 'Bumalik sa Grasya';

  @override
  String get welcomeSubtitle =>
      'Ang iyong gabay tungo sa isang makabuluhang kumpisal';

  @override
  String get discoverInnerGrace => 'Tuklasin ang Grasya sa Loob';

  @override
  String get sacredJourneyBegins =>
      'Nagsisimula ang isang sagradong paglalakbay tungo sa pakikipagkasundo.';

  @override
  String get beginJourney => 'Simulan ang Paglalakbay';

  @override
  String get getStarted => 'Magsimula';

  @override
  String get chooseContentLanguage => 'Piliin ang Wika ng Nilalaman';

  @override
  String get contentLanguageDescription =>
      'Piliin ang wika para sa mga panalangin, pagsusuri ng budhi, at mga gabay';

  @override
  String get changeAnytimeNote =>
      'Maaari mo itong palitan anumang oras sa Mga Setting';

  @override
  String get continueButton => 'Magpatuloy';

  @override
  String get examineDescription =>
      'Suriin ang iyong budhi gamit ang Sampung Utos bago mangumpisal';

  @override
  String get confessDescription =>
      'Subaybayan ang iyong mga kasalanan habang nangungumpisal upang walang malimutan';

  @override
  String get prayersDescription =>
      'Buksan ang mga panalangin bago at pagkatapos mangumpisal, at ang mga panalangin sa penitensiya';

  @override
  String get remindersDescription =>
      'Magtakda ng mga regular na paalala sa Mga Setting upang hindi mo malimutang mangumpisal';

  @override
  String get nextButton => 'Susunod';

  @override
  String get customSins => 'Sariling mga Kasalanan';

  @override
  String get manageCustomSins => 'Pamahalaan ang Sariling mga Kasalanan';

  @override
  String get addCustomSin => 'Magdagdag ng Sariling Kasalanan';

  @override
  String get editCustomSin => 'Baguhin ang Sariling Kasalanan';

  @override
  String get deleteCustomSin => 'Tanggalin ang Sariling Kasalanan';

  @override
  String get sinDescription => 'Paglalarawan ng Kasalanan';

  @override
  String get sinDescriptionHint => 'Ilarawan ang kasalanang nais mong maalala';

  @override
  String get sinDescriptionRequired => 'Maglagay ng paglalarawan ng kasalanan';

  @override
  String get optionalNote => 'Karagdagang Tala';

  @override
  String get optionalNoteHint => 'Magdagdag ng iba pang detalye';

  @override
  String get selectCommandment => 'Piliin ang Utos (Opsyonal)';

  @override
  String get noCommandment => 'Pangkalahatan / Walang Utos';

  @override
  String get customSinAdded => 'Naidagdag ang sariling kasalanan';

  @override
  String get customSinUpdated => 'Nabago ang sariling kasalanan';

  @override
  String get customSinDeleted => 'Natanggal ang sariling kasalanan';

  @override
  String get deleteCustomSinConfirm =>
      'Sigurado ka bang tatanggalin ang sariling kasalanang ito?';

  @override
  String get noCustomSins => 'Wala pang sariling kasalanan';

  @override
  String get noCustomSinsDesc =>
      'Magdagdag ng sariling mga kasalanan upang iayon sa iyo ang pagsusuri';

  @override
  String get customVersion => 'Sarili (Binago)';

  @override
  String get searchCustomSins => 'Maghanap sa sariling mga kasalanan...';

  @override
  String get addButton => 'Idagdag';

  @override
  String get updateButton => 'I-update';

  @override
  String get deleteButton => 'Tanggalin';

  @override
  String get addYourOwn => 'Magdagdag ng sarili mo...';

  @override
  String get penance => 'Penitensiya';

  @override
  String get penanceTracker => 'Talaan ng Penitensiya';

  @override
  String get addPenance => 'Magdagdag ng Penitensiya';

  @override
  String get editPenance => 'Baguhin ang Penitensiya';

  @override
  String get penanceDescription => 'Anong penitensiya ang ibinigay sa iyo?';

  @override
  String get penanceHint =>
      'hal., Magdasal ng 3 Aba Ginoong Maria, Bumasa ng bahagi ng Banal na Kasulatan...';

  @override
  String get penanceAdded => 'Naidagdag ang penitensiya';

  @override
  String get penanceUpdated => 'Nabago ang penitensiya';

  @override
  String get penanceCompleted =>
      'Natapos ang penitensiya! Pagpalain ka ng Diyos.';

  @override
  String get markAsComplete => 'Markahang Tapos Na';

  @override
  String get pendingPenances => 'Mga Nakabinbing Penitensiya';

  @override
  String get noPendingPenances => 'Walang nakabinbing penitensiya';

  @override
  String get noPendingPenancesDesc =>
      'Tapos na ang lahat ng iyong penitensiya. Pagpalain ka ng Diyos!';

  @override
  String completedOn(Object date) {
    return 'Natapos noong $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Ibinigay noong $date';
  }

  @override
  String get skipPenance => 'Laktawan';

  @override
  String get savePenance => 'I-save ang Penitensiya';

  @override
  String get insights => 'Insights';

  @override
  String get confessionInsights => 'Insights sa Kumpisal';

  @override
  String get totalConfessions => 'Kabuuang Kumpisal';

  @override
  String get averageFrequency => 'Karaniwang Dalas';

  @override
  String everyXDays(Object count) {
    return 'Tuwing $count araw';
  }

  @override
  String get daysSinceLastConfession => 'Araw Mula sa Huli';

  @override
  String get currentStreak => 'Kasalukuyang Streak';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linggo',
      one: '1 linggo',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Buwanang Aktibidad';

  @override
  String get confessionsThisYear => 'Mga Kumpisal Ngayong Taon';

  @override
  String get noInsightsYet => 'Wala pang insights';

  @override
  String get noInsightsYetDesc =>
      'Tapusin ang iyong unang kumpisal upang makita ang istatistika ng iyong espirituwal na paglalakbay';

  @override
  String get totalItemsConfessed => 'Kabuuang Naipagtapat';

  @override
  String get firstConfession => 'Unang Kumpisal';

  @override
  String get spiritualJourney => 'Ang Iyong Espirituwal na Paglalakbay';

  @override
  String get listView => 'Listahan';

  @override
  String get guidedView => 'May Gabay';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current sa $total';
  }

  @override
  String get previousCommandment => 'Nakaraan';

  @override
  String get nextCommandment => 'Susunod';

  @override
  String get finishExamination => 'Tapusin';

  @override
  String get noQuestionsSelected => 'Walang napiling tanong sa bahaging ito';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count ang napili';
  }

  @override
  String get examinationSummary => 'Buod ng Pagsusuri';

  @override
  String get examinationNote =>
      'Ang masusing pagsusuri ng budhi ay hindi natatapos sa anumang listahan. Magnilay nang may panalangin sa iyong kalagayan sa buhay at mga pangyayari.';

  @override
  String selectedCount(Object count) {
    return '$count bagay ang napili';
  }

  @override
  String get noSinsSelected => 'Walang napiling kasalanan';

  @override
  String get continueEditing => 'Ipagpatuloy ang Pagbabago';

  @override
  String get proceedToConfess => 'Magpatuloy';

  @override
  String get clearDraftTitle => 'Burahin ang Draft?';

  @override
  String get clearDraftMessage =>
      'Aalisin nito ang lahat ng napiling tanong. Sigurado ka ba?';

  @override
  String get clearDraft => 'Burahin ang Draft';

  @override
  String get clear => 'Burahin';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Naibalik ang $count bagay mula sa iyong huling sesyon',
      one: 'Naibalik ang 1 bagay mula sa iyong huling sesyon',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Ngayon lang';

  @override
  String minutesAgo(Object count) {
    return '${count}m ang nakalipas';
  }

  @override
  String hoursAgo(Object count) {
    return '${count}h ang nakalipas';
  }

  @override
  String get general => 'Pangkalahatan';

  @override
  String get noQuestionsInSection => 'Walang tanong sa bahaging ito';

  @override
  String get skip => 'Laktawan';

  @override
  String get back => 'Bumalik';

  @override
  String get skipOnboardingTitle => 'Laktawan ang Panimula?';

  @override
  String get skipOnboardingMessage =>
      'Dadalhin ka nito nang diretso sa huling pahina. Walang itinatakda rito — maaari mong baguhin ang lahat mamaya sa Mga Setting.';

  @override
  String get confessionHistoryTitle => 'Kasaysayan ng Kumpisal';

  @override
  String get deleteAll => 'Tanggalin Lahat';

  @override
  String get editDate => 'Baguhin ang Petsa';

  @override
  String get confessionDate => 'Petsa ng Kumpisal';

  @override
  String get dateUpdated => 'Na-update ang petsa';

  @override
  String get changeDateConfirmTitle => 'Palitan ang Petsa?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Palitan ang petsa ng kumpisal sa $date?';
  }

  @override
  String get noGuideContent => 'Walang available na nilalaman ng gabay';

  @override
  String get noGuideContentDesc => 'Lilitaw dito ang nilalaman ng gabay';

  @override
  String get noFaqContent => 'Walang available na FAQ';

  @override
  String get noFaqContentDesc => 'Lilitaw dito ang mga madalas itanong';

  @override
  String get faqSubtitle => 'Isang gabay sa Sakramento ng Pakikipagkasundo';

  @override
  String get tapToExpand => 'I-tap upang magbasa pa';

  @override
  String get continueExamination => 'Ipagpatuloy ang Pagsusuri';

  @override
  String get continueExaminationDesc => 'May kasalukuyang pagsusuri ka';

  @override
  String examinationProgress(Object count) {
    return '$count bagay ang napili';
  }

  @override
  String get security => 'Seguridad';

  @override
  String get securitySubtitle => 'Protektahan ang iyong personal na datos';

  @override
  String get pinAndBiometric => 'PIN at Biometric';

  @override
  String get pinAndBiometricSubtitle => 'Ayusin ang mga setting ng app lock';

  @override
  String get enterPin => 'Ilagay ang PIN';

  @override
  String get createPin => 'Gumawa ng PIN';

  @override
  String get confirmPin => 'Kumpirmahin ang PIN';

  @override
  String get incorrectPin => 'Maling PIN';

  @override
  String get pinMismatch => 'Hindi magkatugma ang mga PIN';

  @override
  String get biometricUnlock => 'Biometric na Pag-unlock';

  @override
  String get autoLockTimeout => 'Awtomatikong Pag-lock';

  @override
  String get tooManyAttempts => 'Napakaraming maling pagsubok';

  @override
  String tryAgainIn(Object time) {
    return 'Subukan muli sa loob ng $time';
  }

  @override
  String get useBiometricUnlock => 'Gamitin ang Biometric na Pag-unlock';

  @override
  String get unlockWithFingerprintOrFace =>
      'I-unlock gamit ang fingerprint o mukha';

  @override
  String get biometricAccessWarning =>
      'Sinumang may nakarehistrong fingerprint o mukha sa device na ito ay makakabukas ng app';

  @override
  String get lockAfter => 'I-lock Pagkatapos ng';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Tagal sa background bago mag-lock';

  @override
  String get changePin => 'Palitan ang PIN';

  @override
  String get updateYourSecurityPin => 'I-update ang iyong PIN pangseguridad';

  @override
  String get enterCurrentPin => 'Ilagay ang Kasalukuyang PIN';

  @override
  String get enterNewPin => 'Ilagay ang Bagong PIN';

  @override
  String get confirmNewPin => 'Kumpirmahin ang Bagong PIN';

  @override
  String get pinChangedSuccessfully => 'Matagumpay na napalitan ang PIN';

  @override
  String get currentPinIncorrect => 'Mali ang kasalukuyang PIN';

  @override
  String get enableBiometricUnlock => 'Paganahin ang Biometric na Pag-unlock?';

  @override
  String get biometricDescription =>
      'Gamitin ang iyong fingerprint o mukha upang mabilis at ligtas na i-unlock ang app.';

  @override
  String get notNow => 'Huwag Muna';

  @override
  String get enable => 'Paganahin';

  @override
  String get setUpPin => 'Mag-set Up ng PIN';

  @override
  String get createSixDigitPin => 'Gumawa ng 6-digit na PIN';

  @override
  String get pinProtectData =>
      'Gagamitin ang PIN na ito upang protektahan ang iyong datos';

  @override
  String get confirmYourPin => 'Kumpirmahin ang iyong PIN';

  @override
  String get enterSamePinAgain =>
      'Ilagay muli ang parehong PIN upang kumpirmahin';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Ilagay ang iyong PIN upang i-unlock';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagsubok ang natitira',
      one: '1 pagsubok ang natitira',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundo',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuto',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Ibalik';

  @override
  String get confessionDeleted => 'Natanggal ang kumpisal';

  @override
  String get noConfessionHistory => 'Walang kasaysayan ng kumpisal';

  @override
  String get noConfessionHistoryDesc =>
      'Lilitaw dito ang mga natapos na kumpisal';

  @override
  String get fontSize => 'Laki ng Font';

  @override
  String get fontSizeSubtitle =>
      'Iakma ang laki ng teksto para sa mas madaling pagbasa';

  @override
  String get fontSizeSmall => 'Maliit';

  @override
  String get fontSizeMedium => 'Katamtaman';

  @override
  String get fontSizeLarge => 'Malaki';

  @override
  String get fontSizeExtraLarge => 'Napakalaki';

  @override
  String get forgotPin => 'Nakalimutan ang PIN?';

  @override
  String get resetPinTitle => 'I-reset ang PIN';

  @override
  String get resetPinWarning =>
      'Babala: Permanenteng buburahin nito ang lahat ng iyong datos';

  @override
  String get resetPinDescription =>
      'Kung ire-reset mo ang iyong PIN, permanenteng buburahin ang lahat ng iyong kumpisal, sariling mga kasalanan, penitensiya, at iba pang personal na datos. Hindi na ito maibabalik.';

  @override
  String get resetPinConfirmation => 'I-type ang DELETE upang kumpirmahin';

  @override
  String get resetPinButton => 'I-reset ang PIN at Burahin ang Datos';

  @override
  String get resetPinSuccess =>
      'Matagumpay na na-reset ang PIN. Mangyaring gumawa ng bagong PIN.';

  @override
  String get resetPinError => 'Nabigong i-reset ang PIN. Pakisubukan muli.';

  @override
  String get deleteConfirmationText => 'DELETE';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Maghintay ng $seconds segundo';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Patunayan ang iyong pagkakakilanlan upang i-reset ang PIN';

  @override
  String get confessionGuideTitle => 'Paano Magkumpisal nang Mabuti';

  @override
  String get shortFilmTitle => 'Kumpisal: Isang Maikling Pelikula';

  @override
  String get shortFilmSubtitle =>
      'Likha ng Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, United Kingdom';

  @override
  String get confessionGuideSubtitle =>
      'Gabay na hakbang-hakbang sa Sakramento';

  @override
  String get invitationTitle => 'Babalik sa Kumpisal?';

  @override
  String get invitationSubtitle =>
      'Isang salita ng pampalakas-loob para sa iyo';

  @override
  String get invitationDialogTitle => 'Maligayang Pagdating';

  @override
  String get invitationDialogContent =>
      'Ito ba ang una mong kumpisal matapos ang mahabang panahon, o kinakabahan kang mangumpisal?';

  @override
  String get invitationDialogYes => 'Oo, nais ko ng pampalakas-loob';

  @override
  String get invitationDialogNo => 'Hindi, handa na akong magsimula';

  @override
  String get invitationDialogDontShowAgain => 'Huwag nang ipakita ito muli';

  @override
  String get searchPrayers => 'Maghanap ng mga panalangin...';

  @override
  String get allCategories => 'Lahat';

  @override
  String get appDisclaimer =>
      'Ang app na ito ay isang espirituwal na tulong sa paghahanda sa kumpisal. Hindi ito kapalit ng Sakramento ng Pakikipagkasundo kasama ang isang pari.';

  @override
  String get onboardingDisclaimer =>
      'Isang espirituwal na kasama sa kumpisal—hindi kapalit nito.';

  @override
  String get readyToBegin => 'Handa Ka Na';

  @override
  String get readyToBeginSubtitle =>
      'Nawa\'y mapuspos ng grasya at kapayapaan ang iyong paglalakbay tungo sa pakikipagkasundo.';

  @override
  String get onboardingOverviewTitle => 'Ang ginagawa ng app na ito';

  @override
  String get onboardingOverviewExamine =>
      'Ihanda ang iyong budhi, sa sarili mong bilis.';

  @override
  String get onboardingOverviewConfess =>
      'Isang pribadong listahan, upang walang malimutan.';

  @override
  String get onboardingOverviewJournal =>
      'Isang maikling pagninilay sa gabi, upang patuloy kang lumago sa pagitan ng mga kumpisal.';

  @override
  String get onboardingOverviewFootnote =>
      'Nasa loob ang mga panalangin, gabay, at opsyonal na paalala.';

  @override
  String get onboardingPrivacyTitle => 'Pribado sa disenyo';

  @override
  String get onboardingPrivacyLocal =>
      'Nananatili ang lahat sa teleponong ito. Walang account, walang cloud.';

  @override
  String get onboardingPrivacyEncrypted => 'Naka-encrypt sa iyong device.';

  @override
  String get onboardingPrivacyPin =>
      'Gagawa ka ng PIN sa unang pagbukas mo ng isang pagsusuri o ng iyong talaarawan.';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get contentReferences => 'Mga Sanggunian ng Nilalaman';

  @override
  String get examinationModeTitle => 'Paano mo nais magsuri?';

  @override
  String get quickReviewMode => 'Mabilisang Repaso';

  @override
  String get quickReviewDescription =>
      'Sipatin ang lahat ng tanong ayon sa kategorya';

  @override
  String get deepReflectionMode => 'Malalim na Pagninilay';

  @override
  String get deepReflectionDescription =>
      'Isang tanong sa bawat pagkakataon para sa maingat na pagsusuri';

  @override
  String get contemplativePrayerTitle => 'Halina, Espiritu Santo';

  @override
  String get contemplativePrayerText =>
      'Punuin Mo ang aking puso at pag-alabin Mo sa akin ang apoy ng Iyong pag-ibig. Liwanagan Mo ang aking isip upang makita kong malinaw ang aking mga kasalanan.';

  @override
  String get imReady => 'Handa Na Ako';

  @override
  String get skipPrayer => 'Laktawan';

  @override
  String get yesThisApplies => 'Oo';

  @override
  String get noThisDoesnt => 'Hindi';

  @override
  String get skipQuestion => 'Laktawan';

  @override
  String questionProgress(int current, int total) {
    return '$current sa $total';
  }

  @override
  String get examinationComplete => 'Tapos na ang Pagsusuri';

  @override
  String get reviewYourSelections => 'Suriin ang iyong mga napili';

  @override
  String get examinationModeSettingTitle => 'Paraan ng Pagsusuri';

  @override
  String get examinationModeSettingSubtitle =>
      'Piliin kung paano mo nais suriin ang iyong budhi';

  @override
  String get askEveryTime => 'Itanong sa Bawat Pagkakataon';

  @override
  String get reminderNotificationTitle => 'Oras na Para Mangumpisal';

  @override
  String get reminderNotificationBody =>
      'Tandaang suriin ang iyong budhi at maghandang mangumpisal';

  @override
  String get notificationPermissionDenied =>
      'Naka-off ang mga notipikasyon. Payagan ang mga notipikasyon para sa Metanoia sa mga setting ng iyong device upang makatanggap ng mga paalala sa kumpisal.';

  @override
  String get openSourceLicenses => 'Mga Open Source na Lisensya';

  @override
  String get couldNotOpenLink => 'Hindi mabuksan ang link';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bagay na naipagtapat',
      one: '1 bagay na naipagtapat',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitensiya',
      one: '1 penitensiya',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nakabinbin',
      one: '1 nakabinbin',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sa kabuuan',
      one: '1 sa kabuuan',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bagay',
      one: '1 bagay',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count araw',
      one: '1 araw',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linggo',
      one: '1 linggo',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Tanggalin ang Lahat ng Kumpisal?';

  @override
  String get deleteAllConfessionsContent =>
      'Permanenteng tatanggalin nito ang buong kasaysayan ng iyong mga kumpisal. Hindi na ito maibabalik.';

  @override
  String get allConfessionsDeleted => 'Natanggal ang lahat ng kumpisal';

  @override
  String get deletePenanceConfirm =>
      'Sigurado ka bang tatanggalin ang penitensiyang ito?';

  @override
  String get completed => 'Tapos Na';

  @override
  String get tapToCollapse => 'I-tap upang isara';

  @override
  String get dismiss => 'Alisin';

  @override
  String showcaseStep(int current, int total) {
    return 'Hakbang $current sa $total';
  }

  @override
  String get done => 'Tapos';

  @override
  String get navigate => 'Buksan';

  @override
  String get encouragement => 'Pampalakas-loob';

  @override
  String get biometricPromptReason =>
      'Patunayan ang iyong pagkakakilanlan upang buksan ang Metanoia';

  @override
  String get tryAgainInLabel => 'Subukang muli sa loob ng';

  @override
  String get errorLoadingLanguage => 'Hindi ma-load ang wika';

  @override
  String get detailsNotSaved => 'Hindi nai-save ang mga detalye';

  @override
  String get discardStoredSinsTitle => 'Itapon ang mga naka-save na kasalanan?';

  @override
  String get discardStoredSinsContent =>
      'Naka-off na ngayon ang kasaysayan ng kumpisal. Nakaimbak pa rin ang mga kasalanang nai-save mula sa mga nakaraang kumpisal. Itapon ang mga ito? Mananatili ang mga petsa, kaya buo pa rin ang iyong mga insights at sunod-sunod na talaan.';

  @override
  String get keepThem => 'Panatilihin';

  @override
  String get discard => 'Itapon';

  @override
  String get storedSinsDiscarded =>
      'Naitapon ang mga naka-save na kasalanan. Nanatili ang mga petsa ng kumpisal.';

  @override
  String get journalTitle => 'Talaarawan';

  @override
  String get journalHomeCardTitle => 'Pagninilay sa gabi';

  @override
  String get journalHomeCardSubtitle => 'Kumusta ang araw mo ngayon?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count araw',
      one: '$count araw',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Sunod-sunod na araw ng pagninilay';

  @override
  String get journalContinueToday => 'Ipagpatuloy ang tala ngayong araw';

  @override
  String get journalPreviousMonth => 'Nakaraang buwan';

  @override
  String get journalNextMonth => 'Susunod na buwan';

  @override
  String get journalGratitudeTitle => 'Pasasalamat';

  @override
  String get journalGratitudePrompt => 'Saan ko nakita ang Diyos ngayong araw?';

  @override
  String get journalGratitudeHint =>
      'Isang grasyang nais kong ipagpasalamat sa Kanya…';

  @override
  String get journalPresenceLead =>
      'Narito ang Diyos na kasama mo. Tumahimik ka sa harap Niya, at magpasalamat.';

  @override
  String get journalPresenceVerse =>
      'Ihinto ang labanan, ako ang Diyos, dapat ninyong malaman.';

  @override
  String get journalPresenceRef => 'Awit 46:10';

  @override
  String get journalLightTitle => 'Humingi ng Liwanag';

  @override
  String get journalLightLead =>
      'Hilingin sa Espiritu Santo ang liwanag upang makita ang iyong araw gaya ng pagkakita ng Diyos.';

  @override
  String get journalLightVerse =>
      'Halina, Espiritu Santo, punuin mo ang mga puso ng iyong binyagan, at papagningasin sa kanila ang apoy ng iyong mabathalang pag-ibig.';

  @override
  String get journalReviewTitle => 'Balikan Kasama ang Diyos';

  @override
  String get journalReviewLead =>
      'Balikan ang iyong araw kasama ang Panginoon: kung saan dumating sa iyo ang pag-ibig, kung saan mo ito ibinigay, at kung saan ka tumalikod.';

  @override
  String get journalReviewVerse =>
      'O Diyos, ako\'y siyasatin, alamin ang aking isip, subukin mo ako ngayon, kung ano ang aking nais; kung ako ay hindi tapat, ito\'y iyong nababatid, sa buhay na walang hanggan, samahan mo at ihatid.';

  @override
  String get journalReviewRef => 'Awit 139:23-24';

  @override
  String get journalReviewHint => 'Kausapin Siya tungkol sa iyong araw…';

  @override
  String get journalReviewBringSin => 'May nais ka bang dalhin sa Kanya?';

  @override
  String get journalContritionTitle => 'Pagsisisi';

  @override
  String get journalContritionLead =>
      'Dalhin sa Ama ang iyong natagpuan; patakbo Siyang sasalubong sa iyo.';

  @override
  String get journalContritionVerse =>
      'Ako\'y kaawaan, O mahal kong Diyos, sang-ayon sa iyong kagandahang-loob; mga kasalanan ko\'y iyong pawiin, ayon din sa iyong pag-ibig sa akin!';

  @override
  String get journalContritionRef => 'Awit 51:1';

  @override
  String get journalContritionPray => 'Dasalin ang Panalangin ng Pagsisisi';

  @override
  String get journalContritionMercy =>
      'Ang pagsisisi na isinilang ng pag-ibig sa Diyos, kasama ang pasiyang magkumpisal, ang nagbubukas ng iyong puso sa Kanyang awa ngayong gabi; at ang kaganapan nito\'y naghihintay sa iyo sa Kumpisal, sa mga salita ng absolusyon.';

  @override
  String get journalResolutionLead =>
      'Magpahinga sa Kanyang awa. Sa Kanya muling magsisimula ang bukas.';

  @override
  String get journalResolutionVerse =>
      'Pag-ibig mo, Panginoon, ay hindi nagmamaliw; kahabagan mo\'y walang kapantay. Ito ay laging sariwa bawat umaga; katapatan mo\'y napakadakila.';

  @override
  String get journalResolutionRef => 'Panaghoy 3:22-23';

  @override
  String get journalReflectionTitle => 'Pagninilay';

  @override
  String get journalReflectionPrompt => 'Kumusta ang iyong araw?';

  @override
  String get journalReflectionHint => 'Malayang magsulat...';

  @override
  String get journalSinsTitle => 'Markahan ang mga kasalanan';

  @override
  String get journalSinsPrompt => 'Saan ako nagkulang ngayong araw?';

  @override
  String get journalNoSinsMarked => 'Wala pang namarkahan';

  @override
  String get journalAddSin => 'Markahan ang isang kasalanan';

  @override
  String get journalRemoveSin => 'Alisin';

  @override
  String get journalResolutionTitle => 'Pag-asa at Pagtitika';

  @override
  String get journalResolutionPrompt => 'Isang handog para bukas';

  @override
  String get journalResolutionHint => 'Sa tulong ng Iyong grasya, bukas ay…';

  @override
  String get journalMoodTitle => 'Kalooban';

  @override
  String get journalMoodPrompt => 'Kumusta ang iyong kaluluwa ngayong gabi?';

  @override
  String get journalMoodDesolate => 'Nanlulumo';

  @override
  String get journalMoodStruggling => 'Nahihirapan';

  @override
  String get journalMoodSteady => 'Panatag';

  @override
  String get journalMoodGrateful => 'Nagpapasalamat';

  @override
  String get journalMoodConsoled => 'Inaaliw';

  @override
  String get journalSaved => 'Nai-save';

  @override
  String get journalSaving => 'Sine-save...';

  @override
  String get journalDeleteEntry => 'Tanggalin ang tala';

  @override
  String get journalDeleteEntryConfirm =>
      'Tanggalin ang tala para sa araw na ito? Hindi na ito maibabalik.';

  @override
  String get journalEntryDeleted => 'Natanggal ang tala';

  @override
  String get journalPickerQuestions => 'Mga tanong';

  @override
  String get journalPickerMySins => 'Aking mga kasalanan';

  @override
  String get journalPickerOwnWords => 'Sa sarili kong salita';

  @override
  String get journalPickerFreeTextHint => 'Ilarawan ito sa sarili mong salita';

  @override
  String get journalSearchSins => 'Maghanap ng mga kasalanan...';

  @override
  String get journalAbsolved => 'Naipagtapat';

  @override
  String get journalSinCleared => 'Isang kasalanang dinala mo sa kumpisal';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Isama ang $count kasalanang minarkahan mo sa iyong talaarawan',
      one: 'Isama ang kasalanang minarkahan mo sa iyong talaarawan',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Isama';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kasalanan ang naidagdag mula sa iyong talaarawan',
      one: '1 kasalanan ang naidagdag mula sa iyong talaarawan',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Mga pinagpupunyagian';

  @override
  String get journalStruggleAreasSubtitle =>
      'Pinakamadalas markahan sa iyong talaarawan';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marka',
      one: '1 marka',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Paalala sa talaarawan';

  @override
  String get journalReminderSubtitle =>
      'Isang banayad na paalala sa gabi upang pagnilayan ang iyong araw';

  @override
  String get enableJournalReminder => 'Paganahin ang paalala sa talaarawan';

  @override
  String get journalReminderNotificationTitle => 'Pagninilay sa gabi';

  @override
  String get journalReminderNotificationBody =>
      'Maglaan ng sandali upang balikan ang iyong araw kasama ang Diyos';

  @override
  String get confessionDayMode => 'Modo ng Kumpisal';

  @override
  String get confessionDayModeDescription =>
      'Malaki at walang abalang teksto para sa kumpisalan';

  @override
  String get exitConfessionMode => 'Lumabas sa modo ng kumpisal';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Hakbang $current sa $total';
  }

  @override
  String get next => 'Susunod';

  @override
  String get actOfContrition => 'Panalangin ng Pagsisisi';

  @override
  String get actOfContritionUnavailable =>
      'Hindi magamit ang Panalangin ng Pagsisisi';

  @override
  String get confessionDaySinsTitle => 'Mga kasalanang ipagtatapat';

  @override
  String get confessionDayOpeningTitle => 'Pambungad';

  @override
  String get confessionDayOpeningIntro =>
      'Mag-antanda ka ng Krus, pagkatapos ay magsimula:';

  @override
  String get confessionDayOpeningFormula =>
      'Basbasan po ninyo ako, Padre, sapagkat ako po ay nagkasala.';

  @override
  String confessionDaySinceLast(String duration) {
    return '$duration na po mula sa aking huling kumpisal.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      '[Mga araw/linggo/buwan/taon] na po mula sa aking huling kumpisal.';

  @override
  String get confessionDaySinsClosing =>
      'Sa mga ito po at sa lahat ng aking mga kasalanan, ako po ay taos-pusong nagsisisi.';

  @override
  String get confessionDayThanksgivingTitle => 'Humayo ka sa kapayapaan';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Magpasalamat kayo sa Panginoon, sapagkat siya\'y butihin.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Ang kanyang awa ay walang hanggan.';

  @override
  String get confessionDayThanksgivingBody =>
      'Nalinis na ang iyong kaluluwa. Tuparin ang iyong penitensiya at humayo sa kapayapaan ni Kristo.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linggo',
      one: '1 linggo',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count buwan',
      one: '1 buwan',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count taon',
      one: '1 taon',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Kuwaresma';

  @override
  String get seasonHolyWeek => 'Mahal na Araw';

  @override
  String get seasonAdvent => 'Adbiyento';

  @override
  String get seasonChristmas => 'Pasko';

  @override
  String get seasonEaster => 'Pasko ng Pagkabuhay';

  @override
  String get seasonOrdinaryTime => 'Karaniwang Panahon';

  @override
  String get feastAshWednesday => 'Miyerkules ng Abo';

  @override
  String get feastPalmSunday => 'Linggo ng Palaspas';

  @override
  String get feastEaster => 'Pasko ng Pagkabuhay';

  @override
  String get feastPentecost => 'Pentekostes';

  @override
  String get feastAssumption => 'Ang Pag-aakyat sa Langit ng Mahal na Birhen';

  @override
  String get feastAllSaints => 'Todos los Santos';

  @override
  String get feastImmaculateConception => 'Ang Imakulada Konsepsiyon';

  @override
  String get feastFirstSundayOfAdvent => 'Ang Unang Linggo ng Adbiyento';

  @override
  String get feastChristmas => 'Pasko';

  @override
  String get liturgicalLentTitle => 'Nagsimula na ang Kuwaresma';

  @override
  String get liturgicalLentBody =>
      'Isang panahon ng pagbabalik. Marami ang nagsisimula nito sa kumpisal.';

  @override
  String get liturgicalHolyWeekTitle => 'Nagsimula na ang Mahal na Araw';

  @override
  String get liturgicalHolyWeekBody =>
      'Naglalakbay ang Simbahan tungo sa Pasko ng Pagkabuhay. May panahon pa upang ihanda ang iyong puso.';

  @override
  String get liturgicalAdventTitle => 'Nagsimula na ang Adbiyento';

  @override
  String get liturgicalAdventBody =>
      'Isang panahon ng paghihintay. Marami ang naghahanda ng kanilang puso sa pamamagitan ng kumpisal.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return 'Malapit na ang $feast';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count araw na lamang — ihanda ang iyong puso.',
      one: 'Isang araw na lamang — ihanda ang iyong puso.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linggo na ang nakalipas mula sa huli mong kumpisal',
      one: 'Isang linggo na ang nakalipas mula sa huli mong kumpisal',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Kailan ka man handa, naghihintay ang awa. Nais mo bang maghanda?';

  @override
  String get promptPrepare => 'Maghanda';

  @override
  String get dataUnrecoverableTitle => 'Hindi mabuksan ang iyong data';

  @override
  String get dataUnrecoverableBody =>
      'Ang susi na nagpoprotekta sa iyong mga kumpisal ay wala na sa device na ito. Maaari itong mangyari matapos mag-restore mula sa backup, o kung na-reset ang mga setting ng seguridad ng device.\n\nDahil naka-encrypt ang iyong data, hindi na ito mababawi nang wala ang susing iyon — kahit kami mismo ay hindi ito mababawi. Maaari mo itong burahin at magsimulang muli.';

  @override
  String get eraseAndStartOver => 'Burahin at magsimulang muli';

  @override
  String get eraseAndStartOverConfirm =>
      'Permanenteng bubura ito sa lahat ng nakaimbak sa device na ito at magsisimula ang app nang bago. Hindi na ito maibabalik.';

  @override
  String get penanceSaveFailed =>
      'Hindi ma-save ang penitensiya. Pakisubukang muli.';

  @override
  String get confessionReminderChannelName => 'Mga Paalala sa Kumpisal';

  @override
  String get confessionReminderChannelDescription =>
      'Mga paalala para sa kumpisal';

  @override
  String get journalReminderChannelName => 'Mga Paalala sa Talaarawan';

  @override
  String get journalReminderChannelDescription =>
      'Araw-araw na paalala upang isulat ang pagninilay sa gabi';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ang napangalanan sa ngayon',
      one: 'Isa ang napangalanan sa ngayon',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Bago ka magsimula';

  @override
  String get invitationCardAction => 'Palakasin ang aking loob';

  @override
  String get homeCtaBeginTitle => 'Simulan ang iyong pagsusuri';

  @override
  String get homeCtaBeginSubtitle => 'Ihanda ang iyong puso bago mangumpisal';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ipagpatuloy ang iyong pagsusuri ($count napili)',
      one: 'Ipagpatuloy ang iyong pagsusuri (1 napili)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Ipagpatuloy kung saan ka huminto';

  @override
  String get homeCtaReadyTitle => 'Handa ka na';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kasalanan ang naghihintay sa iyong listahan ng kumpisal',
      one: '1 kasalanan ang naghihintay sa iyong listahan ng kumpisal',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Tapusin ang iyong penitensiya';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitensiya ang naghihintay pa',
      one: '1 penitensiya ang naghihintay pa',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Pampalakas-loob, gabay na hakbang-hakbang, mga panalangin at FAQ';

  @override
  String get homeQuoteReadMore => 'Magbasa pa';

  @override
  String get homeQuoteShowLess => 'Bawasan';

  @override
  String get tutorialJournalDesc =>
      'Balikan ang iyong araw tuwing gabi: isang maikling pagninilay, at ang iyong sunod-sunod na talaan.';
}
