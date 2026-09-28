// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Inizio';

  @override
  String get examineTitle => 'Esamina';

  @override
  String get confessTitle => 'Confessa';

  @override
  String get prayersTitle => 'Preghiere';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get examinationTitle => 'Esame di coscienza';

  @override
  String get commandment => 'Comandamento';

  @override
  String get guideTitle => 'Guida';

  @override
  String get faqTitle => 'Capire la confessione';

  @override
  String get language => 'Lingua';

  @override
  String get chooseLanguage => 'Scegli la lingua che preferisci';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Scegli il tema che preferisci';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get reminders => 'Promemoria';

  @override
  String get getReminded => 'Ricevi un promemoria per andare a confessarti';

  @override
  String get enableReminders => 'Attiva i promemoria';

  @override
  String get weekly => 'Settimanale';

  @override
  String get biweekly => 'Ogni due settimane';

  @override
  String get monthly => 'Mensile';

  @override
  String get quarterly => 'Trimestrale';

  @override
  String get day => 'Giorno';

  @override
  String get time => 'Ora';

  @override
  String get remindMe => 'Ricordamelo';

  @override
  String get onTheDay => 'Il giorno stesso';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni prima',
      one: '1 giorno prima',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Azioni rapide';

  @override
  String get lastConfession => 'Ultima confessione';

  @override
  String get noneYet => 'Nessuna ancora';

  @override
  String get today => 'Oggi';

  @override
  String get yesterday => 'Ieri';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni fa',
      one: '1 giorno fa',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Prossimo promemoria';

  @override
  String get off => 'Disattivato';

  @override
  String get mon => 'Lun';

  @override
  String get tue => 'Mar';

  @override
  String get wed => 'Mer';

  @override
  String get thu => 'Gio';

  @override
  String get fri => 'Ven';

  @override
  String get sat => 'Sab';

  @override
  String get sun => 'Dom';

  @override
  String get monday => 'Lunedì';

  @override
  String get tuesday => 'Martedì';

  @override
  String get wednesday => 'Mercoledì';

  @override
  String get thursday => 'Giovedì';

  @override
  String get friday => 'Venerdì';

  @override
  String get saturday => 'Sabato';

  @override
  String get sunday => 'Domenica';

  @override
  String get appLanguage => 'Lingua dell\'app';

  @override
  String get appLanguageSubtitle => 'Lingua di pulsanti, etichette e menu';

  @override
  String get contentLanguage => 'Lingua dei contenuti';

  @override
  String get contentLanguageSubtitle =>
      'Lingua delle domande dell\'esame, delle FAQ e delle preghiere';

  @override
  String get version => 'Versione';

  @override
  String get selectDay => 'Scegli il giorno';

  @override
  String selected(num count) {
    return '$count selezionati';
  }

  @override
  String get selectedLabel => 'selezionati';

  @override
  String get counter => 'Contatore';

  @override
  String get searchPlaceholder => 'Cerca comandamenti o domande...';

  @override
  String get noResults => 'Nessun risultato';

  @override
  String get viewHistory => 'Vedi lo storico';

  @override
  String get noActiveConfession => 'Nessuna confessione in corso';

  @override
  String get startExaminationPrompt =>
      'Inizia un esame di coscienza per aggiungere qui i tuoi peccati.';

  @override
  String get startExamination => 'Inizia l\'esame';

  @override
  String get finishConfessionTitle => 'Concludere la confessione?';

  @override
  String get finishConfessionContent =>
      'La confessione sarà contrassegnata come completata e spostata nel tuo storico.';

  @override
  String get cancel => 'Annulla';

  @override
  String get finish => 'Concludi';

  @override
  String get confessionCompletedMessage =>
      'Confessione completata! Dio ti benedica.';

  @override
  String get finishConfession => 'Concludi la confessione';

  @override
  String get error => 'Errore';

  @override
  String get retry => 'Riprova';

  @override
  String get dailyQuoteError =>
      'Non è stato possibile caricare la citazione di oggi.';

  @override
  String get keepHistory => 'Conserva lo storico delle confessioni';

  @override
  String get keepHistorySubtitle =>
      'Salva i tuoi peccati insieme alla data. Se disattivato, sarà salvata solo la data.';

  @override
  String get deleteConfession => 'Elimina la confessione';

  @override
  String get deleteConfessionContent =>
      'Questa confessione e tutti i suoi elementi saranno eliminati definitivamente dal tuo storico. L\'azione non può essere annullata.';

  @override
  String get tutorialExamineDesc =>
      'Inizia da qui per esaminare la tua coscienza prima della confessione.';

  @override
  String get tutorialConfessDesc =>
      'Usa questa sezione durante la confessione per tenere traccia dei tuoi peccati.';

  @override
  String get tutorialPrayersDesc =>
      'Qui trovi le preghiere più comuni per prima e dopo la confessione.';

  @override
  String get tutorialGuideDesc =>
      'Qui trovi incoraggiamento, una guida passo passo alla confessione e le domande frequenti.';

  @override
  String get tutorialSettingsDesc =>
      'Personalizza qui la tua esperienza: cambia lingua e tema, imposta i promemoria e gestisci la sicurezza.';

  @override
  String get tutorialSwipeDesc =>
      'Scorri a destra o a sinistra per passare da un comandamento all\'altro.';

  @override
  String get tutorialSelectDesc =>
      'Tocca una domanda per selezionarla per la tua confessione.';

  @override
  String get tutorialFinishDesc =>
      'Quando hai finito, tocca qui per concludere e passare alla confessione.';

  @override
  String get tutorialCounterDesc =>
      'Mostra quanti elementi hai selezionato per la confessione.';

  @override
  String get tutorialMenuDesc =>
      'Da qui puoi accedere ai peccati personalizzati e azzerare le selezioni.';

  @override
  String get tutorialPenanceDesc =>
      'Qui puoi tenere traccia delle penitenze assegnate dal confessore.';

  @override
  String get tutorialInsightsDesc =>
      'Guarda le statistiche e la costanza del tuo cammino di confessione.';

  @override
  String get tutorialHistoryDesc =>
      'Accedi alle tue confessioni passate e alle loro date.';

  @override
  String get replayTutorial => 'Rivedi il tutorial';

  @override
  String get replayTutorialDesc => 'Guarda di nuovo il tutorial dell\'app';

  @override
  String get tutorialReset => 'Tutorial reimpostato! Rivedrai le guide.';

  @override
  String get about => 'Informazioni';

  @override
  String get aboutSubtitle => 'Versione, licenza e codice sorgente';

  @override
  String get shareApp => 'Condividi l\'app';

  @override
  String get shareAppSubtitle => 'Condividi con amici e familiari';

  @override
  String get rateApp => 'Valuta l\'app';

  @override
  String get spreadShareTitle => 'Condividi Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Conosci qualcuno lontano dalla confessione? Aiuta questa persona a ritrovare la strada.';

  @override
  String get spreadShareAction => 'Condividi';

  @override
  String get spreadRateSubtitle =>
      'Se Metanoia ti aiuta a prepararti alla confessione, una valutazione aiuta gli altri a scoprirla.';

  @override
  String get spreadRateAction => 'Valuta';

  @override
  String get rateGateHint => 'Come valuti la tua esperienza?';

  @override
  String get rateGateLowest => 'Più bassa';

  @override
  String get rateGateHighest => 'Più alta';

  @override
  String get rateGateThanks =>
      'Grazie — il tuo parere significa molto per noi.';

  @override
  String rateAppSubtitle(String store) {
    return 'Valutaci su $store';
  }

  @override
  String get website => 'Sito web';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get madeWithLove => 'Creato con ❤️ da holystack.dev';

  @override
  String get rateDialogTitle => 'Ti piace Metanoia?';

  @override
  String get rateDialogContent =>
      'Se questa app ti è utile, dedica un momento a valutarla. Per noi è un grande aiuto!';

  @override
  String get rateDialogYes => 'Valuta ora';

  @override
  String get rateDialogNo => 'No, grazie';

  @override
  String get rateDialogLater => 'Ricordamelo più tardi';

  @override
  String get greekLabel => 'Greco';

  @override
  String get nounLabel => 'sostantivo';

  @override
  String get metanoiaDefinition =>
      'Un profondo cambiamento della mente e del cuore; un risveglio spirituale che trasforma tutto l\'essere e riorienta la vita verso Dio.';

  @override
  String get turnBackToGrace => 'Torna alla grazia';

  @override
  String get welcomeSubtitle => 'La tua guida per una buona confessione';

  @override
  String get discoverInnerGrace => 'Scopri la grazia interiore';

  @override
  String get sacredJourneyBegins =>
      'Inizia un cammino sacro di riconciliazione.';

  @override
  String get beginJourney => 'Inizia il cammino';

  @override
  String get getStarted => 'Inizia';

  @override
  String get chooseContentLanguage => 'Scegli la lingua dei contenuti';

  @override
  String get contentLanguageDescription =>
      'Seleziona la lingua delle preghiere, dell\'esame di coscienza e delle guide';

  @override
  String get changeAnytimeNote =>
      'Puoi cambiarla in qualsiasi momento nelle Impostazioni';

  @override
  String get continueButton => 'Continua';

  @override
  String get examineDescription =>
      'Esamina la tua coscienza con i dieci comandamenti prima della confessione';

  @override
  String get confessDescription =>
      'Tieni traccia dei tuoi peccati durante la confessione per non dimenticare nulla';

  @override
  String get prayersDescription =>
      'Accedi alle preghiere per prima e dopo la confessione e alle preghiere di penitenza';

  @override
  String get remindersDescription =>
      'Imposta promemoria regolari nelle Impostazioni per non dimenticare mai di andare a confessarti';

  @override
  String get nextButton => 'Avanti';

  @override
  String get customSins => 'Peccati personalizzati';

  @override
  String get manageCustomSins => 'Gestisci i peccati personalizzati';

  @override
  String get addCustomSin => 'Aggiungi un peccato personalizzato';

  @override
  String get editCustomSin => 'Modifica il peccato personalizzato';

  @override
  String get deleteCustomSin => 'Elimina il peccato personalizzato';

  @override
  String get sinDescription => 'Descrizione del peccato';

  @override
  String get sinDescriptionHint => 'Descrivi il peccato che vuoi ricordare';

  @override
  String get sinDescriptionRequired => 'Inserisci una descrizione del peccato';

  @override
  String get optionalNote => 'Nota facoltativa';

  @override
  String get optionalNoteHint => 'Aggiungi altri dettagli';

  @override
  String get selectCommandment => 'Scegli un comandamento (facoltativo)';

  @override
  String get noCommandment => 'Generale / Nessun comandamento';

  @override
  String get customSinAdded => 'Peccato personalizzato aggiunto';

  @override
  String get customSinUpdated => 'Peccato personalizzato aggiornato';

  @override
  String get customSinDeleted => 'Peccato personalizzato eliminato';

  @override
  String get deleteCustomSinConfirm =>
      'Vuoi davvero eliminare questo peccato personalizzato?';

  @override
  String get noCustomSins => 'Nessun peccato personalizzato';

  @override
  String get noCustomSinsDesc =>
      'Aggiungi peccati personalizzati per adattare l\'esame alla tua vita';

  @override
  String get customVersion => 'Personalizzato (modificato)';

  @override
  String get searchCustomSins => 'Cerca tra i peccati personalizzati...';

  @override
  String get addButton => 'Aggiungi';

  @override
  String get updateButton => 'Aggiorna';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get addYourOwn => 'Aggiungi il tuo...';

  @override
  String get penance => 'Penitenza';

  @override
  String get penanceTracker => 'Le tue penitenze';

  @override
  String get addPenance => 'Aggiungi una penitenza';

  @override
  String get editPenance => 'Modifica la penitenza';

  @override
  String get penanceDescription => 'Quale penitenza ti è stata assegnata?';

  @override
  String get penanceHint =>
      'Es.: recitare 3 Ave Maria, leggere un passo della Scrittura...';

  @override
  String get penanceAdded => 'Penitenza aggiunta';

  @override
  String get penanceUpdated => 'Penitenza aggiornata';

  @override
  String get penanceCompleted => 'Penitenza compiuta! Dio ti benedica.';

  @override
  String get markAsComplete => 'Segna come compiuta';

  @override
  String get pendingPenances => 'Penitenze da compiere';

  @override
  String get noPendingPenances => 'Nessuna penitenza da compiere';

  @override
  String get noPendingPenancesDesc =>
      'Hai compiuto tutte le tue penitenze. Dio ti benedica!';

  @override
  String completedOn(Object date) {
    return 'Compiuta il $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Assegnata il $date';
  }

  @override
  String get skipPenance => 'Salta';

  @override
  String get savePenance => 'Salva la penitenza';

  @override
  String get insights => 'Statistiche';

  @override
  String get confessionInsights => 'Statistiche delle confessioni';

  @override
  String get totalConfessions => 'Confessioni totali';

  @override
  String get averageFrequency => 'Frequenza media';

  @override
  String everyXDays(Object count) {
    return 'Ogni $count giorni';
  }

  @override
  String get daysSinceLastConfession => 'Giorni dall\'ultima';

  @override
  String get currentStreak => 'Costanza attuale';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane',
      one: '1 settimana',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Attività mensile';

  @override
  String get confessionsThisYear => 'Confessioni quest\'anno';

  @override
  String get noInsightsYet => 'Ancora nessuna statistica';

  @override
  String get noInsightsYetDesc =>
      'Completa la tua prima confessione per vedere le statistiche del tuo cammino spirituale';

  @override
  String get totalItemsConfessed => 'Elementi confessati in totale';

  @override
  String get firstConfession => 'Prima confessione';

  @override
  String get spiritualJourney => 'Il tuo cammino spirituale';

  @override
  String get listView => 'Elenco';

  @override
  String get guidedView => 'Guidato';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current di $total';
  }

  @override
  String get previousCommandment => 'Precedente';

  @override
  String get nextCommandment => 'Successivo';

  @override
  String get finishExamination => 'Concludi';

  @override
  String get noQuestionsSelected =>
      'Nessuna domanda selezionata in questa sezione';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count selezionate';
  }

  @override
  String get examinationSummary => 'Riepilogo dell\'esame';

  @override
  String get examinationNote =>
      'Un esame di coscienza approfondito va oltre qualsiasi elenco. Rifletti nella preghiera sul tuo stato di vita e sulle tue circostanze.';

  @override
  String selectedCount(Object count) {
    return '$count elementi selezionati';
  }

  @override
  String get noSinsSelected => 'Nessun peccato selezionato';

  @override
  String get continueEditing => 'Continua a modificare';

  @override
  String get proceedToConfess => 'Prosegui';

  @override
  String get clearDraftTitle => 'Cancellare la bozza?';

  @override
  String get clearDraftMessage =>
      'Questa azione rimuoverà tutte le domande selezionate. Vuoi continuare?';

  @override
  String get clearDraft => 'Cancella la bozza';

  @override
  String get clear => 'Cancella';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ripristinati $count elementi dalla tua ultima sessione',
      one: 'Ripristinato 1 elemento dalla tua ultima sessione',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Adesso';

  @override
  String minutesAgo(Object count) {
    return '$count min fa';
  }

  @override
  String hoursAgo(Object count) {
    return '$count h fa';
  }

  @override
  String get general => 'Generale';

  @override
  String get noQuestionsInSection => 'Nessuna domanda in questa sezione';

  @override
  String get skip => 'Salta';

  @override
  String get back => 'Indietro';

  @override
  String get skipOnboardingTitle => 'Saltare l\'introduzione?';

  @override
  String get skipOnboardingMessage =>
      'Andrai direttamente all\'ultima pagina. Qui non viene configurato nulla: puoi cambiare tutto in seguito nelle Impostazioni.';

  @override
  String get confessionHistoryTitle => 'Storico delle confessioni';

  @override
  String get deleteAll => 'Elimina tutto';

  @override
  String get editDate => 'Modifica la data';

  @override
  String get confessionDate => 'Data della confessione';

  @override
  String get dateUpdated => 'Data aggiornata';

  @override
  String get changeDateConfirmTitle => 'Cambiare la data?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Vuoi cambiare la data della confessione in $date?';
  }

  @override
  String get noGuideContent => 'Nessun contenuto della guida disponibile';

  @override
  String get noGuideContentDesc => 'I contenuti della guida appariranno qui';

  @override
  String get noFaqContent => 'Nessuna domanda frequente disponibile';

  @override
  String get noFaqContentDesc => 'Le domande frequenti appariranno qui';

  @override
  String get faqSubtitle => 'Una guida al sacramento della Riconciliazione';

  @override
  String get tapToExpand => 'Tocca per leggere di più';

  @override
  String get continueExamination => 'Riprendi l\'esame';

  @override
  String get continueExaminationDesc => 'Hai un esame in corso';

  @override
  String examinationProgress(Object count) {
    return '$count elementi selezionati';
  }

  @override
  String get security => 'Sicurezza';

  @override
  String get securitySubtitle => 'Proteggi i tuoi dati personali';

  @override
  String get pinAndBiometric => 'PIN e biometria';

  @override
  String get pinAndBiometricSubtitle => 'Configura il blocco dell\'app';

  @override
  String get enterPin => 'Inserisci il PIN';

  @override
  String get createPin => 'Crea un PIN';

  @override
  String get confirmPin => 'Conferma il PIN';

  @override
  String get incorrectPin => 'PIN errato';

  @override
  String get pinMismatch => 'I PIN non coincidono';

  @override
  String get biometricUnlock => 'Sblocco biometrico';

  @override
  String get autoLockTimeout => 'Blocco automatico';

  @override
  String get tooManyAttempts => 'Troppi tentativi falliti';

  @override
  String tryAgainIn(Object time) {
    return 'Riprova tra $time';
  }

  @override
  String get useBiometricUnlock => 'Usa lo sblocco biometrico';

  @override
  String get unlockWithFingerprintOrFace =>
      'Sblocca con l\'impronta o il volto';

  @override
  String get biometricAccessWarning =>
      'Chiunque abbia un\'impronta digitale o un volto registrati su questo dispositivo potrà accedere all\'app';

  @override
  String get lockAfter => 'Blocca dopo';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Tempo in secondo piano prima del blocco';

  @override
  String get changePin => 'Cambia il PIN';

  @override
  String get updateYourSecurityPin => 'Aggiorna il tuo PIN di sicurezza';

  @override
  String get enterCurrentPin => 'Inserisci il PIN attuale';

  @override
  String get enterNewPin => 'Inserisci il nuovo PIN';

  @override
  String get confirmNewPin => 'Conferma il nuovo PIN';

  @override
  String get pinChangedSuccessfully => 'PIN modificato correttamente';

  @override
  String get currentPinIncorrect => 'Il PIN attuale è errato';

  @override
  String get enableBiometricUnlock => 'Attivare lo sblocco biometrico?';

  @override
  String get biometricDescription =>
      'Usa l\'impronta digitale o il volto per sbloccare l\'app in modo rapido e sicuro.';

  @override
  String get notNow => 'Non ora';

  @override
  String get enable => 'Attiva';

  @override
  String get setUpPin => 'Imposta un PIN';

  @override
  String get createSixDigitPin => 'Crea un PIN di 6 cifre';

  @override
  String get pinProtectData => 'Questo PIN servirà a proteggere i tuoi dati';

  @override
  String get confirmYourPin => 'Conferma il tuo PIN';

  @override
  String get enterSamePinAgain =>
      'Inserisci di nuovo lo stesso PIN per confermare';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Inserisci il PIN per sbloccare';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tentativi rimasti',
      one: '1 tentativo rimasto',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondi',
      one: '1 secondo',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Annulla';

  @override
  String get confessionDeleted => 'Confessione eliminata';

  @override
  String get noConfessionHistory => 'Nessuna confessione registrata';

  @override
  String get noConfessionHistoryDesc =>
      'Le confessioni completate appariranno qui';

  @override
  String get fontSize => 'Dimensione del testo';

  @override
  String get fontSizeSubtitle =>
      'Regola la dimensione del testo per una lettura più agevole';

  @override
  String get fontSizeSmall => 'Piccolo';

  @override
  String get fontSizeMedium => 'Medio';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeExtraLarge => 'Molto grande';

  @override
  String get forgotPin => 'Hai dimenticato il PIN?';

  @override
  String get resetPinTitle => 'Reimposta il PIN';

  @override
  String get resetPinWarning =>
      'Attenzione: questa azione eliminerà definitivamente tutti i tuoi dati';

  @override
  String get resetPinDescription =>
      'Se reimposti il PIN, tutte le tue confessioni, i peccati personalizzati, le penitenze e gli altri dati personali saranno eliminati definitivamente. Questa azione non può essere annullata.';

  @override
  String get resetPinConfirmation => 'Scrivi ELIMINA per confermare';

  @override
  String get resetPinButton => 'Reimposta il PIN ed elimina i dati';

  @override
  String get resetPinSuccess =>
      'PIN reimpostato correttamente. Imposta un nuovo PIN.';

  @override
  String get resetPinError => 'Impossibile reimpostare il PIN. Riprova.';

  @override
  String get deleteConfirmationText => 'ELIMINA';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Attendi $seconds secondi';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Verifica la tua identità per reimpostare il PIN';

  @override
  String get confessionGuideTitle => 'Come fare una buona confessione';

  @override
  String get shortFilmTitle => 'La confessione: un cortometraggio';

  @override
  String get shortFilmSubtitle =>
      'Creato da Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Regno Unito';

  @override
  String get confessionGuideSubtitle => 'Guida passo passo al sacramento';

  @override
  String get invitationTitle => 'Torni a confessarti?';

  @override
  String get invitationSubtitle => 'Una parola di incoraggiamento per te';

  @override
  String get invitationDialogTitle => 'Ti diamo il benvenuto';

  @override
  String get invitationDialogContent =>
      'È la tua prima confessione dopo tanto tempo, oppure ti senti in ansia all\'idea di andare?';

  @override
  String get invitationDialogYes => 'Sì, vorrei un po\' di incoraggiamento';

  @override
  String get invitationDialogNo => 'No, posso iniziare';

  @override
  String get invitationDialogDontShowAgain =>
      'Non mostrare più questo messaggio';

  @override
  String get searchPrayers => 'Cerca preghiere...';

  @override
  String get allCategories => 'Tutte';

  @override
  String get appDisclaimer =>
      'Questa app è un aiuto spirituale per prepararsi alla confessione. Non sostituisce il sacramento della Riconciliazione con un sacerdote.';

  @override
  String get onboardingDisclaimer =>
      'Un compagno spirituale per la confessione, non un suo sostituto.';

  @override
  String get readyToBegin => 'Tutto pronto';

  @override
  String get readyToBeginSubtitle =>
      'Che il tuo cammino verso la riconciliazione sia colmo di grazia e di pace.';

  @override
  String get onboardingOverviewTitle => 'Che cosa fa questa app';

  @override
  String get onboardingOverviewExamine =>
      'Prepara la tua coscienza, con i tuoi tempi.';

  @override
  String get onboardingOverviewConfess =>
      'Un elenco discreto, perché nulla venga dimenticato.';

  @override
  String get onboardingOverviewJournal =>
      'Una breve riflessione serale, per crescere tra una confessione e l\'altra.';

  @override
  String get onboardingOverviewFootnote =>
      'All\'interno trovi preghiere, guide e promemoria facoltativi.';

  @override
  String get onboardingPrivacyTitle => 'Riservata per scelta';

  @override
  String get onboardingPrivacyLocal =>
      'Tutto resta su questo telefono. Nessun account, nessun cloud.';

  @override
  String get onboardingPrivacyEncrypted =>
      'Tutto è crittografato sul tuo dispositivo.';

  @override
  String get onboardingPrivacyPin =>
      'Creerai un PIN la prima volta che aprirai un esame o il tuo diario.';

  @override
  String get sourceCode => 'Codice sorgente';

  @override
  String get contentReferences => 'Fonti dei contenuti';

  @override
  String get examinationModeTitle => 'Come vuoi esaminarti?';

  @override
  String get quickReviewMode => 'Revisione rapida';

  @override
  String get quickReviewDescription => 'Scorri tutte le domande per categoria';

  @override
  String get deepReflectionMode => 'Riflessione profonda';

  @override
  String get deepReflectionDescription =>
      'Una domanda alla volta, per un esame meditato';

  @override
  String get contemplativePrayerTitle => 'Vieni, Spirito Santo';

  @override
  String get contemplativePrayerText =>
      'Riempi il mio cuore e accendi in me il fuoco del tuo amore. Illumina la mia mente perché io veda con chiarezza i miei peccati.';

  @override
  String get imReady => 'Iniziamo';

  @override
  String get skipPrayer => 'Salta';

  @override
  String get yesThisApplies => 'Sì';

  @override
  String get noThisDoesnt => 'No';

  @override
  String get skipQuestion => 'Salta';

  @override
  String questionProgress(int current, int total) {
    return '$current di $total';
  }

  @override
  String get examinationComplete => 'Esame completato';

  @override
  String get reviewYourSelections => 'Rivedi le tue selezioni';

  @override
  String get examinationModeSettingTitle => 'Modalità di esame';

  @override
  String get examinationModeSettingSubtitle =>
      'Scegli come vuoi esaminare la tua coscienza';

  @override
  String get askEveryTime => 'Chiedi ogni volta';

  @override
  String get reminderNotificationTitle => 'È tempo di confessarsi';

  @override
  String get reminderNotificationBody =>
      'Ricordati di esaminare la tua coscienza e di prepararti alla confessione';

  @override
  String get notificationPermissionDenied =>
      'Le notifiche sono disattivate. Consenti le notifiche per Metanoia nelle impostazioni del dispositivo per ricevere i promemoria della confessione.';

  @override
  String get openSourceLicenses => 'Licenze open source';

  @override
  String get couldNotOpenLink => 'Non è stato possibile aprire il link';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi confessati',
      one: '1 elemento confessato',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitenze',
      one: '1 penitenza',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count in sospeso',
      one: '1 in sospeso',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count in totale',
      one: '1 in totale',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi',
      one: '1 elemento',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sett.',
      one: '1 sett.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Eliminare tutte le confessioni?';

  @override
  String get deleteAllConfessionsContent =>
      'Tutto lo storico delle tue confessioni sarà eliminato definitivamente. L\'azione non può essere annullata.';

  @override
  String get allConfessionsDeleted =>
      'Tutte le confessioni sono state eliminate';

  @override
  String get deletePenanceConfirm => 'Vuoi davvero eliminare questa penitenza?';

  @override
  String get completed => 'Completata';

  @override
  String get tapToCollapse => 'Tocca per chiudere';

  @override
  String get dismiss => 'Chiudi';

  @override
  String showcaseStep(int current, int total) {
    return 'Passo $current di $total';
  }

  @override
  String get done => 'Fine';

  @override
  String get navigate => 'Apri';

  @override
  String get encouragement => 'Incoraggiamento';

  @override
  String get biometricPromptReason => 'Autenticati per accedere a Metanoia';

  @override
  String get tryAgainInLabel => 'Riprova tra';

  @override
  String get errorLoadingLanguage => 'Errore nel caricamento della lingua';

  @override
  String get detailsNotSaved => 'Dettagli non salvati';

  @override
  String get discardStoredSinsTitle => 'Eliminare i peccati salvati?';

  @override
  String get discardStoredSinsContent =>
      'Lo storico delle confessioni è ora disattivato. I peccati già salvati dalle confessioni passate sono ancora conservati. Vuoi eliminarli? Le date saranno mantenute, così le tue statistiche e la tua costanza restano intatte.';

  @override
  String get keepThem => 'Conservali';

  @override
  String get discard => 'Elimina';

  @override
  String get storedSinsDiscarded =>
      'Peccati salvati eliminati. Le date delle confessioni sono state mantenute.';

  @override
  String get journalTitle => 'Diario';

  @override
  String get journalHomeCardTitle => 'Riflessione serale';

  @override
  String get journalHomeCardSubtitle => 'Com\'è andata oggi?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Giorni consecutivi di riflessione';

  @override
  String get journalContinueToday => 'Continua la voce di oggi';

  @override
  String get journalPreviousMonth => 'Mese precedente';

  @override
  String get journalNextMonth => 'Mese successivo';

  @override
  String get journalGratitudeTitle => 'Gratitudine';

  @override
  String get journalGratitudePrompt => 'Dove ho visto Dio oggi?';

  @override
  String get journalGratitudeHint => 'Una grazia per cui voglio ringraziarlo…';

  @override
  String get journalPresenceLead =>
      'Dio è qui con te. Fa\' silenzio davanti a Lui e rendi grazie.';

  @override
  String get journalPresenceVerse => 'Fermatevi! Sappiate che io sono Dio.';

  @override
  String get journalPresenceRef => 'Salmo 46,11';

  @override
  String get journalLightTitle => 'Chiedi la luce';

  @override
  String get journalLightLead =>
      'Chiedi allo Spirito Santo la luce per vedere la tua giornata come la vede Dio.';

  @override
  String get journalLightVerse =>
      'Vieni, Santo Spirito, riempi i cuori dei tuoi fedeli e accendi in essi il fuoco del tuo amore.';

  @override
  String get journalReviewTitle => 'Rivedi con Dio';

  @override
  String get journalReviewLead =>
      'Ripercorri la tua giornata con il Signore: dove l\'amore è venuto a te, dove l\'hai donato e dove ti sei allontanato.';

  @override
  String get journalReviewVerse =>
      'Scrutami, o Dio, e conosci il mio cuore, provami e conosci i miei pensieri; vedi se percorro una via di dolore e guidami per una via di eternità.';

  @override
  String get journalReviewRef => 'Salmo 139,23-24';

  @override
  String get journalReviewHint => 'Parlagli della tua giornata…';

  @override
  String get journalReviewBringSin => 'C\'è qualcosa che vuoi portare a Lui?';

  @override
  String get journalContritionTitle => 'Contrizione';

  @override
  String get journalContritionLead =>
      'Porta al Padre ciò che hai trovato: Egli corre incontro a te.';

  @override
  String get journalContritionVerse =>
      'Pietà di me, o Dio, nel tuo amore; nella tua grande misericordia cancella la mia iniquità.';

  @override
  String get journalContritionRef => 'Salmo 51,3';

  @override
  String get journalContritionPray => 'Recita l\'atto di dolore';

  @override
  String get journalContritionMercy =>
      'Il dolore che nasce dall\'amore per Dio, con il proposito di confessarti, apre il tuo cuore alla sua misericordia stasera; e la sua pienezza ti attende nella Confessione, nelle parole dell\'assoluzione.';

  @override
  String get journalResolutionLead =>
      'Riposa nella sua misericordia. Domani ricomincia in Lui.';

  @override
  String get journalResolutionVerse =>
      'Le grazie del Signore non sono finite, non sono esaurite le sue misericordie. Si rinnovano ogni mattina, grande è la sua fedeltà.';

  @override
  String get journalResolutionRef => 'Lamentazioni 3,22-23';

  @override
  String get journalReflectionTitle => 'Riflessione';

  @override
  String get journalReflectionPrompt => 'Com\'è andata la tua giornata?';

  @override
  String get journalReflectionHint => 'Scrivi liberamente...';

  @override
  String get journalSinsTitle => 'Segna i peccati';

  @override
  String get journalSinsPrompt => 'In che cosa sono venuto meno oggi?';

  @override
  String get journalNoSinsMarked => 'Nulla di segnato finora';

  @override
  String get journalAddSin => 'Segna un peccato';

  @override
  String get journalRemoveSin => 'Rimuovi';

  @override
  String get journalResolutionTitle => 'Speranza e proposito';

  @override
  String get journalResolutionPrompt => 'Un dono da chiedere per domani';

  @override
  String get journalResolutionHint => 'Con la tua grazia, domani io…';

  @override
  String get journalMoodTitle => 'Stato d\'animo';

  @override
  String get journalMoodPrompt => 'Come sta la tua anima stasera?';

  @override
  String get journalMoodDesolate => 'Desolazione';

  @override
  String get journalMoodStruggling => 'Lotta';

  @override
  String get journalMoodSteady => 'Serenità';

  @override
  String get journalMoodGrateful => 'Gratitudine';

  @override
  String get journalMoodConsoled => 'Consolazione';

  @override
  String get journalSaved => 'Salvato';

  @override
  String get journalSaving => 'Salvataggio...';

  @override
  String get journalDeleteEntry => 'Elimina la voce';

  @override
  String get journalDeleteEntryConfirm =>
      'Vuoi eliminare la voce di questo giorno? L\'azione non può essere annullata.';

  @override
  String get journalEntryDeleted => 'Voce eliminata';

  @override
  String get journalPickerQuestions => 'Domande';

  @override
  String get journalPickerMySins => 'I miei peccati';

  @override
  String get journalPickerOwnWords => 'Con parole mie';

  @override
  String get journalPickerFreeTextHint => 'Descrivilo con parole tue';

  @override
  String get journalSearchSins => 'Cerca peccati...';

  @override
  String get journalAbsolved => 'Confessato';

  @override
  String get journalSinCleared => 'Un peccato che hai portato alla confessione';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Includi i $count peccati che hai segnato nel diario',
      one: 'Includi il peccato che hai segnato nel diario',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Includi';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peccati aggiunti dal diario',
      one: '1 peccato aggiunto dal diario',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Aree di lotta';

  @override
  String get journalStruggleAreasSubtitle => 'I più segnati nel tuo diario';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segni',
      one: '1 segno',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Promemoria del diario';

  @override
  String get journalReminderSubtitle =>
      'Un invito serale a riflettere sulla tua giornata';

  @override
  String get enableJournalReminder => 'Attiva il promemoria del diario';

  @override
  String get journalReminderNotificationTitle => 'Riflessione serale';

  @override
  String get journalReminderNotificationBody =>
      'Prenditi un momento per rileggere la tua giornata con Dio';

  @override
  String get confessionDayMode => 'Modalità confessione';

  @override
  String get confessionDayModeDescription =>
      'Testo grande e senza distrazioni per il confessionale';

  @override
  String get exitConfessionMode => 'Esci dalla modalità confessione';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Passo $current di $total';
  }

  @override
  String get next => 'Avanti';

  @override
  String get actOfContrition => 'Atto di dolore';

  @override
  String get actOfContritionUnavailable =>
      'L\'Atto di dolore non è disponibile';

  @override
  String get confessionDaySinsTitle => 'Peccati da confessare';

  @override
  String get confessionDayOpeningTitle => 'Inizio';

  @override
  String get confessionDayOpeningIntro =>
      'Fai il segno della Croce, poi comincia:';

  @override
  String get confessionDayOpeningFormula =>
      'Mi benedica, padre, perché ho peccato.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'La mia ultima confessione è stata $duration fa.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Sono passati [giorni/settimane/mesi/anni] dalla mia ultima confessione.';

  @override
  String get confessionDaySinsClosing =>
      'Di questi e di tutti i miei peccati mi pento sinceramente.';

  @override
  String get confessionDayThanksgivingTitle => 'Va\' in pace';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Lodiamo il Signore perché è buono.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Eterna è la sua misericordia.';

  @override
  String get confessionDayThanksgivingBody =>
      'La tua anima è stata purificata. Compi la tua penitenza e va\' avanti nella pace di Cristo.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane',
      one: '1 settimana',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesi',
      one: '1 mese',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anni',
      one: '1 anno',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Quaresima';

  @override
  String get seasonHolyWeek => 'Settimana Santa';

  @override
  String get seasonAdvent => 'Avvento';

  @override
  String get seasonChristmas => 'Natale';

  @override
  String get seasonEaster => 'Pasqua';

  @override
  String get seasonOrdinaryTime => 'Tempo Ordinario';

  @override
  String get feastAshWednesday => 'Mercoledì delle Ceneri';

  @override
  String get feastPalmSunday => 'Domenica delle Palme';

  @override
  String get feastEaster => 'Pasqua';

  @override
  String get feastPentecost => 'Pentecoste';

  @override
  String get feastAssumption => 'Assunzione di Maria';

  @override
  String get feastAllSaints => 'Tutti i Santi';

  @override
  String get feastImmaculateConception => 'Immacolata Concezione';

  @override
  String get feastFirstSundayOfAdvent => 'Prima domenica di Avvento';

  @override
  String get feastChristmas => 'Natale';

  @override
  String get liturgicalLentTitle => 'È iniziata la Quaresima';

  @override
  String get liturgicalLentBody =>
      'Un tempo di ritorno. Molti lo iniziano con la confessione.';

  @override
  String get liturgicalHolyWeekTitle => 'È iniziata la Settimana Santa';

  @override
  String get liturgicalHolyWeekBody =>
      'La Chiesa cammina verso la Pasqua. C\'è ancora tempo per preparare il tuo cuore.';

  @override
  String get liturgicalAdventTitle => 'È iniziato l\'Avvento';

  @override
  String get liturgicalAdventBody =>
      'Un tempo di attesa. Molti preparano il cuore con la confessione.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast si avvicina';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Mancano $count giorni: prepara il tuo cuore.',
      one: 'Manca un giorno: prepara il tuo cuore.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sono passate $count settimane dalla tua ultima confessione',
      one: 'È passata una settimana dalla tua ultima confessione',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Quando vorrai, la misericordia ti attende. Vuoi prepararti?';

  @override
  String get promptPrepare => 'Preparati';

  @override
  String get dataUnrecoverableTitle =>
      'I tuoi dati non possono essere sbloccati';

  @override
  String get dataUnrecoverableBody =>
      'La chiave che protegge le tue confessioni non è più disponibile su questo dispositivo. Può accadere dopo il ripristino da un backup, oppure se le impostazioni di sicurezza del dispositivo sono state reimpostate.\n\nPoiché i tuoi dati sono crittografati, non possono essere recuperati senza quella chiave — nemmeno da noi. Puoi cancellarli e ricominciare da capo.';

  @override
  String get eraseAndStartOver => 'Cancella e ricomincia';

  @override
  String get eraseAndStartOverConfirm =>
      'Questa azione cancella definitivamente tutto ciò che è conservato su questo dispositivo e riavvia l\'app da zero. Non può essere annullata.';

  @override
  String get penanceSaveFailed =>
      'Non è stato possibile salvare la penitenza. Riprova.';

  @override
  String get confessionReminderChannelName => 'Promemoria della confessione';

  @override
  String get confessionReminderChannelDescription =>
      'Promemoria per la confessione';

  @override
  String get journalReminderChannelName => 'Promemoria del diario';

  @override
  String get journalReminderChannelDescription =>
      'Promemoria quotidiano per scrivere la riflessione serale';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nominati finora',
      one: 'Uno nominato finora',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Prima di iniziare';

  @override
  String get invitationCardAction => 'Incoraggiami';

  @override
  String get homeCtaBeginTitle => 'Inizia il tuo esame di coscienza';

  @override
  String get homeCtaBeginSubtitle =>
      'Prepara il tuo cuore prima della confessione';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continua il tuo esame ($count selezionati)',
      one: 'Continua il tuo esame (1 selezionato)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Riprendi da dove avevi lasciato';

  @override
  String get homeCtaReadyTitle => 'Puoi iniziare';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count peccati ti aspettano nell\'elenco della confessione',
      one: '1 peccato ti aspetta nell\'elenco della confessione',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Compi la tua penitenza';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitenze sono ancora in sospeso',
      one: '1 penitenza è ancora in sospeso',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Incoraggiamento, una guida passo passo, preghiere e domande frequenti';

  @override
  String get homeQuoteReadMore => 'Leggi di più';

  @override
  String get homeQuoteShowLess => 'Mostra meno';

  @override
  String get tutorialJournalDesc =>
      'Rileggi la tua giornata ogni sera: una breve riflessione e i tuoi giorni consecutivi.';
}
