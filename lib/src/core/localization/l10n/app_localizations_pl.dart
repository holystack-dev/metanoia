// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Witaj';

  @override
  String get examineTitle => 'Rachunek';

  @override
  String get confessTitle => 'Spowiedź';

  @override
  String get prayersTitle => 'Modlitwy';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get examinationTitle => 'Rachunek sumienia';

  @override
  String get commandment => 'Przykazanie';

  @override
  String get guideTitle => 'Przewodnik';

  @override
  String get faqTitle => 'Zrozumieć spowiedź';

  @override
  String get language => 'Język';

  @override
  String get chooseLanguage => 'Wybierz preferowany język';

  @override
  String get theme => 'Motyw';

  @override
  String get chooseTheme => 'Wybierz preferowany motyw';

  @override
  String get system => 'Systemowy';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get reminders => 'Przypomnienia';

  @override
  String get getReminded => 'Otrzymuj przypomnienia o spowiedzi';

  @override
  String get enableReminders => 'Włącz przypomnienia';

  @override
  String get weekly => 'Co tydzień';

  @override
  String get biweekly => 'Co dwa tygodnie';

  @override
  String get monthly => 'Co miesiąc';

  @override
  String get quarterly => 'Co kwartał';

  @override
  String get day => 'Dzień';

  @override
  String get time => 'Godzina';

  @override
  String get remindMe => 'Przypomnij mi';

  @override
  String get onTheDay => 'W dniu';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia wcześniej',
      many: '$count dni wcześniej',
      few: '$count dni wcześniej',
      one: '1 dzień wcześniej',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Szybkie działania';

  @override
  String get lastConfession => 'Ostatnia spowiedź';

  @override
  String get noneYet => 'Jeszcze brak';

  @override
  String get today => 'Dzisiaj';

  @override
  String get yesterday => 'Wczoraj';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia temu',
      many: '$count dni temu',
      few: '$count dni temu',
      one: '1 dzień temu',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Następne przypomnienie';

  @override
  String get off => 'Wyłączone';

  @override
  String get mon => 'Pon';

  @override
  String get tue => 'Wt';

  @override
  String get wed => 'Śr';

  @override
  String get thu => 'Czw';

  @override
  String get fri => 'Pt';

  @override
  String get sat => 'Sob';

  @override
  String get sun => 'Niedz';

  @override
  String get monday => 'Poniedziałek';

  @override
  String get tuesday => 'Wtorek';

  @override
  String get wednesday => 'Środa';

  @override
  String get thursday => 'Czwartek';

  @override
  String get friday => 'Piątek';

  @override
  String get saturday => 'Sobota';

  @override
  String get sunday => 'Niedziela';

  @override
  String get appLanguage => 'Język aplikacji';

  @override
  String get appLanguageSubtitle => 'Język przycisków, etykiet i menu';

  @override
  String get contentLanguage => 'Język treści';

  @override
  String get contentLanguageSubtitle =>
      'Język pytań rachunku sumienia, pytań i odpowiedzi oraz modlitw';

  @override
  String get version => 'Wersja';

  @override
  String get selectDay => 'Wybierz dzień';

  @override
  String selected(num count) {
    return 'Wybrano: $count';
  }

  @override
  String get selectedLabel => 'wybrano';

  @override
  String get counter => 'Licznik';

  @override
  String get searchPlaceholder => 'Szukaj przykazań lub pytań...';

  @override
  String get noResults => 'Nie znaleziono wyników';

  @override
  String get viewHistory => 'Zobacz historię';

  @override
  String get noActiveConfession => 'Brak aktywnej spowiedzi';

  @override
  String get startExaminationPrompt =>
      'Rozpocznij rachunek sumienia, aby dodać tu grzechy.';

  @override
  String get startExamination => 'Rozpocznij rachunek sumienia';

  @override
  String get finishConfessionTitle => 'Zakończyć spowiedź?';

  @override
  String get finishConfessionContent =>
      'Spowiedź zostanie oznaczona jako zakończona i przeniesiona do twojej historii.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get finish => 'Zakończ';

  @override
  String get confessionCompletedMessage => 'Spowiedź zakończona! Szczęść Boże.';

  @override
  String get finishConfession => 'Zakończ spowiedź';

  @override
  String get error => 'Błąd';

  @override
  String get retry => 'Ponów';

  @override
  String get dailyQuoteError => 'Nie udało się wczytać dzisiejszego cytatu.';

  @override
  String get keepHistory => 'Zachowuj historię spowiedzi';

  @override
  String get keepHistorySubtitle =>
      'Zapisuj swoje grzechy wraz z datą. Jeśli wyłączone, zapisana zostanie tylko data.';

  @override
  String get deleteConfession => 'Usuń spowiedź';

  @override
  String get deleteConfessionContent =>
      'Ta spowiedź i wszystkie jej pozycje zostaną trwale usunięte z twojej historii. Tej operacji nie można cofnąć.';

  @override
  String get tutorialExamineDesc =>
      'Zacznij tutaj, aby zrobić rachunek sumienia przed spowiedzią.';

  @override
  String get tutorialConfessDesc =>
      'Korzystaj z tego podczas spowiedzi, aby śledzić swoje grzechy.';

  @override
  String get tutorialPrayersDesc =>
      'Znajdź modlitwy przed spowiedzią i po niej.';

  @override
  String get tutorialGuideDesc =>
      'Tutaj znajdziesz słowa otuchy, przewodnik po spowiedzi krok po kroku oraz pytania i odpowiedzi.';

  @override
  String get tutorialSettingsDesc =>
      'Tutaj dostosujesz aplikację: zmienisz język i motyw, ustawisz przypomnienia oraz zarządzisz zabezpieczeniami.';

  @override
  String get tutorialSwipeDesc =>
      'Przesuń palcem w lewo lub w prawo, aby przechodzić między przykazaniami.';

  @override
  String get tutorialSelectDesc =>
      'Dotknij dowolnego pytania, aby wybrać je do spowiedzi.';

  @override
  String get tutorialFinishDesc =>
      'Gdy skończysz, dotknij tutaj, aby zakończyć i przejść do spowiedzi.';

  @override
  String get tutorialCounterDesc =>
      'Pokazuje, ile pozycji wybrano do spowiedzi.';

  @override
  String get tutorialMenuDesc =>
      'Stąd masz dostęp do własnych grzechów i możesz wyczyścić swoje wybory.';

  @override
  String get tutorialPenanceDesc =>
      'Tutaj śledź pokutę zadaną przez spowiednika.';

  @override
  String get tutorialInsightsDesc =>
      'Zobacz statystyki i serie na swojej drodze spowiedzi.';

  @override
  String get tutorialHistoryDesc =>
      'Dostęp do twoich dawnych spowiedzi i ich dat.';

  @override
  String get replayTutorial => 'Odtwórz samouczek';

  @override
  String get replayTutorialDesc => 'Obejrzyj samouczek aplikacji ponownie';

  @override
  String get tutorialReset =>
      'Samouczek zresetowany! Przewodniki pojawią się ponownie.';

  @override
  String get about => 'O aplikacji';

  @override
  String get aboutSubtitle => 'Wersja, licencja i kod źródłowy';

  @override
  String get shareApp => 'Udostępnij aplikację';

  @override
  String get shareAppSubtitle => 'Podziel się z przyjaciółmi i rodziną';

  @override
  String get rateApp => 'Oceń aplikację';

  @override
  String get spreadShareTitle => 'Poleć Metanoię';

  @override
  String get spreadShareSubtitle =>
      'Znasz kogoś, kto oddalił się od spowiedzi? Pomóż tej osobie wrócić.';

  @override
  String get spreadShareAction => 'Udostępnij';

  @override
  String get spreadRateSubtitle =>
      'Jeśli Metanoia pomaga ci przygotować się do spowiedzi, ocena pomoże innym ją znaleźć.';

  @override
  String get spreadRateAction => 'Oceń';

  @override
  String get rateGateHint => 'Jak oceniasz swoje wrażenia?';

  @override
  String get rateGateLowest => 'Najniższa';

  @override
  String get rateGateHighest => 'Najwyższa';

  @override
  String get rateGateThanks =>
      'Dziękujemy — Twoja opinia wiele dla nas znaczy.';

  @override
  String rateAppSubtitle(String store) {
    return 'Oceń nas w $store';
  }

  @override
  String get website => 'Strona internetowa';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get madeWithLove => 'Stworzone z ❤️ przez holystack.dev';

  @override
  String get rateDialogTitle => 'Podoba ci się Metanoia?';

  @override
  String get rateDialogContent =>
      'Jeśli ta aplikacja ci pomaga, poświęć chwilę na jej ocenę. To dla nas bardzo wiele znaczy!';

  @override
  String get rateDialogYes => 'Oceń teraz';

  @override
  String get rateDialogNo => 'Nie, dziękuję';

  @override
  String get rateDialogLater => 'Przypomnij mi później';

  @override
  String get greekLabel => 'greka';

  @override
  String get nounLabel => 'rzeczownik';

  @override
  String get metanoiaDefinition =>
      'Głęboka przemiana umysłu i serca; duchowe przebudzenie, które przemienia całego człowieka i zwraca jego życie ku Bogu.';

  @override
  String get turnBackToGrace => 'Powróć do łaski';

  @override
  String get welcomeSubtitle => 'Twój przewodnik ku dobrej spowiedzi';

  @override
  String get discoverInnerGrace => 'Odkryj łaskę w sobie';

  @override
  String get sacredJourneyBegins => 'Zaczyna się święta droga pojednania.';

  @override
  String get beginJourney => 'Rozpocznij drogę';

  @override
  String get getStarted => 'Zaczynajmy';

  @override
  String get chooseContentLanguage => 'Wybierz język treści';

  @override
  String get contentLanguageDescription =>
      'Wybierz język modlitw, rachunku sumienia i przewodników';

  @override
  String get changeAnytimeNote =>
      'Możesz to zmienić w każdej chwili w Ustawieniach';

  @override
  String get continueButton => 'Dalej';

  @override
  String get examineDescription =>
      'Zrób rachunek sumienia w oparciu o Dziesięć Przykazań przed spowiedzią';

  @override
  String get confessDescription =>
      'Śledź swoje grzechy podczas spowiedzi, aby o niczym nie zapomnieć';

  @override
  String get prayersDescription =>
      'Korzystaj z modlitw przed spowiedzią i po niej oraz z modlitw pokutnych';

  @override
  String get remindersDescription =>
      'Ustaw regularne przypomnienia w Ustawieniach, aby nigdy nie zapomnieć o spowiedzi';

  @override
  String get nextButton => 'Dalej';

  @override
  String get customSins => 'Własne grzechy';

  @override
  String get manageCustomSins => 'Zarządzaj własnymi grzechami';

  @override
  String get addCustomSin => 'Dodaj własny grzech';

  @override
  String get editCustomSin => 'Edytuj własny grzech';

  @override
  String get deleteCustomSin => 'Usuń własny grzech';

  @override
  String get sinDescription => 'Opis grzechu';

  @override
  String get sinDescriptionHint => 'Opisz grzech, o którym chcesz pamiętać';

  @override
  String get sinDescriptionRequired => 'Wpisz opis grzechu';

  @override
  String get optionalNote => 'Notatka (opcjonalnie)';

  @override
  String get optionalNoteHint => 'Dodaj dodatkowe szczegóły';

  @override
  String get selectCommandment => 'Wybierz przykazanie (opcjonalnie)';

  @override
  String get noCommandment => 'Ogólne / bez przykazania';

  @override
  String get customSinAdded => 'Dodano własny grzech';

  @override
  String get customSinUpdated => 'Zaktualizowano własny grzech';

  @override
  String get customSinDeleted => 'Usunięto własny grzech';

  @override
  String get deleteCustomSinConfirm =>
      'Czy na pewno chcesz usunąć ten własny grzech?';

  @override
  String get noCustomSins => 'Nie masz jeszcze własnych grzechów';

  @override
  String get noCustomSinsDesc =>
      'Dodaj własne grzechy, aby dostosować swój rachunek sumienia';

  @override
  String get customVersion => 'Własne (edytowane)';

  @override
  String get searchCustomSins => 'Szukaj własnych grzechów...';

  @override
  String get addButton => 'Dodaj';

  @override
  String get updateButton => 'Zaktualizuj';

  @override
  String get deleteButton => 'Usuń';

  @override
  String get addYourOwn => 'Dodaj własny...';

  @override
  String get penance => 'Pokuta';

  @override
  String get penanceTracker => 'Śledzenie pokuty';

  @override
  String get addPenance => 'Dodaj pokutę';

  @override
  String get editPenance => 'Edytuj pokutę';

  @override
  String get penanceDescription => 'Jaką pokutę ci zadano?';

  @override
  String get penanceHint =>
      'np. Odmów 3 Zdrowaś Maryjo, przeczytaj fragment Pisma Świętego...';

  @override
  String get penanceAdded => 'Dodano pokutę';

  @override
  String get penanceUpdated => 'Zaktualizowano pokutę';

  @override
  String get penanceCompleted => 'Pokuta odprawiona! Szczęść Boże.';

  @override
  String get markAsComplete => 'Oznacz jako odprawioną';

  @override
  String get pendingPenances => 'Pokuty do odprawienia';

  @override
  String get noPendingPenances => 'Brak pokut do odprawienia';

  @override
  String get noPendingPenancesDesc =>
      'Wszystkie twoje pokuty są odprawione. Szczęść Boże!';

  @override
  String completedOn(Object date) {
    return 'Odprawiono: $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Zadano: $date';
  }

  @override
  String get skipPenance => 'Pomiń';

  @override
  String get savePenance => 'Zapisz pokutę';

  @override
  String get insights => 'Statystyki';

  @override
  String get confessionInsights => 'Statystyki spowiedzi';

  @override
  String get totalConfessions => 'Wszystkie spowiedzi';

  @override
  String get averageFrequency => 'Średnia częstotliwość';

  @override
  String everyXDays(Object count) {
    return 'Co $count dni';
  }

  @override
  String get daysSinceLastConfession => 'Dni od ostatniej';

  @override
  String get currentStreak => 'Obecna seria';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tygodnia',
      many: '$count tygodni',
      few: '$count tygodnie',
      one: '1 tydzień',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Aktywność miesięczna';

  @override
  String get confessionsThisYear => 'Spowiedzi w tym roku';

  @override
  String get noInsightsYet => 'Brak statystyk';

  @override
  String get noInsightsYetDesc =>
      'Zakończ pierwszą spowiedź, aby zobaczyć statystyki swojej duchowej drogi';

  @override
  String get totalItemsConfessed => 'Wyznanych pozycji łącznie';

  @override
  String get firstConfession => 'Pierwsza spowiedź';

  @override
  String get spiritualJourney => 'Twoja duchowa droga';

  @override
  String get listView => 'Lista';

  @override
  String get guidedView => 'Z przewodnikiem';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current z $total';
  }

  @override
  String get previousCommandment => 'Wstecz';

  @override
  String get nextCommandment => 'Dalej';

  @override
  String get finishExamination => 'Zakończ';

  @override
  String get noQuestionsSelected => 'Nie wybrano pytań w tej sekcji';

  @override
  String questionsSelectedInSection(Object count) {
    return 'Wybrano: $count';
  }

  @override
  String get examinationSummary => 'Podsumowanie rachunku sumienia';

  @override
  String get examinationNote =>
      'Rzetelny rachunek sumienia wykracza poza każdą listę. Rozważ w modlitwie swój stan życia i okoliczności.';

  @override
  String selectedCount(Object count) {
    return 'Wybrano pozycji: $count';
  }

  @override
  String get noSinsSelected => 'Nie wybrano żadnych grzechów';

  @override
  String get continueEditing => 'Edytuj dalej';

  @override
  String get proceedToConfess => 'Przejdź dalej';

  @override
  String get clearDraftTitle => 'Wyczyścić szkic?';

  @override
  String get clearDraftMessage =>
      'Spowoduje to usunięcie wszystkich wybranych pytań. Czy na pewno?';

  @override
  String get clearDraft => 'Wyczyść szkic';

  @override
  String get clear => 'Wyczyść';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Przywrócono $count pozycji z twojej ostatniej sesji',
      many: 'Przywrócono $count pozycji z twojej ostatniej sesji',
      few: 'Przywrócono $count pozycje z twojej ostatniej sesji',
      one: 'Przywrócono 1 pozycję z twojej ostatniej sesji',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Przed chwilą';

  @override
  String minutesAgo(Object count) {
    return '$count min temu';
  }

  @override
  String hoursAgo(Object count) {
    return '$count godz. temu';
  }

  @override
  String get general => 'Ogólne';

  @override
  String get noQuestionsInSection => 'Brak pytań w tej sekcji';

  @override
  String get skip => 'Pomiń';

  @override
  String get back => 'Wstecz';

  @override
  String get skipOnboardingTitle => 'Pominąć wprowadzenie?';

  @override
  String get skipOnboardingMessage =>
      'Przejdziesz od razu do ostatniej strony. Nic tu nie jest ustawiane — wszystko możesz później zmienić w Ustawieniach.';

  @override
  String get confessionHistoryTitle => 'Historia spowiedzi';

  @override
  String get deleteAll => 'Usuń wszystko';

  @override
  String get editDate => 'Edytuj datę';

  @override
  String get confessionDate => 'Data spowiedzi';

  @override
  String get dateUpdated => 'Data zaktualizowana';

  @override
  String get changeDateConfirmTitle => 'Zmienić datę?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Zmienić datę spowiedzi na $date?';
  }

  @override
  String get noGuideContent => 'Brak dostępnej treści przewodnika';

  @override
  String get noGuideContentDesc => 'Treść przewodnika pojawi się tutaj';

  @override
  String get noFaqContent => 'Brak pytań i odpowiedzi';

  @override
  String get noFaqContentDesc =>
      'Najczęściej zadawane pytania pojawią się tutaj';

  @override
  String get faqSubtitle => 'Przewodnik po sakramencie pokuty i pojednania';

  @override
  String get tapToExpand => 'Dotknij, aby przeczytać więcej';

  @override
  String get continueExamination => 'Kontynuuj rachunek sumienia';

  @override
  String get continueExaminationDesc => 'Masz rozpoczęty rachunek sumienia';

  @override
  String examinationProgress(Object count) {
    return 'Wybrano pozycji: $count';
  }

  @override
  String get security => 'Zabezpieczenia';

  @override
  String get securitySubtitle => 'Chroń swoje dane osobiste';

  @override
  String get pinAndBiometric => 'PIN i biometria';

  @override
  String get pinAndBiometricSubtitle =>
      'Skonfiguruj ustawienia blokady aplikacji';

  @override
  String get enterPin => 'Wpisz PIN';

  @override
  String get createPin => 'Utwórz PIN';

  @override
  String get confirmPin => 'Potwierdź PIN';

  @override
  String get incorrectPin => 'Nieprawidłowy PIN';

  @override
  String get pinMismatch => 'Kody PIN nie są zgodne';

  @override
  String get biometricUnlock => 'Odblokowanie biometryczne';

  @override
  String get autoLockTimeout => 'Czas do automatycznej blokady';

  @override
  String get tooManyAttempts => 'Zbyt wiele nieudanych prób';

  @override
  String tryAgainIn(Object time) {
    return 'Spróbuj ponownie za $time';
  }

  @override
  String get useBiometricUnlock => 'Używaj odblokowania biometrycznego';

  @override
  String get unlockWithFingerprintOrFace =>
      'Odblokuj odciskiem palca lub twarzą';

  @override
  String get biometricAccessWarning =>
      'Każdy, kto ma zarejestrowany na tym urządzeniu odcisk palca lub twarz, będzie mógł uzyskać dostęp do aplikacji';

  @override
  String get lockAfter => 'Blokuj po';

  @override
  String get timeInBackgroundBeforeLocking => 'Czas w tle przed zablokowaniem';

  @override
  String get changePin => 'Zmień PIN';

  @override
  String get updateYourSecurityPin => 'Zaktualizuj swój PIN zabezpieczający';

  @override
  String get enterCurrentPin => 'Wpisz obecny PIN';

  @override
  String get enterNewPin => 'Wpisz nowy PIN';

  @override
  String get confirmNewPin => 'Potwierdź nowy PIN';

  @override
  String get pinChangedSuccessfully => 'PIN został zmieniony';

  @override
  String get currentPinIncorrect => 'Obecny PIN jest nieprawidłowy';

  @override
  String get enableBiometricUnlock => 'Włączyć odblokowanie biometryczne?';

  @override
  String get biometricDescription =>
      'Używaj odcisku palca lub twarzy, aby szybko i bezpiecznie odblokowywać aplikację.';

  @override
  String get notNow => 'Nie teraz';

  @override
  String get enable => 'Włącz';

  @override
  String get setUpPin => 'Ustaw PIN';

  @override
  String get createSixDigitPin => 'Utwórz 6-cyfrowy PIN';

  @override
  String get pinProtectData => 'Ten PIN będzie chronić twoje dane';

  @override
  String get confirmYourPin => 'Potwierdź swój PIN';

  @override
  String get enterSamePinAgain => 'Wpisz ten sam PIN ponownie, aby potwierdzić';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Wpisz PIN, aby odblokować';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pozostało $count próby',
      many: 'Pozostało $count prób',
      few: 'Pozostały $count próby',
      one: 'Pozostała 1 próba',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sekundy',
      many: '$count sekund',
      few: '$count sekundy',
      one: '1 sekunda',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuty',
      many: '$count minut',
      few: '$count minuty',
      one: '1 minuta',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Cofnij';

  @override
  String get confessionDeleted => 'Spowiedź usunięta';

  @override
  String get noConfessionHistory => 'Brak historii spowiedzi';

  @override
  String get noConfessionHistoryDesc =>
      'Zakończone spowiedzi pojawią się tutaj';

  @override
  String get fontSize => 'Rozmiar czcionki';

  @override
  String get fontSizeSubtitle =>
      'Dostosuj rozmiar tekstu dla lepszej czytelności';

  @override
  String get fontSizeSmall => 'Mały';

  @override
  String get fontSizeMedium => 'Średni';

  @override
  String get fontSizeLarge => 'Duży';

  @override
  String get fontSizeExtraLarge => 'Bardzo duży';

  @override
  String get forgotPin => 'Nie pamiętasz PIN-u?';

  @override
  String get resetPinTitle => 'Zresetuj PIN';

  @override
  String get resetPinWarning =>
      'Uwaga: spowoduje to trwałe usunięcie wszystkich twoich danych';

  @override
  String get resetPinDescription =>
      'Jeśli zresetujesz PIN, wszystkie twoje spowiedzi, własne grzechy, pokuty i inne dane osobiste zostaną trwale usunięte. Tej operacji nie można cofnąć.';

  @override
  String get resetPinConfirmation => 'Wpisz USUŃ, aby potwierdzić';

  @override
  String get resetPinButton => 'Zresetuj PIN i usuń dane';

  @override
  String get resetPinSuccess => 'PIN został zresetowany. Ustaw teraz nowy PIN.';

  @override
  String get resetPinError =>
      'Nie udało się zresetować PIN-u. Spróbuj ponownie.';

  @override
  String get deleteConfirmationText => 'USUŃ';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Poczekaj $seconds s';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Potwierdź swoją tożsamość, aby zresetować PIN';

  @override
  String get confessionGuideTitle => 'Jak dobrze się wyspowiadać';

  @override
  String get shortFilmTitle => 'Spowiedź: krótki film';

  @override
  String get shortFilmSubtitle =>
      'Autorstwa Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Wielka Brytania';

  @override
  String get confessionGuideSubtitle =>
      'Przewodnik krok po kroku po sakramencie';

  @override
  String get invitationTitle => 'Wracasz do spowiedzi?';

  @override
  String get invitationSubtitle => 'Słowo zachęty dla ciebie';

  @override
  String get invitationDialogTitle => 'Witaj';

  @override
  String get invitationDialogContent =>
      'Czy to twoja pierwsza spowiedź od dłuższego czasu albo czy czujesz niepokój przed pójściem?';

  @override
  String get invitationDialogYes => 'Tak, potrzebuję słowa zachęty';

  @override
  String get invitationDialogNo => 'Nie, mogę zacząć';

  @override
  String get invitationDialogDontShowAgain => 'Nie pokazuj tego ponownie';

  @override
  String get searchPrayers => 'Szukaj modlitw...';

  @override
  String get allCategories => 'Wszystkie';

  @override
  String get appDisclaimer =>
      'Ta aplikacja jest duchową pomocą w przygotowaniu do spowiedzi. Nie zastępuje sakramentu pokuty i pojednania sprawowanego przez kapłana.';

  @override
  String get onboardingDisclaimer =>
      'Duchowa pomoc w przygotowaniu do spowiedzi — nie jej zamiennik.';

  @override
  String get readyToBegin => 'Wszystko gotowe';

  @override
  String get readyToBeginSubtitle =>
      'Niech twoja droga ku pojednaniu będzie pełna łaski i pokoju.';

  @override
  String get onboardingOverviewTitle => 'Co robi ta aplikacja';

  @override
  String get onboardingOverviewExamine =>
      'Przygotuj swoje sumienie we własnym tempie.';

  @override
  String get onboardingOverviewConfess =>
      'Dyskretna lista, aby o niczym nie zapomnieć.';

  @override
  String get onboardingOverviewJournal =>
      'Krótka wieczorna refleksja, by wzrastać między spowiedziami.';

  @override
  String get onboardingOverviewFootnote =>
      'W środku znajdziesz modlitwy, przewodniki i opcjonalne przypomnienia.';

  @override
  String get onboardingPrivacyTitle => 'Prywatna z założenia';

  @override
  String get onboardingPrivacyLocal =>
      'Wszystko zostaje na tym telefonie. Bez konta, bez chmury.';

  @override
  String get onboardingPrivacyEncrypted => 'Zaszyfrowane na twoim urządzeniu.';

  @override
  String get onboardingPrivacyPin =>
      'Kod PIN utworzysz przy pierwszym otwarciu rachunku sumienia lub dziennika.';

  @override
  String get sourceCode => 'Kod źródłowy';

  @override
  String get contentReferences => 'Źródła treści';

  @override
  String get examinationModeTitle => 'Jak chcesz zrobić rachunek sumienia?';

  @override
  String get quickReviewMode => 'Szybki przegląd';

  @override
  String get quickReviewDescription =>
      'Przejrzyj wszystkie pytania według kategorii';

  @override
  String get deepReflectionMode => 'Głęboka refleksja';

  @override
  String get deepReflectionDescription =>
      'Po jednym pytaniu, dla uważnego rachunku sumienia';

  @override
  String get contemplativePrayerTitle => 'Przyjdź, Duchu Święty';

  @override
  String get contemplativePrayerText =>
      'Napełnij moje serce i rozpal we mnie ogień Twojej miłości. Oświeć mój umysł, aby moje grzechy stały się dla mnie jasne.';

  @override
  String get imReady => 'Zaczynam';

  @override
  String get skipPrayer => 'Pomiń';

  @override
  String get yesThisApplies => 'Tak';

  @override
  String get noThisDoesnt => 'Nie';

  @override
  String get skipQuestion => 'Pomiń';

  @override
  String questionProgress(int current, int total) {
    return '$current z $total';
  }

  @override
  String get examinationComplete => 'Rachunek sumienia zakończony';

  @override
  String get reviewYourSelections => 'Przejrzyj swoje wybory';

  @override
  String get examinationModeSettingTitle => 'Tryb rachunku sumienia';

  @override
  String get examinationModeSettingSubtitle =>
      'Wybierz, jak chcesz robić rachunek sumienia';

  @override
  String get askEveryTime => 'Pytaj za każdym razem';

  @override
  String get reminderNotificationTitle => 'Czas na spowiedź';

  @override
  String get reminderNotificationBody =>
      'Pamiętaj o rachunku sumienia i przygotowaniu do spowiedzi';

  @override
  String get notificationPermissionDenied =>
      'Powiadomienia są wyłączone. Zezwól na powiadomienia dla aplikacji Metanoia w ustawieniach urządzenia, aby otrzymywać przypomnienia o spowiedzi.';

  @override
  String get openSourceLicenses => 'Licencje open source';

  @override
  String get couldNotOpenLink => 'Nie udało się otworzyć linku';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wyznanych pozycji',
      many: '$count wyznanych pozycji',
      few: '$count wyznane pozycje',
      one: '1 wyznana pozycja',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pokuty',
      many: '$count pokut',
      few: '$count pokuty',
      one: '1 pokuta',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oczekujących',
      many: '$count oczekujących',
      few: '$count oczekujące',
      one: '1 oczekująca',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'łącznie $count',
      many: 'łącznie $count',
      few: 'łącznie $count',
      one: 'łącznie 1',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pozycji',
      many: '$count pozycji',
      few: '$count pozycje',
      one: '1 pozycja',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia',
      many: '$count dni',
      few: '$count dni',
      one: '1 dzień',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tyg.',
      many: '$count tyg.',
      few: '$count tyg.',
      one: '1 tyg.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Usunąć wszystkie spowiedzi?';

  @override
  String get deleteAllConfessionsContent =>
      'Spowoduje to trwałe usunięcie całej historii twoich spowiedzi. Tej operacji nie można cofnąć.';

  @override
  String get allConfessionsDeleted => 'Usunięto wszystkie spowiedzi';

  @override
  String get deletePenanceConfirm => 'Czy na pewno chcesz usunąć tę pokutę?';

  @override
  String get completed => 'Wypełniona';

  @override
  String get tapToCollapse => 'Dotknij, aby zwinąć';

  @override
  String get dismiss => 'Zamknij';

  @override
  String showcaseStep(int current, int total) {
    return 'Krok $current z $total';
  }

  @override
  String get done => 'Gotowe';

  @override
  String get navigate => 'Przejdź';

  @override
  String get encouragement => 'Zachęta';

  @override
  String get biometricPromptReason =>
      'Uwierzytelnij się, aby uzyskać dostęp do aplikacji Metanoia';

  @override
  String get tryAgainInLabel => 'Spróbuj ponownie za';

  @override
  String get errorLoadingLanguage => 'Błąd wczytywania języka';

  @override
  String get detailsNotSaved => 'Szczegóły nie zostały zapisane';

  @override
  String get discardStoredSinsTitle => 'Odrzucić zapisane grzechy?';

  @override
  String get discardStoredSinsContent =>
      'Historia spowiedzi jest teraz wyłączona. Grzechy zapisane z wcześniejszych spowiedzi są nadal przechowywane. Odrzucić je? Daty zostaną zachowane, więc twoje statystyki i serie pozostaną nienaruszone.';

  @override
  String get keepThem => 'Zachowaj';

  @override
  String get discard => 'Odrzuć';

  @override
  String get storedSinsDiscarded =>
      'Zapisane grzechy zostały odrzucone. Daty spowiedzi zachowano.';

  @override
  String get journalTitle => 'Dziennik';

  @override
  String get journalHomeCardTitle => 'Wieczorna refleksja';

  @override
  String get journalHomeCardSubtitle => 'Jak minął dzisiejszy dzień?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dnia',
      many: '$count dni',
      few: '$count dni',
      one: '$count dzień',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Dni refleksji z rzędu';

  @override
  String get journalContinueToday => 'Kontynuuj dzisiejszy wpis';

  @override
  String get journalPreviousMonth => 'Poprzedni miesiąc';

  @override
  String get journalNextMonth => 'Następny miesiąc';

  @override
  String get journalGratitudeTitle => 'Wdzięczność';

  @override
  String get journalGratitudePrompt => 'Gdzie dziś widzę Boga?';

  @override
  String get journalGratitudeHint => 'Łaska, za którą chcę Mu podziękować…';

  @override
  String get journalPresenceLead =>
      'Bóg jest tu z tobą. Wycisz się przed Nim i dziękuj.';

  @override
  String get journalPresenceVerse =>
      'Zatrzymajcie się i wiedzcie, że Ja jestem Bogiem.';

  @override
  String get journalPresenceRef => 'Ps 46,11';

  @override
  String get journalLightTitle => 'Proś o światło';

  @override
  String get journalLightLead =>
      'Proś Ducha Świętego o światło, aby zobaczyć swój dzień tak, jak widzi go Bóg.';

  @override
  String get journalLightVerse =>
      'Przyjdź, Duchu Święty, napełnij serca swoich wiernych i zapal w nich ogień swojej miłości.';

  @override
  String get journalReviewTitle => 'Przejrzyj dzień z Bogiem';

  @override
  String get journalReviewLead =>
      'Przejdź na nowo swój dzień z Panem: gdzie miłość przyszła do ciebie, gdzie od ciebie wyszła, a gdzie twoje serce się od niej odwróciło.';

  @override
  String get journalReviewVerse =>
      'Wybadaj mnie, Boże, i poznaj me serce; doświadcz mnie i poznaj moje troski, i zobacz, czy nie podążam drogą nieprawości, a prowadź mnie drogą odwieczną!';

  @override
  String get journalReviewRef => 'Ps 139,23-24';

  @override
  String get journalReviewHint => 'Opowiedz Mu o swoim dniu…';

  @override
  String get journalReviewBringSin => 'Czy jest coś, co chcesz Mu przynieść?';

  @override
  String get journalContritionTitle => 'Żal za grzechy';

  @override
  String get journalContritionLead =>
      'Zanieś Ojcu to, co odnajdujesz w sobie; On biegnie ci na spotkanie.';

  @override
  String get journalContritionVerse =>
      'Zmiłuj się nade mną, Boże, w swojej łaskawości, w ogromie swego miłosierdzia wymaż moją nieprawość!';

  @override
  String get journalContritionRef => 'Ps 51,3';

  @override
  String get journalContritionPray => 'Odmów akt żalu';

  @override
  String get journalContritionMercy =>
      'Żal, który rodzi się z miłości do Boga, wraz z postanowieniem spowiedzi, otwiera dziś wieczorem twoje serce na Jego miłosierdzie; a jego pełnia czeka na ciebie w spowiedzi, w słowach rozgrzeszenia.';

  @override
  String get journalResolutionLead =>
      'Spocznij w Jego miłosierdziu. Jutro na nowo zaczyna się w Nim.';

  @override
  String get journalResolutionVerse =>
      'Nie wyczerpała się litość Pana, miłość nie zgasła. Odnawia się ona co rano; ogromna jest Twa wierność.';

  @override
  String get journalResolutionRef => 'Lm 3,22-23';

  @override
  String get journalReflectionTitle => 'Refleksja';

  @override
  String get journalReflectionPrompt => 'Jak minął twój dzień?';

  @override
  String get journalReflectionHint => 'Pisz swobodnie...';

  @override
  String get journalSinsTitle => 'Zaznacz grzechy';

  @override
  String get journalSinsPrompt => 'W czym dziś zawodzę?';

  @override
  String get journalNoSinsMarked => 'Nic jeszcze nie zaznaczono';

  @override
  String get journalAddSin => 'Zaznacz grzech';

  @override
  String get journalRemoveSin => 'Usuń';

  @override
  String get journalResolutionTitle => 'Nadzieja i postanowienie';

  @override
  String get journalResolutionPrompt => 'Jeden dar na jutro';

  @override
  String get journalResolutionHint => 'Z Twoją łaską jutro będę…';

  @override
  String get journalMoodTitle => 'Nastrój';

  @override
  String get journalMoodPrompt => 'Jak się dziś miewa twoja dusza?';

  @override
  String get journalMoodDesolate => 'Strapienie';

  @override
  String get journalMoodStruggling => 'Zmaganie';

  @override
  String get journalMoodSteady => 'Spokój';

  @override
  String get journalMoodGrateful => 'Wdzięczność';

  @override
  String get journalMoodConsoled => 'Pocieszenie';

  @override
  String get journalSaved => 'Zapisano';

  @override
  String get journalSaving => 'Zapisywanie...';

  @override
  String get journalDeleteEntry => 'Usuń wpis';

  @override
  String get journalDeleteEntryConfirm =>
      'Usunąć wpis z tego dnia? Tej operacji nie można cofnąć.';

  @override
  String get journalEntryDeleted => 'Wpis usunięty';

  @override
  String get journalPickerQuestions => 'Pytania';

  @override
  String get journalPickerMySins => 'Moje grzechy';

  @override
  String get journalPickerOwnWords => 'Własnymi słowami';

  @override
  String get journalPickerFreeTextHint => 'Opisz to własnymi słowami';

  @override
  String get journalSearchSins => 'Szukaj grzechów...';

  @override
  String get journalAbsolved => 'Wyznany';

  @override
  String get journalSinCleared => 'Grzech zaniesiony do spowiedzi';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dołącz $count grzechu zaznaczonego w dzienniku',
      many: 'Dołącz $count grzechów zaznaczonych w dzienniku',
      few: 'Dołącz $count grzechy zaznaczone w dzienniku',
      one: 'Dołącz grzech zaznaczony w dzienniku',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Dołącz';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dodano $count grzechu z dziennika',
      many: 'Dodano $count grzechów z dziennika',
      few: 'Dodano $count grzechy z dziennika',
      one: 'Dodano 1 grzech z dziennika',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Obszary zmagań';

  @override
  String get journalStruggleAreasSubtitle =>
      'Najczęściej zaznaczane w dzienniku';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zaznaczenia',
      many: '$count zaznaczeń',
      few: '$count zaznaczenia',
      one: '1 zaznaczenie',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Przypomnienie o dzienniku';

  @override
  String get journalReminderSubtitle =>
      'Wieczorne przypomnienie o refleksji nad minionym dniem';

  @override
  String get enableJournalReminder => 'Włącz przypomnienie o dzienniku';

  @override
  String get journalReminderNotificationTitle => 'Wieczorna refleksja';

  @override
  String get journalReminderNotificationBody =>
      'Poświęć chwilę, by spojrzeć na swój dzień razem z Bogiem';

  @override
  String get confessionDayMode => 'Tryb spowiedzi';

  @override
  String get confessionDayModeDescription =>
      'Duży, wolny od rozproszeń tekst do konfesjonału';

  @override
  String get exitConfessionMode => 'Zakończ tryb spowiedzi';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Krok $current z $total';
  }

  @override
  String get next => 'Dalej';

  @override
  String get actOfContrition => 'Akt żalu';

  @override
  String get actOfContritionUnavailable => 'Akt żalu jest niedostępny';

  @override
  String get confessionDaySinsTitle => 'Grzechy do wyznania';

  @override
  String get confessionDayOpeningTitle => 'Rozpoczęcie';

  @override
  String get confessionDayOpeningIntro =>
      'Uczyń znak krzyża, a następnie zacznij:';

  @override
  String get confessionDayOpeningFormula =>
      'Niech będzie pochwalony Jezus Chrystus.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Moja ostatnia spowiedź była $duration temu.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Ostatni raz u spowiedzi świętej byłem [dni/tygodni/miesięcy/lat] temu.';

  @override
  String get confessionDaySinsClosing =>
      'Więcej grzechów nie pamiętam, za wszystkie serdecznie żałuję, obiecuję poprawę i proszę o pokutę i rozgrzeszenie.';

  @override
  String get confessionDayThanksgivingTitle => 'Idź w pokoju';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Wysławiajmy Pana, bo jest dobry.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Bo Jego miłosierdzie trwa na wieki.';

  @override
  String get confessionDayThanksgivingBody =>
      'Twoja dusza została obmyta. Wypełnij swoją pokutę i idź naprzód w pokoju Chrystusa.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tygodnia',
      many: '$count tygodni',
      few: '$count tygodnie',
      one: '1 tydzień',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miesiąca',
      many: '$count miesięcy',
      few: '$count miesiące',
      one: '1 miesiąc',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count roku',
      many: '$count lat',
      few: '$count lata',
      one: '1 rok',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Wielki Post';

  @override
  String get seasonHolyWeek => 'Wielki Tydzień';

  @override
  String get seasonAdvent => 'Adwent';

  @override
  String get seasonChristmas => 'Boże Narodzenie';

  @override
  String get seasonEaster => 'Wielkanoc';

  @override
  String get seasonOrdinaryTime => 'Okres zwykły';

  @override
  String get feastAshWednesday => 'Środa Popielcowa';

  @override
  String get feastPalmSunday => 'Niedziela Palmowa';

  @override
  String get feastEaster => 'Wielkanoc';

  @override
  String get feastPentecost => 'Zesłanie Ducha Świętego';

  @override
  String get feastAssumption => 'Wniebowzięcie Najświętszej Maryi Panny';

  @override
  String get feastAllSaints => 'Wszystkich Świętych';

  @override
  String get feastImmaculateConception => 'Niepokalane Poczęcie';

  @override
  String get feastFirstSundayOfAdvent => 'Pierwsza Niedziela Adwentu';

  @override
  String get feastChristmas => 'Boże Narodzenie';

  @override
  String get liturgicalLentTitle => 'Rozpoczął się Wielki Post';

  @override
  String get liturgicalLentBody =>
      'Czas powrotu. Wielu rozpoczyna go od spowiedzi.';

  @override
  String get liturgicalHolyWeekTitle => 'Rozpoczął się Wielki Tydzień';

  @override
  String get liturgicalHolyWeekBody =>
      'Kościół zmierza ku Wielkanocy. Wciąż jest czas, by przygotować swoje serce.';

  @override
  String get liturgicalAdventTitle => 'Rozpoczął się Adwent';

  @override
  String get liturgicalAdventBody =>
      'Czas oczekiwania. Wielu przygotowuje swoje serce przez spowiedź.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return 'Zbliża się $feast';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zostało $count dnia — przygotuj swoje serce.',
      many: 'Zostało $count dni — przygotuj swoje serce.',
      few: 'Zostały $count dni — przygotuj swoje serce.',
      one: 'Został jeden dzień — przygotuj swoje serce.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Minęło $count tygodnia od twojej ostatniej spowiedzi',
      many: 'Minęło $count tygodni od twojej ostatniej spowiedzi',
      few: 'Minęły $count tygodnie od twojej ostatniej spowiedzi',
      one: 'Minął tydzień od twojej ostatniej spowiedzi',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Gdy tylko zechcesz, miłosierdzie czeka. Chcesz się przygotować?';

  @override
  String get promptPrepare => 'Przygotuj się';

  @override
  String get dataUnrecoverableTitle => 'Nie można odblokować twoich danych';

  @override
  String get dataUnrecoverableBody =>
      'Klucz chroniący twoje spowiedzi nie jest już dostępny na tym urządzeniu. Może się tak zdarzyć po przywróceniu danych z kopii zapasowej lub po zresetowaniu ustawień zabezpieczeń urządzenia.\n\nPonieważ twoje dane są zaszyfrowane, bez tego klucza nie można ich odzyskać — nie możemy tego zrobić nawet my. Możesz je usunąć i zacząć od nowa.';

  @override
  String get eraseAndStartOver => 'Usuń dane i zacznij od nowa';

  @override
  String get eraseAndStartOverConfirm =>
      'To trwale usunie wszystko, co zapisano na tym urządzeniu, i uruchomi aplikację od nowa. Tej operacji nie można cofnąć.';

  @override
  String get penanceSaveFailed =>
      'Nie udało się zapisać pokuty. Spróbuj ponownie.';

  @override
  String get confessionReminderChannelName => 'Przypomnienia o spowiedzi';

  @override
  String get confessionReminderChannelDescription =>
      'Przypomnienia o spowiedzi';

  @override
  String get journalReminderChannelName => 'Przypomnienia o dzienniku';

  @override
  String get journalReminderChannelDescription =>
      'Codzienne przypomnienie o zapisaniu wieczornej refleksji';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Jak dotąd nazwano $count grzechu',
      many: 'Jak dotąd nazwano $count grzechów',
      few: 'Jak dotąd nazwano $count grzechy',
      one: 'Jak dotąd nazwano 1 grzech',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Zanim zaczniesz';

  @override
  String get invitationCardAction => 'Dodaj mi otuchy';

  @override
  String get homeCtaBeginTitle => 'Rozpocznij rachunek sumienia';

  @override
  String get homeCtaBeginSubtitle => 'Przygotuj swoje serce przed spowiedzią';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Kontynuuj rachunek sumienia ($count wybranego)',
      many: 'Kontynuuj rachunek sumienia ($count wybranych)',
      few: 'Kontynuuj rachunek sumienia ($count wybrane)',
      one: 'Kontynuuj rachunek sumienia (1 wybrany)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Wróć do przerwanego rachunku sumienia';

  @override
  String get homeCtaReadyTitle => 'Wszystko gotowe';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count grzechu czeka na twojej liście do spowiedzi',
      many: '$count grzechów czeka na twojej liście do spowiedzi',
      few: '$count grzechy czekają na twojej liście do spowiedzi',
      one: '1 grzech czeka na twojej liście do spowiedzi',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Wypełnij swoją pokutę';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pokuty wciąż czeka',
      many: '$count pokut wciąż czeka',
      few: '$count pokuty wciąż czekają',
      one: '1 pokuta wciąż czeka',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Słowa otuchy, przewodnik krok po kroku, modlitwy i najczęstsze pytania';

  @override
  String get homeQuoteReadMore => 'Czytaj więcej';

  @override
  String get homeQuoteShowLess => 'Pokaż mniej';

  @override
  String get tutorialJournalDesc =>
      'Spójrz na swój dzień każdego wieczoru: krótka refleksja i seria kolejnych dni.';
}
