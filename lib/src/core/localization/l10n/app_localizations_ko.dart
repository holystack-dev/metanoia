// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => '환영합니다';

  @override
  String get examineTitle => '성찰';

  @override
  String get confessTitle => '고해';

  @override
  String get prayersTitle => '기도문';

  @override
  String get settingsTitle => '설정';

  @override
  String get examinationTitle => '양심 성찰';

  @override
  String get commandment => '계명';

  @override
  String get guideTitle => '안내';

  @override
  String get faqTitle => '고해성사 이해하기';

  @override
  String get language => '언어';

  @override
  String get chooseLanguage => '사용할 언어를 선택하십시오';

  @override
  String get theme => '테마';

  @override
  String get chooseTheme => '사용할 테마를 선택하십시오';

  @override
  String get system => '시스템';

  @override
  String get light => '밝게';

  @override
  String get dark => '어둡게';

  @override
  String get reminders => '알림';

  @override
  String get getReminded => '고해성사를 잊지 않도록 알림을 받습니다';

  @override
  String get enableReminders => '알림 켜기';

  @override
  String get weekly => '매주';

  @override
  String get biweekly => '격주';

  @override
  String get monthly => '매달';

  @override
  String get quarterly => '분기마다';

  @override
  String get day => '요일';

  @override
  String get time => '시간';

  @override
  String get remindMe => '알림 시점';

  @override
  String get onTheDay => '당일';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 전',
      one: '1일 전',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => '빠른 실행';

  @override
  String get lastConfession => '마지막 고해';

  @override
  String get noneYet => '아직 없음';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 전',
      one: '1일 전',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => '다음 알림';

  @override
  String get off => '꺼짐';

  @override
  String get mon => '월';

  @override
  String get tue => '화';

  @override
  String get wed => '수';

  @override
  String get thu => '목';

  @override
  String get fri => '금';

  @override
  String get sat => '토';

  @override
  String get sun => '일';

  @override
  String get monday => '월요일';

  @override
  String get tuesday => '화요일';

  @override
  String get wednesday => '수요일';

  @override
  String get thursday => '목요일';

  @override
  String get friday => '금요일';

  @override
  String get saturday => '토요일';

  @override
  String get sunday => '일요일';

  @override
  String get appLanguage => '앱 언어';

  @override
  String get appLanguageSubtitle => '버튼과 라벨, 메뉴에 사용되는 언어';

  @override
  String get contentLanguage => '콘텐츠 언어';

  @override
  String get contentLanguageSubtitle => '성찰 질문과 자주 묻는 질문, 기도문에 사용되는 언어';

  @override
  String get version => '버전';

  @override
  String get selectDay => '요일 선택';

  @override
  String selected(num count) {
    return '$count개 선택됨';
  }

  @override
  String get selectedLabel => '선택됨';

  @override
  String get counter => '선택 개수';

  @override
  String get searchPlaceholder => '계명 또는 질문 검색...';

  @override
  String get noResults => '검색 결과가 없습니다';

  @override
  String get viewHistory => '기록 보기';

  @override
  String get noActiveConfession => '진행 중인 고해가 없습니다';

  @override
  String get startExaminationPrompt => '성찰을 시작하여 이곳에 죄를 추가하십시오.';

  @override
  String get startExamination => '성찰 시작하기';

  @override
  String get finishConfessionTitle => '고해를 마치시겠습니까?';

  @override
  String get finishConfessionContent => '이 고해를 완료로 표시하고 기록으로 옮깁니다.';

  @override
  String get cancel => '취소';

  @override
  String get finish => '마치기';

  @override
  String get confessionCompletedMessage => '고해를 마쳤습니다. 하느님의 축복이 함께하기를 빕니다.';

  @override
  String get finishConfession => '고해 마치기';

  @override
  String get error => '오류';

  @override
  String get retry => '다시 시도';

  @override
  String get dailyQuoteError => '오늘의 말씀을 불러오지 못했습니다.';

  @override
  String get keepHistory => '고해 기록 보관';

  @override
  String get keepHistorySubtitle => '고백한 죄를 날짜와 함께 저장합니다. 끄면 날짜만 저장됩니다.';

  @override
  String get deleteConfession => '고해 삭제';

  @override
  String get deleteConfessionContent =>
      '이 고해와 그에 담긴 모든 항목이 기록에서 영구히 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get tutorialExamineDesc => '고해 전에 양심을 성찰하려면 여기에서 시작하십시오.';

  @override
  String get tutorialConfessDesc => '고해 중에 이곳에서 죄를 하나씩 짚어 나가십시오.';

  @override
  String get tutorialPrayersDesc => '고해 전후에 바치는 기도문을 이곳에서 찾을 수 있습니다.';

  @override
  String get tutorialGuideDesc => '격려의 말씀과 단계별 고해 안내, 자주 묻는 질문을 이곳에서 볼 수 있습니다.';

  @override
  String get tutorialSettingsDesc =>
      '이곳에서 언어와 테마를 바꾸고, 알림을 설정하고, 보안을 관리할 수 있습니다.';

  @override
  String get tutorialSwipeDesc => '좌우로 밀어 계명 사이를 이동하십시오.';

  @override
  String get tutorialSelectDesc => '질문을 눌러 고해에 포함할 항목으로 선택하십시오.';

  @override
  String get tutorialFinishDesc => '다 마쳤으면 여기를 눌러 성찰을 끝내고 고해로 넘어가십시오.';

  @override
  String get tutorialCounterDesc => '고해를 위해 선택한 항목의 개수를 보여 줍니다.';

  @override
  String get tutorialMenuDesc => '이곳에서 직접 입력한 죄를 관리하고 선택을 모두 지울 수 있습니다.';

  @override
  String get tutorialPenanceDesc => '고해 사제가 정해 준 보속을 이곳에서 관리하십시오.';

  @override
  String get tutorialInsightsDesc => '고해 여정의 통계와 연속 기록을 볼 수 있습니다.';

  @override
  String get tutorialHistoryDesc => '지난 고해와 그 날짜를 확인할 수 있습니다.';

  @override
  String get replayTutorial => '튜토리얼 다시 보기';

  @override
  String get replayTutorialDesc => '앱 사용 안내를 다시 봅니다';

  @override
  String get tutorialReset => '튜토리얼을 초기화했습니다. 안내를 다시 볼 수 있습니다.';

  @override
  String get about => '앱 정보';

  @override
  String get aboutSubtitle => '버전과 라이선스, 소스 코드';

  @override
  String get shareApp => '앱 공유';

  @override
  String get shareAppSubtitle => '친구와 가족에게 알리기';

  @override
  String get rateApp => '앱 평가';

  @override
  String get spreadShareTitle => 'Metanoia 공유하기';

  @override
  String get spreadShareSubtitle => '고해에서 멀어진 분을 아시나요? 다시 돌아오실 수 있도록 도와주십시오.';

  @override
  String get spreadShareAction => '공유';

  @override
  String get spreadRateSubtitle =>
      '고해를 준비하는 데 Metanoia가 도움이 되었다면, 남겨 주시는 평가가 다른 분들이 이 앱을 찾는 데 큰 도움이 됩니다.';

  @override
  String get spreadRateAction => '평가';

  @override
  String get rateGateHint => '경험을 어떻게 평가하시겠습니까?';

  @override
  String get rateGateLowest => '가장 낮음';

  @override
  String get rateGateHighest => '가장 높음';

  @override
  String get rateGateThanks => '감사합니다. 보내 주신 의견은 저희에게 큰 힘이 됩니다.';

  @override
  String rateAppSubtitle(String store) {
    return '$store에서 평가해 주십시오';
  }

  @override
  String get website => '웹사이트';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get madeWithLove => 'holystack.dev가 ❤️를 담아 만들었습니다';

  @override
  String get rateDialogTitle => 'Metanoia가 도움이 되시나요?';

  @override
  String get rateDialogContent => '이 앱이 도움이 되셨다면 잠시 시간을 내어 평가해 주십시오. 큰 힘이 됩니다!';

  @override
  String get rateDialogYes => '지금 평가하기';

  @override
  String get rateDialogNo => '괜찮습니다';

  @override
  String get rateDialogLater => '나중에 알림';

  @override
  String get greekLabel => '그리스어';

  @override
  String get nounLabel => '명사';

  @override
  String get metanoiaDefinition =>
      '생각과 마음의 깊은 변화. 존재 전체를 새롭게 하고 삶의 방향을 하느님께로 돌리는 영적 깨어남.';

  @override
  String get turnBackToGrace => '은총으로 돌아가기';

  @override
  String get welcomeSubtitle => '뜻깊은 고해를 위한 길잡이';

  @override
  String get discoverInnerGrace => '내면의 은총을 찾아서';

  @override
  String get sacredJourneyBegins => '화해를 향한 거룩한 여정이 시작됩니다.';

  @override
  String get beginJourney => '여정 시작하기';

  @override
  String get getStarted => '시작하기';

  @override
  String get chooseContentLanguage => '콘텐츠 언어 선택';

  @override
  String get contentLanguageDescription => '기도문과 양심 성찰, 안내에 사용할 언어를 선택하십시오';

  @override
  String get changeAnytimeNote => '설정에서 언제든지 바꿀 수 있습니다';

  @override
  String get continueButton => '계속';

  @override
  String get examineDescription => '고해 전에 십계명에 따라 양심을 성찰하십시오';

  @override
  String get confessDescription => '고해 중에 죄를 짚어 가며 빠뜨리는 것이 없도록 하십시오';

  @override
  String get prayersDescription => '고해 전후의 기도문과 보속 기도를 찾아보십시오';

  @override
  String get remindersDescription => '설정에서 정기 알림을 켜 두면 고해성사를 잊지 않을 수 있습니다';

  @override
  String get nextButton => '다음';

  @override
  String get customSins => '직접 입력한 죄';

  @override
  String get manageCustomSins => '직접 입력한 죄 관리';

  @override
  String get addCustomSin => '죄 직접 추가';

  @override
  String get editCustomSin => '직접 입력한 죄 수정';

  @override
  String get deleteCustomSin => '직접 입력한 죄 삭제';

  @override
  String get sinDescription => '죄 내용';

  @override
  String get sinDescriptionHint => '기억해 두고 싶은 죄를 적으십시오';

  @override
  String get sinDescriptionRequired => '죄 내용을 입력하십시오';

  @override
  String get optionalNote => '메모 (선택)';

  @override
  String get optionalNoteHint => '덧붙일 내용을 적으십시오';

  @override
  String get selectCommandment => '계명 선택 (선택 사항)';

  @override
  String get noCommandment => '일반 / 계명 없음';

  @override
  String get customSinAdded => '죄를 추가했습니다';

  @override
  String get customSinUpdated => '죄를 수정했습니다';

  @override
  String get customSinDeleted => '죄를 삭제했습니다';

  @override
  String get deleteCustomSinConfirm => '직접 입력한 이 죄를 삭제하시겠습니까?';

  @override
  String get noCustomSins => '직접 입력한 죄가 없습니다';

  @override
  String get noCustomSinsDesc => '죄를 직접 추가하여 나만의 성찰을 만들어 보십시오';

  @override
  String get customVersion => '직접 수정함';

  @override
  String get searchCustomSins => '직접 입력한 죄 검색...';

  @override
  String get addButton => '추가';

  @override
  String get updateButton => '수정';

  @override
  String get deleteButton => '삭제';

  @override
  String get addYourOwn => '직접 입력하기...';

  @override
  String get penance => '보속';

  @override
  String get penanceTracker => '보속 관리';

  @override
  String get addPenance => '보속 추가';

  @override
  String get editPenance => '보속 수정';

  @override
  String get penanceDescription => '어떤 보속을 받으셨나요?';

  @override
  String get penanceHint => '예: 성모송 3번 바치기, 성경 구절 읽기...';

  @override
  String get penanceAdded => '보속을 추가했습니다';

  @override
  String get penanceUpdated => '보속을 수정했습니다';

  @override
  String get penanceCompleted => '보속을 마쳤습니다. 하느님의 축복이 함께하기를 빕니다.';

  @override
  String get markAsComplete => '완료로 표시';

  @override
  String get pendingPenances => '남은 보속';

  @override
  String get noPendingPenances => '남은 보속이 없습니다';

  @override
  String get noPendingPenancesDesc => '모든 보속을 마쳤습니다. 하느님의 축복이 함께하기를 빕니다!';

  @override
  String completedOn(Object date) {
    return '$date에 완료';
  }

  @override
  String assignedOn(Object date) {
    return '$date에 받음';
  }

  @override
  String get skipPenance => '건너뛰기';

  @override
  String get savePenance => '보속 저장';

  @override
  String get insights => '통계';

  @override
  String get confessionInsights => '고해 통계';

  @override
  String get totalConfessions => '전체 고해 횟수';

  @override
  String get averageFrequency => '평균 주기';

  @override
  String everyXDays(Object count) {
    return '$count일마다';
  }

  @override
  String get daysSinceLastConfession => '마지막 고해 이후';

  @override
  String get currentStreak => '현재 연속 기록';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주',
      one: '1주',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => '월별 기록';

  @override
  String get confessionsThisYear => '올해의 고해';

  @override
  String get noInsightsYet => '아직 통계가 없습니다';

  @override
  String get noInsightsYetDesc => '첫 고해를 마치면 영적 여정의 통계를 볼 수 있습니다';

  @override
  String get totalItemsConfessed => '고백한 항목 수';

  @override
  String get firstConfession => '첫 고해';

  @override
  String get spiritualJourney => '나의 영적 여정';

  @override
  String get listView => '목록';

  @override
  String get guidedView => '안내';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$total 중 $current';
  }

  @override
  String get previousCommandment => '이전';

  @override
  String get nextCommandment => '다음';

  @override
  String get finishExamination => '마치기';

  @override
  String get noQuestionsSelected => '이 항목에서 선택한 질문이 없습니다';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count개 선택됨';
  }

  @override
  String get examinationSummary => '성찰 요약';

  @override
  String get examinationNote =>
      '철저한 양심 성찰은 어떤 목록으로도 다 담을 수 없습니다. 자신의 삶의 처지와 형편을 기도하는 마음으로 돌아보십시오.';

  @override
  String selectedCount(Object count) {
    return '$count개 항목 선택됨';
  }

  @override
  String get noSinsSelected => '선택한 죄가 없습니다';

  @override
  String get continueEditing => '계속 편집하기';

  @override
  String get proceedToConfess => '계속하기';

  @override
  String get clearDraftTitle => '임시 저장을 지우시겠습니까?';

  @override
  String get clearDraftMessage => '선택한 질문이 모두 삭제됩니다. 계속하시겠습니까?';

  @override
  String get clearDraft => '임시 저장 지우기';

  @override
  String get clear => '지우기';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '지난 세션에서 항목 $count개를 복원했습니다',
      one: '지난 세션에서 항목 1개를 복원했습니다',
    );
    return '$_temp0';
  }

  @override
  String get justNow => '방금 전';

  @override
  String minutesAgo(Object count) {
    return '$count분 전';
  }

  @override
  String hoursAgo(Object count) {
    return '$count시간 전';
  }

  @override
  String get general => '일반';

  @override
  String get noQuestionsInSection => '이 항목에는 질문이 없습니다';

  @override
  String get skip => '건너뛰기';

  @override
  String get back => '뒤로';

  @override
  String get skipOnboardingTitle => '소개를 건너뛰시겠습니까?';

  @override
  String get skipOnboardingMessage =>
      '마지막 화면으로 바로 이동합니다. 여기서 설정되는 것은 없으며, 나중에 설정에서 모두 바꿀 수 있습니다.';

  @override
  String get confessionHistoryTitle => '고해 기록';

  @override
  String get deleteAll => '전체 삭제';

  @override
  String get editDate => '날짜 수정';

  @override
  String get confessionDate => '고해 날짜';

  @override
  String get dateUpdated => '날짜를 수정했습니다';

  @override
  String get changeDateConfirmTitle => '날짜를 바꾸시겠습니까?';

  @override
  String changeDateConfirmMessage(Object date) {
    return '고해 날짜를 $date(으)로 바꾸시겠습니까?';
  }

  @override
  String get noGuideContent => '안내 내용이 없습니다';

  @override
  String get noGuideContentDesc => '안내 내용이 이곳에 표시됩니다';

  @override
  String get noFaqContent => '자주 묻는 질문이 없습니다';

  @override
  String get noFaqContentDesc => '자주 묻는 질문이 이곳에 표시됩니다';

  @override
  String get faqSubtitle => '화해의 성사 안내';

  @override
  String get tapToExpand => '눌러서 더 보기';

  @override
  String get continueExamination => '성찰 이어 하기';

  @override
  String get continueExaminationDesc => '진행 중인 성찰이 있습니다';

  @override
  String examinationProgress(Object count) {
    return '$count개 항목 선택됨';
  }

  @override
  String get security => '보안';

  @override
  String get securitySubtitle => '개인 정보를 보호합니다';

  @override
  String get pinAndBiometric => 'PIN 및 생체 인식';

  @override
  String get pinAndBiometricSubtitle => '앱 잠금 설정을 구성합니다';

  @override
  String get enterPin => 'PIN 입력';

  @override
  String get createPin => 'PIN 만들기';

  @override
  String get confirmPin => 'PIN 확인';

  @override
  String get incorrectPin => 'PIN이 올바르지 않습니다';

  @override
  String get pinMismatch => 'PIN이 일치하지 않습니다';

  @override
  String get biometricUnlock => '생체 인식 잠금 해제';

  @override
  String get autoLockTimeout => '자동 잠금 시간';

  @override
  String get tooManyAttempts => '실패 횟수가 너무 많습니다';

  @override
  String tryAgainIn(Object time) {
    return '$time 후에 다시 시도하십시오';
  }

  @override
  String get useBiometricUnlock => '생체 인식으로 잠금 해제';

  @override
  String get unlockWithFingerprintOrFace => '지문 또는 얼굴로 잠금을 해제합니다';

  @override
  String get biometricAccessWarning =>
      '이 기기에 등록된 지문이나 얼굴을 가진 사람은 누구나 앱에 접근할 수 있습니다';

  @override
  String get lockAfter => '잠금 대기 시간';

  @override
  String get timeInBackgroundBeforeLocking => '앱이 백그라운드에 머문 뒤 잠기기까지의 시간';

  @override
  String get changePin => 'PIN 변경';

  @override
  String get updateYourSecurityPin => '보안 PIN을 변경합니다';

  @override
  String get enterCurrentPin => '현재 PIN 입력';

  @override
  String get enterNewPin => '새 PIN 입력';

  @override
  String get confirmNewPin => '새 PIN 확인';

  @override
  String get pinChangedSuccessfully => 'PIN을 변경했습니다';

  @override
  String get currentPinIncorrect => '현재 PIN이 올바르지 않습니다';

  @override
  String get enableBiometricUnlock => '생체 인식 잠금 해제를 켜시겠습니까?';

  @override
  String get biometricDescription => '지문이나 얼굴로 앱을 빠르고 안전하게 잠금 해제합니다.';

  @override
  String get notNow => '나중에';

  @override
  String get enable => '켜기';

  @override
  String get setUpPin => 'PIN 설정';

  @override
  String get createSixDigitPin => '여섯 자리 PIN을 만드십시오';

  @override
  String get pinProtectData => '이 PIN으로 데이터를 보호합니다';

  @override
  String get confirmYourPin => 'PIN을 확인하십시오';

  @override
  String get enterSamePinAgain => '확인을 위해 같은 PIN을 다시 입력하십시오';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => '잠금을 해제하려면 PIN을 입력하십시오';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count회 남았습니다',
      one: '1회 남았습니다',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count초',
      one: '1초',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count분',
      one: '1분',
    );
    return '$_temp0';
  }

  @override
  String get undo => '실행 취소';

  @override
  String get confessionDeleted => '고해를 삭제했습니다';

  @override
  String get noConfessionHistory => '고해 기록이 없습니다';

  @override
  String get noConfessionHistoryDesc => '마친 고해가 이곳에 표시됩니다';

  @override
  String get fontSize => '글자 크기';

  @override
  String get fontSizeSubtitle => '읽기 편하도록 글자 크기를 조절합니다';

  @override
  String get fontSizeSmall => '작게';

  @override
  String get fontSizeMedium => '보통';

  @override
  String get fontSizeLarge => '크게';

  @override
  String get fontSizeExtraLarge => '아주 크게';

  @override
  String get forgotPin => 'PIN을 잊으셨나요?';

  @override
  String get resetPinTitle => 'PIN 초기화';

  @override
  String get resetPinWarning => '경고: 모든 데이터가 영구히 삭제됩니다';

  @override
  String get resetPinDescription =>
      'PIN을 초기화하면 고해 기록과 직접 입력한 죄, 보속을 비롯한 모든 개인 정보가 영구히 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get resetPinConfirmation => '확인하려면 DELETE를 입력하십시오';

  @override
  String get resetPinButton => 'PIN 초기화 및 데이터 삭제';

  @override
  String get resetPinSuccess => 'PIN을 초기화했습니다. 새 PIN을 설정하십시오.';

  @override
  String get resetPinError => 'PIN 초기화에 실패했습니다. 다시 시도하십시오.';

  @override
  String get deleteConfirmationText => 'DELETE';

  @override
  String resetPinWaitTimer(int seconds) {
    return '$seconds초만 기다려 주십시오';
  }

  @override
  String get resetPinBiometricPrompt => 'PIN을 초기화하려면 본인 확인이 필요합니다';

  @override
  String get confessionGuideTitle => '좋은 고해를 하는 방법';

  @override
  String get shortFilmTitle => '고해: 단편 영화';

  @override
  String get shortFilmSubtitle =>
      '제작: Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, 영국';

  @override
  String get confessionGuideSubtitle => '성사를 위한 단계별 안내';

  @override
  String get invitationTitle => '고해성사로 돌아오시나요?';

  @override
  String get invitationSubtitle => '당신을 위한 격려의 말씀';

  @override
  String get invitationDialogTitle => '환영합니다';

  @override
  String get invitationDialogContent =>
      '오랜만에 보는 고해성사인가요, 아니면 고해하러 가는 것이 두렵게 느껴지시나요?';

  @override
  String get invitationDialogYes => '네, 격려의 말씀을 듣고 싶습니다';

  @override
  String get invitationDialogNo => '아니요, 바로 시작하겠습니다';

  @override
  String get invitationDialogDontShowAgain => '다시 보지 않기';

  @override
  String get searchPrayers => '기도문 검색...';

  @override
  String get allCategories => '전체';

  @override
  String get appDisclaimer =>
      '이 앱은 고해성사를 준비하기 위한 영적 도구입니다. 사제와 함께하는 화해의 성사를 대신할 수는 없습니다.';

  @override
  String get onboardingDisclaimer => '고해성사를 돕는 영적 동반자일 뿐, 고해성사를 대신하지는 않습니다.';

  @override
  String get readyToBegin => '준비가 되었습니다';

  @override
  String get readyToBeginSubtitle => '화해를 향한 당신의 여정에 은총과 평화가 가득하기를 빕니다.';

  @override
  String get onboardingOverviewTitle => '이 앱이 하는 일';

  @override
  String get onboardingOverviewExamine => '당신의 속도에 맞추어 양심을 준비하십시오.';

  @override
  String get onboardingOverviewConfess => '잊는 것이 없도록, 눈에 띄지 않는 목록으로.';

  @override
  String get onboardingOverviewJournal => '고해성사 사이에도 계속 자라도록, 짧은 저녁 성찰로.';

  @override
  String get onboardingOverviewFootnote => '기도문과 안내, 그리고 선택할 수 있는 알림이 담겨 있습니다.';

  @override
  String get onboardingPrivacyTitle => '처음부터 비공개로';

  @override
  String get onboardingPrivacyLocal => '모든 것이 이 휴대전화에 머무릅니다. 계정도, 클라우드도 없습니다.';

  @override
  String get onboardingPrivacyEncrypted => '기기 안에서 암호화됩니다.';

  @override
  String get onboardingPrivacyPin => '성찰이나 일기를 처음 열 때 PIN을 만들게 됩니다.';

  @override
  String get sourceCode => '소스 코드';

  @override
  String get contentReferences => '콘텐츠 출처';

  @override
  String get examinationModeTitle => '어떤 방식으로 성찰하시겠습니까?';

  @override
  String get quickReviewMode => '빠른 살펴보기';

  @override
  String get quickReviewDescription => '계명별로 모든 질문을 훑어봅니다';

  @override
  String get deepReflectionMode => '깊은 성찰';

  @override
  String get deepReflectionDescription => '한 번에 한 질문씩 차분히 성찰합니다';

  @override
  String get contemplativePrayerTitle => '오소서, 성령님';

  @override
  String get contemplativePrayerText =>
      '제 마음을 채우시고 당신 사랑의 불을 지펴 주소서. 제 지성을 밝히시어 제 죄를 분명히 보게 하소서.';

  @override
  String get imReady => '준비되었습니다';

  @override
  String get skipPrayer => '건너뛰기';

  @override
  String get yesThisApplies => '예';

  @override
  String get noThisDoesnt => '아니요';

  @override
  String get skipQuestion => '건너뛰기';

  @override
  String questionProgress(int current, int total) {
    return '$total개 중 $current번째';
  }

  @override
  String get examinationComplete => '성찰을 마쳤습니다';

  @override
  String get reviewYourSelections => '선택한 항목 확인하기';

  @override
  String get examinationModeSettingTitle => '성찰 방식';

  @override
  String get examinationModeSettingSubtitle => '양심 성찰을 어떤 방식으로 할지 선택하십시오';

  @override
  String get askEveryTime => '매번 묻기';

  @override
  String get reminderNotificationTitle => '고해성사를 볼 때입니다';

  @override
  String get reminderNotificationBody => '양심을 성찰하고 고해성사를 준비하십시오';

  @override
  String get notificationPermissionDenied =>
      '알림이 꺼져 있습니다. 고해성사 알림을 받으려면 기기 설정에서 Metanoia의 알림을 허용하십시오.';

  @override
  String get openSourceLicenses => '오픈 소스 라이선스';

  @override
  String get couldNotOpenLink => '링크를 열지 못했습니다';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 항목 고백',
      one: '1개 항목 고백',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '보속 $count개',
      one: '보속 1개',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 남음',
      one: '1개 남음',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '전체 $count회',
      one: '전체 1회',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 항목',
      one: '1개 항목',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
      one: '1일',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주',
      one: '1주',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => '모든 고해 기록을 삭제하시겠습니까?';

  @override
  String get deleteAllConfessionsContent =>
      '모든 고해 기록이 영구히 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get allConfessionsDeleted => '모든 고해 기록을 삭제했습니다';

  @override
  String get deletePenanceConfirm => '이 보속을 삭제하시겠습니까?';

  @override
  String get completed => '완료';

  @override
  String get tapToCollapse => '눌러서 접기';

  @override
  String get dismiss => '닫기';

  @override
  String showcaseStep(int current, int total) {
    return '$total단계 중 $current단계';
  }

  @override
  String get done => '완료';

  @override
  String get navigate => '이동';

  @override
  String get encouragement => '격려의 말씀';

  @override
  String get biometricPromptReason => 'Metanoia를 열려면 본인 확인이 필요합니다';

  @override
  String get tryAgainInLabel => '다시 시도까지';

  @override
  String get errorLoadingLanguage => '언어를 불러오지 못했습니다';

  @override
  String get detailsNotSaved => '세부 내용이 저장되지 않았습니다';

  @override
  String get discardStoredSinsTitle => '저장된 죄를 지우시겠습니까?';

  @override
  String get discardStoredSinsContent =>
      '고해 기록 보관이 꺼졌습니다. 지난 고해에서 저장된 죄는 아직 남아 있습니다. 지우시겠습니까? 날짜는 그대로 남으므로 통계와 연속 기록은 유지됩니다.';

  @override
  String get keepThem => '남겨 두기';

  @override
  String get discard => '지우기';

  @override
  String get storedSinsDiscarded => '저장된 죄를 지웠습니다. 고해 날짜는 남겨 두었습니다.';

  @override
  String get journalTitle => '일기';

  @override
  String get journalHomeCardTitle => '저녁 성찰';

  @override
  String get journalHomeCardSubtitle => '오늘 하루는 어떠셨습니까?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
      one: '$count일',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => '연속으로 성찰한 날수';

  @override
  String get journalContinueToday => '오늘의 기록 이어 쓰기';

  @override
  String get journalPreviousMonth => '지난달';

  @override
  String get journalNextMonth => '다음 달';

  @override
  String get journalGratitudeTitle => '감사';

  @override
  String get journalGratitudePrompt => '오늘 하느님을 어디에서 뵈었습니까?';

  @override
  String get journalGratitudeHint => '그분께 감사드리고 싶은 은총 하나…';

  @override
  String get journalPresenceLead =>
      '하느님께서 여기 당신과 함께 계십니다. 그분 앞에 고요히 머물며 감사드리십시오.';

  @override
  String get journalPresenceVerse => '너희는 멈추고 내가 하느님임을 알아라.';

  @override
  String get journalPresenceRef => '시편 46,11';

  @override
  String get journalLightTitle => '빛을 청하기';

  @override
  String get journalLightLead => '성령께 빛을 청하여 하느님께서 보시듯 당신의 하루를 바라보십시오.';

  @override
  String get journalLightVerse =>
      '오소서, 성령님. 저희 마음을 성령으로 가득 채우시어 저희 안에 사랑의 불이 타오르게 하소서.';

  @override
  String get journalReviewTitle => '하느님과 함께 돌아보기';

  @override
  String get journalReviewLead =>
      '주님과 함께 당신의 하루를 되짚어 보십시오. 사랑이 당신에게 다가온 곳, 당신이 사랑을 베푼 곳, 그리고 당신이 등을 돌린 곳을.';

  @override
  String get journalReviewVerse =>
      '하느님, 저를 살펴보시어 제 마음을 알아주소서. 저를 꿰뚫어 보시어 제 생각을 알아주소서. 제게 고통의 길이 있는지 보시어 저를 영원의 길로 이끄소서.';

  @override
  String get journalReviewRef => '시편 139,23-24';

  @override
  String get journalReviewHint => '그분께 당신의 하루를 이야기하십시오…';

  @override
  String get journalReviewBringSin => '그분께 가져가고 싶은 것이 있습니까?';

  @override
  String get journalContritionTitle => '통회';

  @override
  String get journalContritionLead =>
      '당신이 발견한 것을 아버지께 가져가십시오. 그분께서 당신을 맞으러 달려오십니다.';

  @override
  String get journalContritionVerse =>
      '하느님, 당신 자애에 따라 저를 불쌍히 여기소서. 당신의 크신 자비에 따라 저의 죄악을 지워 주소서.';

  @override
  String get journalContritionRef => '시편 51,3';

  @override
  String get journalContritionPray => '통회 기도를 바치십시오';

  @override
  String get journalContritionMercy =>
      '하느님을 향한 사랑에서 우러나온 통회와 고해하려는 결심은 오늘 밤 그분의 자비를 향해 당신의 마음을 여는 것입니다. 그리고 그 자비의 충만함은 고해성사의 사죄경 말씀 안에서 당신을 기다리고 있습니다.';

  @override
  String get journalResolutionLead => '그분의 자비 안에서 쉬십시오. 내일은 그분 안에서 다시 시작됩니다.';

  @override
  String get journalResolutionVerse =>
      '주님의 자애는 다함이 없고 그분의 자비는 끝이 없어 아침마다 새롭다네. 당신의 신의는 크기도 합니다.';

  @override
  String get journalResolutionRef => '애가 3,22-23';

  @override
  String get journalReflectionTitle => '성찰';

  @override
  String get journalReflectionPrompt => '오늘 하루는 어떠셨습니까?';

  @override
  String get journalReflectionHint => '자유롭게 적어 보십시오...';

  @override
  String get journalSinsTitle => '죄 표시하기';

  @override
  String get journalSinsPrompt => '오늘 어디에서 부족했습니까?';

  @override
  String get journalNoSinsMarked => '아직 표시한 것이 없습니다';

  @override
  String get journalAddSin => '죄 표시하기';

  @override
  String get journalRemoveSin => '지우기';

  @override
  String get journalResolutionTitle => '희망과 결심';

  @override
  String get journalResolutionPrompt => '내일을 위한 은총 하나';

  @override
  String get journalResolutionHint => '주님의 은총으로, 내일 저는…';

  @override
  String get journalMoodTitle => '마음 상태';

  @override
  String get journalMoodPrompt => '오늘 밤 당신의 영혼은 어떠합니까?';

  @override
  String get journalMoodDesolate => '황량함';

  @override
  String get journalMoodStruggling => '힘겨움';

  @override
  String get journalMoodSteady => '평온함';

  @override
  String get journalMoodGrateful => '감사함';

  @override
  String get journalMoodConsoled => '위로받음';

  @override
  String get journalSaved => '저장됨';

  @override
  String get journalSaving => '저장 중...';

  @override
  String get journalDeleteEntry => '기록 삭제';

  @override
  String get journalDeleteEntryConfirm => '이 날의 기록을 삭제하시겠습니까? 되돌릴 수 없습니다.';

  @override
  String get journalEntryDeleted => '기록을 삭제했습니다';

  @override
  String get journalPickerQuestions => '질문';

  @override
  String get journalPickerMySins => '나의 죄';

  @override
  String get journalPickerOwnWords => '직접 쓰기';

  @override
  String get journalPickerFreeTextHint => '직접 적어 보십시오';

  @override
  String get journalSearchSins => '죄 검색...';

  @override
  String get journalAbsolved => '고백함';

  @override
  String get journalSinCleared => '고해성사로 가져간 죄';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '일기에 표시한 죄 $count개를 포함하기',
      one: '일기에 표시한 죄를 포함하기',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => '포함하기';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '일기에서 죄 $count개를 추가했습니다',
      one: '일기에서 죄 1개를 추가했습니다',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => '자주 넘어지는 부분';

  @override
  String get journalStruggleAreasSubtitle => '일기에 가장 자주 표시한 항목';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count회 표시',
      one: '1회 표시',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => '일기 알림';

  @override
  String get journalReminderSubtitle => '하루를 돌아보도록 밤에 알려 줍니다';

  @override
  String get enableJournalReminder => '일기 알림 켜기';

  @override
  String get journalReminderNotificationTitle => '저녁 성찰';

  @override
  String get journalReminderNotificationBody => '하느님과 함께 오늘 하루를 돌아보는 시간을 가지십시오';

  @override
  String get confessionDayMode => '고해 모드';

  @override
  String get confessionDayModeDescription => '고해소에서 보기 좋은 크고 간결한 글씨';

  @override
  String get exitConfessionMode => '고해 모드 끝내기';

  @override
  String confessionDayStepOf(int current, int total) {
    return '$total단계 중 $current단계';
  }

  @override
  String get next => '다음';

  @override
  String get actOfContrition => '통회 기도';

  @override
  String get actOfContritionUnavailable => '통회 기도를 불러올 수 없습니다';

  @override
  String get confessionDaySinsTitle => '고백할 죄';

  @override
  String get confessionDayOpeningTitle => '시작';

  @override
  String get confessionDayOpeningIntro => '성호를 그은 다음 시작하십시오:';

  @override
  String get confessionDayOpeningFormula => '';

  @override
  String confessionDaySinceLast(String duration) {
    return '고해한 지 $duration 됩니다.';
  }

  @override
  String get confessionDaySinceLastUnknown => '고해한 지 [며칠/몇 주일/몇 달/몇 년] 됩니다.';

  @override
  String get confessionDaySinsClosing => '이 밖에 알아내지 못한 죄도 모두 용서하여 주십시오.';

  @override
  String get confessionDayThanksgivingTitle => '평화로이 가십시오';

  @override
  String get confessionDayThanksgivingVersicle => '주님은 좋으신 분이시니 찬미합시다.';

  @override
  String get confessionDayThanksgivingResponse => '주님의 자애는 영원하시다.';

  @override
  String get confessionDayThanksgivingBody =>
      '당신의 영혼이 깨끗이 씻겼습니다. 보속을 실천하고 그리스도의 평화 안에서 나아가십시오.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주',
      one: '1주',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count달',
      one: '1달',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년',
      one: '1년',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => '사순 시기';

  @override
  String get seasonHolyWeek => '성주간';

  @override
  String get seasonAdvent => '대림 시기';

  @override
  String get seasonChristmas => '성탄 시기';

  @override
  String get seasonEaster => '부활 시기';

  @override
  String get seasonOrdinaryTime => '연중 시기';

  @override
  String get feastAshWednesday => '재의 수요일';

  @override
  String get feastPalmSunday => '주님 수난 성지 주일';

  @override
  String get feastEaster => '부활 대축일';

  @override
  String get feastPentecost => '성령 강림 대축일';

  @override
  String get feastAssumption => '성모 승천 대축일';

  @override
  String get feastAllSaints => '모든 성인 대축일';

  @override
  String get feastImmaculateConception =>
      '한국 교회의 수호자, 원죄 없이 잉태되신 복되신 동정 마리아 대축일';

  @override
  String get feastFirstSundayOfAdvent => '대림 제1주일';

  @override
  String get feastChristmas => '성탄 대축일';

  @override
  String get liturgicalLentTitle => '사순 시기가 시작되었습니다';

  @override
  String get liturgicalLentBody => '주님께 돌아가는 시기입니다. 많은 이가 고해성사로 이 시기를 시작합니다.';

  @override
  String get liturgicalHolyWeekTitle => '성주간이 시작되었습니다';

  @override
  String get liturgicalHolyWeekBody =>
      '교회는 부활을 향해 나아갑니다. 마음을 준비할 시간은 아직 남아 있습니다.';

  @override
  String get liturgicalAdventTitle => '대림 시기가 시작되었습니다';

  @override
  String get liturgicalAdventBody => '기다림의 시기입니다. 많은 이가 고해성사로 마음을 준비합니다.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast이(가) 다가옵니다';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 남았습니다. 마음을 준비하십시오.',
      one: '하루 남았습니다. 마음을 준비하십시오.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '마지막 고해성사를 본 지 $count주가 지났습니다',
      one: '마지막 고해성사를 본 지 한 주가 지났습니다',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody => '언제든 준비되면 자비가 기다리고 있습니다. 준비하시겠습니까?';

  @override
  String get promptPrepare => '준비하기';

  @override
  String get dataUnrecoverableTitle => '데이터를 열 수 없습니다';

  @override
  String get dataUnrecoverableBody =>
      '고해 내용을 보호하던 열쇠가 이 기기에 더 이상 남아 있지 않습니다. 백업에서 복원했거나 기기의 보안 설정이 초기화된 경우에 이런 일이 일어날 수 있습니다.\n\n데이터가 암호화되어 있으므로 그 열쇠 없이는 복구할 수 없습니다. 저희도 마찬가지입니다. 데이터를 지우고 다시 시작할 수 있습니다.';

  @override
  String get eraseAndStartOver => '지우고 다시 시작하기';

  @override
  String get eraseAndStartOverConfirm =>
      '이 기기에 저장된 모든 것을 영구히 지우고 앱을 처음부터 다시 시작합니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get penanceSaveFailed => '보속을 저장하지 못했습니다. 다시 시도해 주십시오.';

  @override
  String get confessionReminderChannelName => '고해성사 알림';

  @override
  String get confessionReminderChannelDescription => '고해성사를 위한 알림';

  @override
  String get journalReminderChannelName => '일기 알림';

  @override
  String get journalReminderChannelDescription => '저녁 성찰을 쓰도록 알려 주는 매일 알림';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '지금까지 $count개를 짚었습니다',
      one: '지금까지 1개를 짚었습니다',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => '시작하기 전에';

  @override
  String get invitationCardAction => '격려의 말씀 보기';

  @override
  String get homeCtaBeginTitle => '양심 성찰 시작하기';

  @override
  String get homeCtaBeginSubtitle => '고해성사에 앞서 마음을 준비하십시오';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '성찰 이어 하기 ($count개 선택됨)',
      one: '성찰 이어 하기 (1개 선택됨)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => '멈춘 곳부터 이어서 하십시오';

  @override
  String get homeCtaReadyTitle => '준비되었습니다';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '고해 목록에 죄 $count개가 기다리고 있습니다',
      one: '고해 목록에 죄 1개가 기다리고 있습니다',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => '보속 마치기';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '보속 $count개가 아직 남아 있습니다',
      one: '보속 1개가 아직 남아 있습니다',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle => '격려의 말씀과 단계별 안내, 기도문과 자주 묻는 질문';

  @override
  String get homeQuoteReadMore => '더 보기';

  @override
  String get homeQuoteShowLess => '접기';

  @override
  String get tutorialJournalDesc => '저녁마다 하루를 돌아보십시오. 짧은 성찰과 연속 기록을 볼 수 있습니다.';
}
