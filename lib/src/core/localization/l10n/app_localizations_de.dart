// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Willkommen';

  @override
  String get examineTitle => 'Erforschen';

  @override
  String get confessTitle => 'Beichten';

  @override
  String get prayersTitle => 'Gebete';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get examinationTitle => 'Gewissenserforschung';

  @override
  String get commandment => 'Gebot';

  @override
  String get guideTitle => 'Anleitung';

  @override
  String get faqTitle => 'Die Beichte verstehen';

  @override
  String get language => 'Sprache';

  @override
  String get chooseLanguage => 'Wähle deine bevorzugte Sprache';

  @override
  String get theme => 'Design';

  @override
  String get chooseTheme => 'Wähle dein bevorzugtes Design';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get reminders => 'Erinnerungen';

  @override
  String get getReminded => 'Lass dich an die Beichte erinnern';

  @override
  String get enableReminders => 'Erinnerungen aktivieren';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get biweekly => 'Alle zwei Wochen';

  @override
  String get monthly => 'Monatlich';

  @override
  String get quarterly => 'Vierteljährlich';

  @override
  String get day => 'Tag';

  @override
  String get time => 'Uhrzeit';

  @override
  String get remindMe => 'Erinnere mich';

  @override
  String get onTheDay => 'Am selben Tag';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage vorher',
      one: '1 Tag vorher',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Schnellzugriff';

  @override
  String get lastConfession => 'Letzte Beichte';

  @override
  String get noneYet => 'Noch keine';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vor $count Tagen',
      one: 'Vor 1 Tag',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Nächste Erinnerung';

  @override
  String get off => 'Aus';

  @override
  String get mon => 'Mo';

  @override
  String get tue => 'Di';

  @override
  String get wed => 'Mi';

  @override
  String get thu => 'Do';

  @override
  String get fri => 'Fr';

  @override
  String get sat => 'Sa';

  @override
  String get sun => 'So';

  @override
  String get monday => 'Montag';

  @override
  String get tuesday => 'Dienstag';

  @override
  String get wednesday => 'Mittwoch';

  @override
  String get thursday => 'Donnerstag';

  @override
  String get friday => 'Freitag';

  @override
  String get saturday => 'Samstag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get appLanguageSubtitle =>
      'Sprache für Schaltflächen, Beschriftungen und Menüs';

  @override
  String get contentLanguage => 'Inhaltssprache';

  @override
  String get contentLanguageSubtitle =>
      'Sprache für Fragen zur Gewissenserforschung, FAQ und Gebete';

  @override
  String get version => 'Version';

  @override
  String get selectDay => 'Tag auswählen';

  @override
  String selected(num count) {
    return '$count ausgewählt';
  }

  @override
  String get selectedLabel => 'ausgewählt';

  @override
  String get counter => 'Zähler';

  @override
  String get searchPlaceholder => 'Gebote oder Fragen suchen...';

  @override
  String get noResults => 'Keine Ergebnisse gefunden';

  @override
  String get viewHistory => 'Verlauf ansehen';

  @override
  String get noActiveConfession => 'Keine aktive Beichte';

  @override
  String get startExaminationPrompt =>
      'Beginne eine Gewissenserforschung, um hier Sünden hinzuzufügen.';

  @override
  String get startExamination => 'Gewissenserforschung beginnen';

  @override
  String get finishConfessionTitle => 'Beichte abschließen?';

  @override
  String get finishConfessionContent =>
      'Damit wird die Beichte als abgeschlossen markiert und in deinen Verlauf verschoben.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get finish => 'Abschließen';

  @override
  String get confessionCompletedMessage =>
      'Beichte abgeschlossen! Gott segne dich.';

  @override
  String get finishConfession => 'Beichte abschließen';

  @override
  String get error => 'Fehler';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get dailyQuoteError =>
      'Das heutige Zitat konnte nicht geladen werden.';

  @override
  String get keepHistory => 'Beichtverlauf speichern';

  @override
  String get keepHistorySubtitle =>
      'Speichere deine Sünden zusammen mit dem Datum. Wenn deaktiviert, wird nur das Datum gespeichert.';

  @override
  String get deleteConfession => 'Beichte löschen';

  @override
  String get deleteConfessionContent =>
      'Damit werden diese Beichte und alle zugehörigen Einträge dauerhaft aus deinem Verlauf gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get tutorialExamineDesc =>
      'Beginne hier, um vor der Beichte dein Gewissen zu erforschen.';

  @override
  String get tutorialConfessDesc =>
      'Nutze dies während der Beichte, um deine Sünden im Blick zu behalten.';

  @override
  String get tutorialPrayersDesc =>
      'Hier findest du die gebräuchlichen Gebete vor und nach der Beichte.';

  @override
  String get tutorialGuideDesc =>
      'Hier findest du Ermutigung, eine Schritt-für-Schritt-Anleitung zur Beichte und häufige Fragen.';

  @override
  String get tutorialSettingsDesc =>
      'Passe die App hier an: Sprache und Design ändern, Erinnerungen einstellen und Sicherheitseinstellungen verwalten.';

  @override
  String get tutorialSwipeDesc =>
      'Wische nach links oder rechts, um zwischen den Geboten zu wechseln.';

  @override
  String get tutorialSelectDesc =>
      'Tippe auf eine Frage, um sie für deine Beichte auszuwählen.';

  @override
  String get tutorialFinishDesc =>
      'Wenn du fertig bist, tippe hier, um abzuschließen und zur Beichte zu gehen.';

  @override
  String get tutorialCounterDesc =>
      'Hier siehst du, wie viele Einträge du für die Beichte ausgewählt hast.';

  @override
  String get tutorialMenuDesc =>
      'Von hier aus kannst du eigene Sünden hinzufügen und deine Auswahl zurücksetzen.';

  @override
  String get tutorialPenanceDesc =>
      'Verfolge hier die Bußen, die dir dein Beichtvater aufgegeben hat.';

  @override
  String get tutorialInsightsDesc =>
      'Sieh dir Statistiken und Serien deines Beichtwegs an.';

  @override
  String get tutorialHistoryDesc =>
      'Greife hier auf deine früheren Beichten und ihre Daten zu.';

  @override
  String get replayTutorial => 'Tutorial erneut ansehen';

  @override
  String get replayTutorialDesc => 'Die App-Einführung noch einmal ansehen';

  @override
  String get tutorialReset =>
      'Tutorial zurückgesetzt! Du siehst die Hinweise wieder.';

  @override
  String get about => 'Über die App';

  @override
  String get aboutSubtitle => 'Version, Lizenz und Quellcode';

  @override
  String get shareApp => 'App teilen';

  @override
  String get shareAppSubtitle => 'Mit Freunden und Familie teilen';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get spreadShareTitle => 'Metanoia teilen';

  @override
  String get spreadShareSubtitle =>
      'Kennst du jemanden, der sich von der Beichte entfernt hat? Hilf dieser Person, den Weg zurückzufinden.';

  @override
  String get spreadShareAction => 'Teilen';

  @override
  String get spreadRateSubtitle =>
      'Wenn Metanoia dir bei der Vorbereitung auf die Beichte geholfen hat, hilft eine Bewertung anderen, die App zu finden.';

  @override
  String get spreadRateAction => 'Bewerten';

  @override
  String get rateGateHint => 'Wie bewertest du deine Erfahrung?';

  @override
  String get rateGateLowest => 'Am niedrigsten';

  @override
  String get rateGateHighest => 'Am höchsten';

  @override
  String get rateGateThanks => 'Danke — deine Rückmeldung bedeutet uns viel.';

  @override
  String rateAppSubtitle(String store) {
    return 'Bewerte uns bei $store';
  }

  @override
  String get website => 'Website';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get madeWithLove => 'Mit ❤️ gemacht von holystack.dev';

  @override
  String get rateDialogTitle => 'Gefällt dir Metanoia?';

  @override
  String get rateDialogContent =>
      'Wenn dir diese App hilft, nimm dir bitte einen Moment Zeit für eine Bewertung. Das hilft uns sehr!';

  @override
  String get rateDialogYes => 'Jetzt bewerten';

  @override
  String get rateDialogNo => 'Nein, danke';

  @override
  String get rateDialogLater => 'Später erinnern';

  @override
  String get greekLabel => 'Griechisch';

  @override
  String get nounLabel => 'Substantiv';

  @override
  String get metanoiaDefinition =>
      'Eine tiefgreifende Wandlung des Denkens und des Herzens; ein geistliches Erwachen, das den ganzen Menschen verwandelt und sein Leben neu auf Gott ausrichtet.';

  @override
  String get turnBackToGrace => 'Kehr zurück zur Gnade';

  @override
  String get welcomeSubtitle => 'Dein Begleiter für eine gute Beichte';

  @override
  String get discoverInnerGrace => 'Entdecke die innere Gnade';

  @override
  String get sacredJourneyBegins => 'Ein heiliger Weg der Versöhnung beginnt.';

  @override
  String get beginJourney => 'Den Weg beginnen';

  @override
  String get getStarted => 'Beginnen';

  @override
  String get chooseContentLanguage => 'Inhaltssprache wählen';

  @override
  String get contentLanguageDescription =>
      'Wähle die Sprache für Gebete, Gewissenserforschung und Anleitungen';

  @override
  String get changeAnytimeNote =>
      'Du kannst dies jederzeit in den Einstellungen ändern';

  @override
  String get continueButton => 'Weiter';

  @override
  String get examineDescription =>
      'Erforsche vor der Beichte dein Gewissen anhand der Zehn Gebote';

  @override
  String get confessDescription =>
      'Behalte deine Sünden während der Beichte im Blick, damit nichts vergessen wird';

  @override
  String get prayersDescription =>
      'Finde Gebete für vor und nach der Beichte sowie Bußgebete';

  @override
  String get remindersDescription =>
      'Richte in den Einstellungen regelmäßige Erinnerungen ein, damit du die Beichte nie vergisst';

  @override
  String get nextButton => 'Weiter';

  @override
  String get customSins => 'Eigene Sünden';

  @override
  String get manageCustomSins => 'Eigene Sünden verwalten';

  @override
  String get addCustomSin => 'Eigene Sünde hinzufügen';

  @override
  String get editCustomSin => 'Eigene Sünde bearbeiten';

  @override
  String get deleteCustomSin => 'Eigene Sünde löschen';

  @override
  String get sinDescription => 'Beschreibung der Sünde';

  @override
  String get sinDescriptionHint =>
      'Beschreibe die Sünde, an die du dich erinnern möchtest';

  @override
  String get sinDescriptionRequired =>
      'Bitte gib eine Beschreibung der Sünde ein';

  @override
  String get optionalNote => 'Notiz (optional)';

  @override
  String get optionalNoteHint => 'Füge weitere Einzelheiten hinzu';

  @override
  String get selectCommandment => 'Gebot wählen (optional)';

  @override
  String get noCommandment => 'Allgemein / Kein Gebot';

  @override
  String get customSinAdded => 'Eigene Sünde hinzugefügt';

  @override
  String get customSinUpdated => 'Eigene Sünde aktualisiert';

  @override
  String get customSinDeleted => 'Eigene Sünde gelöscht';

  @override
  String get deleteCustomSinConfirm =>
      'Möchtest du diese eigene Sünde wirklich löschen?';

  @override
  String get noCustomSins => 'Noch keine eigenen Sünden';

  @override
  String get noCustomSinsDesc =>
      'Füge eigene Sünden hinzu, um deine Gewissenserforschung persönlicher zu gestalten';

  @override
  String get customVersion => 'Eigene Fassung (bearbeitet)';

  @override
  String get searchCustomSins => 'Eigene Sünden suchen...';

  @override
  String get addButton => 'Hinzufügen';

  @override
  String get updateButton => 'Aktualisieren';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get addYourOwn => 'Eigene hinzufügen...';

  @override
  String get penance => 'Buße';

  @override
  String get penanceTracker => 'Bußenübersicht';

  @override
  String get addPenance => 'Buße hinzufügen';

  @override
  String get editPenance => 'Buße bearbeiten';

  @override
  String get penanceDescription => 'Welche Buße wurde dir aufgegeben?';

  @override
  String get penanceHint =>
      'z. B. drei Gegrüßet seist du, Maria beten, einen Schriftabschnitt lesen...';

  @override
  String get penanceAdded => 'Buße hinzugefügt';

  @override
  String get penanceUpdated => 'Buße aktualisiert';

  @override
  String get penanceCompleted => 'Buße verrichtet! Gott segne dich.';

  @override
  String get markAsComplete => 'Als verrichtet markieren';

  @override
  String get pendingPenances => 'Offene Bußen';

  @override
  String get noPendingPenances => 'Keine offenen Bußen';

  @override
  String get noPendingPenancesDesc =>
      'Alle deine Bußen sind verrichtet. Gott segne dich!';

  @override
  String completedOn(Object date) {
    return 'Verrichtet am $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Aufgegeben am $date';
  }

  @override
  String get skipPenance => 'Überspringen';

  @override
  String get savePenance => 'Buße speichern';

  @override
  String get insights => 'Einblicke';

  @override
  String get confessionInsights => 'Einblicke in deine Beichten';

  @override
  String get totalConfessions => 'Beichten insgesamt';

  @override
  String get averageFrequency => 'Durchschnittliche Häufigkeit';

  @override
  String everyXDays(Object count) {
    return 'Alle $count Tage';
  }

  @override
  String get daysSinceLastConfession => 'Tage seit der letzten';

  @override
  String get currentStreak => 'Aktuelle Serie';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wochen',
      one: '1 Woche',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Monatliche Aktivität';

  @override
  String get confessionsThisYear => 'Beichten in diesem Jahr';

  @override
  String get noInsightsYet => 'Noch keine Einblicke';

  @override
  String get noInsightsYetDesc =>
      'Schließe deine erste Beichte ab, um Statistiken zu deinem geistlichen Weg zu sehen';

  @override
  String get totalItemsConfessed => 'Gebeichtete Einträge insgesamt';

  @override
  String get firstConfession => 'Erste Beichte';

  @override
  String get spiritualJourney => 'Dein geistlicher Weg';

  @override
  String get listView => 'Liste';

  @override
  String get guidedView => 'Geführt';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current von $total';
  }

  @override
  String get previousCommandment => 'Zurück';

  @override
  String get nextCommandment => 'Weiter';

  @override
  String get finishExamination => 'Fertig';

  @override
  String get noQuestionsSelected =>
      'In diesem Abschnitt sind keine Fragen ausgewählt';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count ausgewählt';
  }

  @override
  String get examinationSummary => 'Zusammenfassung der Gewissenserforschung';

  @override
  String get examinationNote =>
      'Eine gründliche Gewissenserforschung geht über jede Liste hinaus. Bedenke im Gebet deinen Lebensstand und deine Lebensumstände.';

  @override
  String selectedCount(Object count) {
    return '$count Einträge ausgewählt';
  }

  @override
  String get noSinsSelected => 'Keine Sünden ausgewählt';

  @override
  String get continueEditing => 'Weiter bearbeiten';

  @override
  String get proceedToConfess => 'Fortfahren';

  @override
  String get clearDraftTitle => 'Entwurf verwerfen?';

  @override
  String get clearDraftMessage =>
      'Dadurch werden alle ausgewählten Fragen entfernt. Bist du sicher?';

  @override
  String get clearDraft => 'Entwurf verwerfen';

  @override
  String get clear => 'Verwerfen';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge aus deiner letzten Sitzung wiederhergestellt',
      one: '1 Eintrag aus deiner letzten Sitzung wiederhergestellt',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Gerade eben';

  @override
  String minutesAgo(Object count) {
    return 'vor $count Min.';
  }

  @override
  String hoursAgo(Object count) {
    return 'vor $count Std.';
  }

  @override
  String get general => 'Allgemein';

  @override
  String get noQuestionsInSection => 'Keine Fragen in diesem Abschnitt';

  @override
  String get skip => 'Überspringen';

  @override
  String get back => 'Zurück';

  @override
  String get skipOnboardingTitle => 'Einführung überspringen?';

  @override
  String get skipOnboardingMessage =>
      'Du gelangst direkt zur letzten Seite. Hier wird nichts eingerichtet – du kannst alles später in den Einstellungen ändern.';

  @override
  String get confessionHistoryTitle => 'Beichtverlauf';

  @override
  String get deleteAll => 'Alle löschen';

  @override
  String get editDate => 'Datum bearbeiten';

  @override
  String get confessionDate => 'Datum der Beichte';

  @override
  String get dateUpdated => 'Datum aktualisiert';

  @override
  String get changeDateConfirmTitle => 'Datum ändern?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Datum der Beichte auf $date ändern?';
  }

  @override
  String get noGuideContent => 'Keine Anleitung verfügbar';

  @override
  String get noGuideContentDesc => 'Die Anleitung erscheint hier';

  @override
  String get noFaqContent => 'Keine häufigen Fragen verfügbar';

  @override
  String get noFaqContentDesc => 'Häufig gestellte Fragen erscheinen hier';

  @override
  String get faqSubtitle => 'Eine Anleitung zum Sakrament der Versöhnung';

  @override
  String get tapToExpand => 'Tippen zum Weiterlesen';

  @override
  String get continueExamination => 'Gewissenserforschung fortsetzen';

  @override
  String get continueExaminationDesc =>
      'Du hast eine begonnene Gewissenserforschung';

  @override
  String examinationProgress(Object count) {
    return '$count Einträge ausgewählt';
  }

  @override
  String get security => 'Sicherheit';

  @override
  String get securitySubtitle => 'Schütze deine persönlichen Daten';

  @override
  String get pinAndBiometric => 'PIN & Biometrie';

  @override
  String get pinAndBiometricSubtitle => 'App-Sperre einrichten';

  @override
  String get enterPin => 'PIN eingeben';

  @override
  String get createPin => 'PIN erstellen';

  @override
  String get confirmPin => 'PIN bestätigen';

  @override
  String get incorrectPin => 'Falsche PIN';

  @override
  String get pinMismatch => 'Die PINs stimmen nicht überein';

  @override
  String get biometricUnlock => 'Biometrische Entsperrung';

  @override
  String get autoLockTimeout => 'Automatische Sperre';

  @override
  String get tooManyAttempts => 'Zu viele Fehlversuche';

  @override
  String tryAgainIn(Object time) {
    return 'Erneut versuchen in $time';
  }

  @override
  String get useBiometricUnlock => 'Biometrische Entsperrung verwenden';

  @override
  String get unlockWithFingerprintOrFace =>
      'Mit Fingerabdruck oder Gesicht entsperren';

  @override
  String get biometricAccessWarning =>
      'Jede Person, deren Fingerabdruck oder Gesicht auf diesem Gerät registriert ist, kann auf die App zugreifen';

  @override
  String get lockAfter => 'Sperren nach';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Zeit im Hintergrund bis zur Sperre';

  @override
  String get changePin => 'PIN ändern';

  @override
  String get updateYourSecurityPin => 'Ändere deine Sicherheits-PIN';

  @override
  String get enterCurrentPin => 'Aktuelle PIN eingeben';

  @override
  String get enterNewPin => 'Neue PIN eingeben';

  @override
  String get confirmNewPin => 'Neue PIN bestätigen';

  @override
  String get pinChangedSuccessfully => 'PIN erfolgreich geändert';

  @override
  String get currentPinIncorrect => 'Die aktuelle PIN ist falsch';

  @override
  String get enableBiometricUnlock => 'Biometrische Entsperrung aktivieren?';

  @override
  String get biometricDescription =>
      'Entsperre die App schnell und sicher mit deinem Fingerabdruck oder Gesicht.';

  @override
  String get notNow => 'Jetzt nicht';

  @override
  String get enable => 'Aktivieren';

  @override
  String get setUpPin => 'PIN einrichten';

  @override
  String get createSixDigitPin => 'Erstelle eine 6-stellige PIN';

  @override
  String get pinProtectData => 'Mit dieser PIN werden deine Daten geschützt';

  @override
  String get confirmYourPin => 'Bestätige deine PIN';

  @override
  String get enterSamePinAgain =>
      'Gib dieselbe PIN erneut ein, um sie zu bestätigen';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Gib deine PIN ein, um zu entsperren';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Versuche übrig',
      one: '1 Versuch übrig',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sekunden',
      one: '1 Sekunde',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '1 Minute',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Rückgängig';

  @override
  String get confessionDeleted => 'Beichte gelöscht';

  @override
  String get noConfessionHistory => 'Kein Beichtverlauf';

  @override
  String get noConfessionHistoryDesc =>
      'Abgeschlossene Beichten erscheinen hier';

  @override
  String get fontSize => 'Schriftgröße';

  @override
  String get fontSizeSubtitle =>
      'Passe die Textgröße für bessere Lesbarkeit an';

  @override
  String get fontSizeSmall => 'Klein';

  @override
  String get fontSizeMedium => 'Mittel';

  @override
  String get fontSizeLarge => 'Groß';

  @override
  String get fontSizeExtraLarge => 'Sehr groß';

  @override
  String get forgotPin => 'PIN vergessen?';

  @override
  String get resetPinTitle => 'PIN zurücksetzen';

  @override
  String get resetPinWarning =>
      'Warnung: Dadurch werden alle deine Daten dauerhaft gelöscht';

  @override
  String get resetPinDescription =>
      'Wenn du deine PIN zurücksetzt, werden alle deine Beichten, eigenen Sünden, Bußen und weiteren persönlichen Daten dauerhaft gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get resetPinConfirmation => 'Gib LÖSCHEN ein, um zu bestätigen';

  @override
  String get resetPinButton => 'PIN zurücksetzen & Daten löschen';

  @override
  String get resetPinSuccess =>
      'PIN zurückgesetzt. Bitte richte eine neue PIN ein.';

  @override
  String get resetPinError =>
      'PIN konnte nicht zurückgesetzt werden. Bitte versuche es erneut.';

  @override
  String get deleteConfirmationText => 'LÖSCHEN';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Bitte warte $seconds Sekunden';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Bestätige deine Identität, um die PIN zurückzusetzen';

  @override
  String get confessionGuideTitle => 'Wie man eine gute Beichte ablegt';

  @override
  String get shortFilmTitle => 'Die Beichte: ein Kurzfilm';

  @override
  String get shortFilmSubtitle =>
      'Produziert von Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Vereinigtes Königreich';

  @override
  String get confessionGuideSubtitle =>
      'Schritt für Schritt durch das Sakrament';

  @override
  String get invitationTitle => 'Kehrst du zur Beichte zurück?';

  @override
  String get invitationSubtitle => 'Ein Wort der Ermutigung für dich';

  @override
  String get invitationDialogTitle => 'Willkommen';

  @override
  String get invitationDialogContent =>
      'Ist dies deine erste Beichte seit Längerem, oder ist dir bang davor?';

  @override
  String get invitationDialogYes => 'Ja, ich möchte etwas Ermutigung';

  @override
  String get invitationDialogNo => 'Nein, ich bin bereit';

  @override
  String get invitationDialogDontShowAgain => 'Nicht mehr anzeigen';

  @override
  String get searchPrayers => 'Gebete suchen...';

  @override
  String get allCategories => 'Alle';

  @override
  String get appDisclaimer =>
      'Diese App ist eine geistliche Hilfe zur Vorbereitung auf die Beichte. Sie ersetzt nicht das Sakrament der Versöhnung bei einem Priester.';

  @override
  String get onboardingDisclaimer =>
      'Ein geistlicher Begleiter für die Beichte – kein Ersatz für sie.';

  @override
  String get readyToBegin => 'Alles bereit';

  @override
  String get readyToBeginSubtitle =>
      'Möge dein Weg zur Versöhnung erfüllt sein von Gnade und Frieden.';

  @override
  String get onboardingOverviewTitle => 'Was diese App tut';

  @override
  String get onboardingOverviewExamine =>
      'Bereite dein Gewissen vor, in deinem Tempo.';

  @override
  String get onboardingOverviewConfess =>
      'Eine diskrete Liste, damit nichts vergessen wird.';

  @override
  String get onboardingOverviewJournal =>
      'Eine kurze Rückschau am Abend, um zwischen den Beichten weiterzuwachsen.';

  @override
  String get onboardingOverviewFootnote =>
      'Gebete, Anleitungen und optionale Erinnerungen findest du darin.';

  @override
  String get onboardingPrivacyTitle => 'Vertraulich von Grund auf';

  @override
  String get onboardingPrivacyLocal =>
      'Alles bleibt auf diesem Telefon. Kein Konto, keine Cloud.';

  @override
  String get onboardingPrivacyEncrypted => 'Verschlüsselt auf deinem Gerät.';

  @override
  String get onboardingPrivacyPin =>
      'Du legst eine PIN fest, sobald du zum ersten Mal eine Gewissenserforschung oder dein Tagebuch öffnest.';

  @override
  String get sourceCode => 'Quellcode';

  @override
  String get contentReferences => 'Quellen der Inhalte';

  @override
  String get examinationModeTitle =>
      'Wie möchtest du dein Gewissen erforschen?';

  @override
  String get quickReviewMode => 'Kurze Durchsicht';

  @override
  String get quickReviewDescription => 'Alle Fragen nach Kategorie durchgehen';

  @override
  String get deepReflectionMode => 'Vertiefte Betrachtung';

  @override
  String get deepReflectionDescription =>
      'Eine Frage nach der anderen für eine gründliche Erforschung';

  @override
  String get contemplativePrayerTitle => 'Komm, Heiliger Geist';

  @override
  String get contemplativePrayerText =>
      'Erfülle mein Herz und entzünde in mir das Feuer deiner Liebe. Erleuchte meinen Verstand, damit ich meine Sünden klar erkenne.';

  @override
  String get imReady => 'Ich bin bereit';

  @override
  String get skipPrayer => 'Überspringen';

  @override
  String get yesThisApplies => 'Ja';

  @override
  String get noThisDoesnt => 'Nein';

  @override
  String get skipQuestion => 'Überspringen';

  @override
  String questionProgress(int current, int total) {
    return '$current von $total';
  }

  @override
  String get examinationComplete => 'Gewissenserforschung abgeschlossen';

  @override
  String get reviewYourSelections => 'Deine Auswahl durchsehen';

  @override
  String get examinationModeSettingTitle => 'Art der Gewissenserforschung';

  @override
  String get examinationModeSettingSubtitle =>
      'Wähle, wie du dein Gewissen erforschen möchtest';

  @override
  String get askEveryTime => 'Jedes Mal fragen';

  @override
  String get reminderNotificationTitle => 'Zeit für die Beichte';

  @override
  String get reminderNotificationBody =>
      'Denk daran, dein Gewissen zu erforschen und dich auf die Beichte vorzubereiten';

  @override
  String get notificationPermissionDenied =>
      'Mitteilungen sind deaktiviert. Erlaube Mitteilungen für Metanoia in den Geräteeinstellungen, um Beichterinnerungen zu erhalten.';

  @override
  String get openSourceLicenses => 'Open-Source-Lizenzen';

  @override
  String get couldNotOpenLink => 'Der Link konnte nicht geöffnet werden';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge gebeichtet',
      one: '1 Eintrag gebeichtet',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bußen',
      one: '1 Buße',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count offen',
      one: '1 offen',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count insgesamt',
      one: '1 insgesamt',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge',
      one: '1 Eintrag',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '1 Tag',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wo.',
      one: '1 Wo.',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Alle Beichten löschen?';

  @override
  String get deleteAllConfessionsContent =>
      'Damit wird dein gesamter Beichtverlauf endgültig gelöscht. Das lässt sich nicht rückgängig machen.';

  @override
  String get allConfessionsDeleted => 'Alle Beichten gelöscht';

  @override
  String get deletePenanceConfirm => 'Möchtest du diese Buße wirklich löschen?';

  @override
  String get completed => 'Verrichtet';

  @override
  String get tapToCollapse => 'Zum Zuklappen tippen';

  @override
  String get dismiss => 'Ausblenden';

  @override
  String showcaseStep(int current, int total) {
    return 'Schritt $current von $total';
  }

  @override
  String get done => 'Fertig';

  @override
  String get navigate => 'Öffnen';

  @override
  String get encouragement => 'Ermutigung';

  @override
  String get biometricPromptReason =>
      'Authentifiziere dich, um Metanoia zu öffnen';

  @override
  String get tryAgainInLabel => 'Erneut versuchen in';

  @override
  String get errorLoadingLanguage => 'Fehler beim Laden der Sprache';

  @override
  String get detailsNotSaved => 'Einzelheiten nicht gespeichert';

  @override
  String get discardStoredSinsTitle => 'Gespeicherte Sünden verwerfen?';

  @override
  String get discardStoredSinsContent =>
      'Der Beichtverlauf ist jetzt ausgeschaltet. Die aus früheren Beichten gespeicherten Sünden sind weiterhin abgelegt. Möchtest du sie verwerfen? Das Datum jeder Beichte bleibt erhalten, sodass deine Einblicke und Serien unversehrt bleiben.';

  @override
  String get keepThem => 'Behalten';

  @override
  String get discard => 'Verwerfen';

  @override
  String get storedSinsDiscarded =>
      'Gespeicherte Sünden verworfen. Das Datum jeder Beichte wurde behalten.';

  @override
  String get journalTitle => 'Tagebuch';

  @override
  String get journalHomeCardTitle => 'Rückschau am Abend';

  @override
  String get journalHomeCardSubtitle => 'Wie war dein Tag?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Tage der Rückschau in Folge';

  @override
  String get journalContinueToday => 'Heutigen Eintrag fortsetzen';

  @override
  String get journalPreviousMonth => 'Vorheriger Monat';

  @override
  String get journalNextMonth => 'Nächster Monat';

  @override
  String get journalGratitudeTitle => 'Dankbarkeit';

  @override
  String get journalGratitudePrompt => 'Wo habe ich Gott heute gesehen?';

  @override
  String get journalGratitudeHint =>
      'Eine Gnade, für die ich ihm danken möchte …';

  @override
  String get journalPresenceLead =>
      'Gott ist hier bei dir. Werde still vor ihm und danke ihm.';

  @override
  String get journalPresenceVerse => 'Lasst ab und erkennt, dass ich Gott bin.';

  @override
  String get journalPresenceRef => 'Psalm 46,11';

  @override
  String get journalLightTitle => 'Um Licht bitten';

  @override
  String get journalLightLead =>
      'Bitte den Heiligen Geist um Licht, um deinen Tag mit Gottes Augen zu sehen.';

  @override
  String get journalLightVerse =>
      'Komm, Heiliger Geist, erfülle die Herzen deiner Gläubigen und entzünde in ihnen das Feuer deiner Liebe.';

  @override
  String get journalReviewTitle => 'Rückschau mit Gott';

  @override
  String get journalReviewLead =>
      'Geh deinen Tag mit dem Herrn noch einmal durch: wo Liebe dir begegnet ist, wo du sie geschenkt hast und wo du dich abgewandt hast.';

  @override
  String get journalReviewVerse =>
      'Erforsche mich, Gott, und erkenne mein Herz, prüfe mich und erkenne meine Gedanken! Sieh doch, ob ich auf dem Weg der Götzen bin, leite mich auf dem Weg der Ewigkeit!';

  @override
  String get journalReviewRef => 'Psalm 139,23-24';

  @override
  String get journalReviewHint => 'Sprich mit ihm über deinen Tag…';

  @override
  String get journalReviewBringSin =>
      'Gibt es etwas, das du vor ihn bringen möchtest?';

  @override
  String get journalContritionTitle => 'Reue';

  @override
  String get journalContritionLead =>
      'Bring vor den Vater, was du gefunden hast; er läuft dir entgegen.';

  @override
  String get journalContritionVerse =>
      'Gott, sei mir gnädig nach deiner Huld, tilge meine Frevel nach deinem reichen Erbarmen!';

  @override
  String get journalContritionRef => 'Psalm 51,3';

  @override
  String get journalContritionPray => 'Bete das Reuegebet';

  @override
  String get journalContritionMercy =>
      'Die Reue, die aus Liebe zu Gott kommt, mit dem Vorsatz zu beichten, öffnet dein Herz heute Abend seiner Barmherzigkeit; ihre Fülle aber erwartet dich in der Beichte, in den Worten der Lossprechung.';

  @override
  String get journalResolutionLead =>
      'Ruhe in seiner Barmherzigkeit. Der morgige Tag beginnt neu in ihm.';

  @override
  String get journalResolutionVerse =>
      'Die Huld des HERRN ist nicht erschöpft, sein Erbarmen ist nicht zu Ende. Neu ist es an jedem Morgen; groß ist deine Treue.';

  @override
  String get journalResolutionRef => 'Klagelieder 3,22-23';

  @override
  String get journalReflectionTitle => 'Betrachtung';

  @override
  String get journalReflectionPrompt => 'Wie war dein Tag?';

  @override
  String get journalReflectionHint => 'Schreib frei heraus ...';

  @override
  String get journalSinsTitle => 'Sünden markieren';

  @override
  String get journalSinsPrompt => 'Worin habe ich heute gefehlt?';

  @override
  String get journalNoSinsMarked => 'Noch nichts markiert';

  @override
  String get journalAddSin => 'Sünde markieren';

  @override
  String get journalRemoveSin => 'Entfernen';

  @override
  String get journalResolutionTitle => 'Hoffnung und Vorsatz';

  @override
  String get journalResolutionPrompt => 'Ein Vorsatz für morgen';

  @override
  String get journalResolutionHint => 'Mit deiner Gnade werde ich morgen …';

  @override
  String get journalMoodTitle => 'Stimmung';

  @override
  String get journalMoodPrompt => 'Wie geht es deiner Seele heute Abend?';

  @override
  String get journalMoodDesolate => 'Trostlos';

  @override
  String get journalMoodStruggling => 'Ringend';

  @override
  String get journalMoodSteady => 'Gefestigt';

  @override
  String get journalMoodGrateful => 'Dankbar';

  @override
  String get journalMoodConsoled => 'Getröstet';

  @override
  String get journalSaved => 'Gespeichert';

  @override
  String get journalSaving => 'Wird gespeichert ...';

  @override
  String get journalDeleteEntry => 'Eintrag löschen';

  @override
  String get journalDeleteEntryConfirm =>
      'Den Eintrag dieses Tages löschen? Das lässt sich nicht rückgängig machen.';

  @override
  String get journalEntryDeleted => 'Eintrag gelöscht';

  @override
  String get journalPickerQuestions => 'Fragen';

  @override
  String get journalPickerMySins => 'Meine Sünden';

  @override
  String get journalPickerOwnWords => 'In eigenen Worten';

  @override
  String get journalPickerFreeTextHint =>
      'Beschreibe es in deinen eigenen Worten';

  @override
  String get journalSearchSins => 'Sünden suchen ...';

  @override
  String get journalAbsolved => 'Gebeichtet';

  @override
  String get journalSinCleared =>
      'Eine Sünde, die du zur Beichte gebracht hast';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Die $count in deinem Tagebuch markierten Sünden übernehmen',
      one: 'Die in deinem Tagebuch markierte Sünde übernehmen',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Übernehmen';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sünden aus deinem Tagebuch hinzugefügt',
      one: '1 Sünde aus deinem Tagebuch hinzugefügt',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Bereiche des Ringens';

  @override
  String get journalStruggleAreasSubtitle =>
      'Am häufigsten in deinem Tagebuch markiert';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Markierungen',
      one: '1 Markierung',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Tagebuch-Erinnerung';

  @override
  String get journalReminderSubtitle =>
      'Ein abendlicher Anstoß, auf deinen Tag zurückzuschauen';

  @override
  String get enableJournalReminder => 'Tagebuch-Erinnerung aktivieren';

  @override
  String get journalReminderNotificationTitle => 'Rückschau am Abend';

  @override
  String get journalReminderNotificationBody =>
      'Nimm dir einen Augenblick, um mit Gott auf deinen Tag zurückzuschauen';

  @override
  String get confessionDayMode => 'Beichtmodus';

  @override
  String get confessionDayModeDescription =>
      'Große, ablenkungsfreie Schrift für den Beichtstuhl';

  @override
  String get exitConfessionMode => 'Beichtmodus verlassen';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Schritt $current von $total';
  }

  @override
  String get next => 'Weiter';

  @override
  String get actOfContrition => 'Reuegebet (Akt der Reue)';

  @override
  String get actOfContritionUnavailable => 'Das Reuegebet ist nicht verfügbar';

  @override
  String get confessionDaySinsTitle => 'Zu beichtende Sünden';

  @override
  String get confessionDayOpeningTitle => 'Eröffnung';

  @override
  String get confessionDayOpeningIntro =>
      'Mach das Kreuzzeichen und beginne dann:';

  @override
  String get confessionDayOpeningFormula => 'Gelobt sei Jesus Christus.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Meine letzte Beichte ist $duration her.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Meine letzte Beichte war vor [Tagen/Wochen/Monaten/Jahren].';

  @override
  String get confessionDaySinsClosing =>
      'Diese und alle meine Sünden bereue ich von Herzen.';

  @override
  String get confessionDayThanksgivingTitle => 'Geh in Frieden';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Dankt dem Herrn, denn er ist gütig.';

  @override
  String get confessionDayThanksgivingResponse => 'Sein Erbarmen währt ewig.';

  @override
  String get confessionDayThanksgivingBody =>
      'Deine Seele ist reingewaschen. Verrichte deine Buße und geh weiter im Frieden Christi.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wochen',
      one: '1 Woche',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Monate',
      one: '1 Monat',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Jahre',
      one: '1 Jahr',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Fastenzeit';

  @override
  String get seasonHolyWeek => 'Karwoche';

  @override
  String get seasonAdvent => 'Advent';

  @override
  String get seasonChristmas => 'Weihnachtszeit';

  @override
  String get seasonEaster => 'Osterzeit';

  @override
  String get seasonOrdinaryTime => 'Jahreskreis';

  @override
  String get feastAshWednesday => 'Aschermittwoch';

  @override
  String get feastPalmSunday => 'Palmsonntag';

  @override
  String get feastEaster => 'Ostern';

  @override
  String get feastPentecost => 'Pfingsten';

  @override
  String get feastAssumption => 'Mariä Aufnahme in den Himmel';

  @override
  String get feastAllSaints => 'Allerheiligen';

  @override
  String get feastImmaculateConception => 'Mariä Empfängnis';

  @override
  String get feastFirstSundayOfAdvent => 'Der erste Adventssonntag';

  @override
  String get feastChristmas => 'Weihnachten';

  @override
  String get liturgicalLentTitle => 'Die Fastenzeit hat begonnen';

  @override
  String get liturgicalLentBody =>
      'Eine Zeit der Umkehr. Viele beginnen sie mit der Beichte.';

  @override
  String get liturgicalHolyWeekTitle => 'Die Karwoche hat begonnen';

  @override
  String get liturgicalHolyWeekBody =>
      'Die Kirche geht auf Ostern zu. Es bleibt noch Zeit, dein Herz zu bereiten.';

  @override
  String get liturgicalAdventTitle => 'Der Advent hat begonnen';

  @override
  String get liturgicalAdventBody =>
      'Eine Zeit des Wartens. Viele bereiten ihr Herz mit der Beichte.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast steht bevor';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count Tage — bereite dein Herz.',
      one: 'Noch ein Tag — bereite dein Herz.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Seit deiner letzten Beichte sind $count Wochen vergangen',
      one: 'Seit deiner letzten Beichte ist eine Woche vergangen',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Wann immer du bereit bist, die Barmherzigkeit wartet. Möchtest du dich vorbereiten?';

  @override
  String get promptPrepare => 'Vorbereiten';

  @override
  String get dataUnrecoverableTitle =>
      'Deine Daten können nicht entsperrt werden';

  @override
  String get dataUnrecoverableBody =>
      'Der Schlüssel, der deine Beichten schützt, ist auf diesem Gerät nicht mehr verfügbar. Das kann nach dem Wiederherstellen aus einer Sicherung geschehen oder wenn die Sicherheitseinstellungen des Geräts zurückgesetzt wurden.\n\nDa deine Daten verschlüsselt sind, können sie ohne diesen Schlüssel nicht wiederhergestellt werden — auch nicht von uns. Du kannst sie löschen und neu beginnen.';

  @override
  String get eraseAndStartOver => 'Löschen und neu beginnen';

  @override
  String get eraseAndStartOverConfirm =>
      'Damit wird alles, was auf diesem Gerät gespeichert ist, endgültig gelöscht, und die App beginnt von vorn. Das lässt sich nicht rückgängig machen.';

  @override
  String get penanceSaveFailed =>
      'Die Buße konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get confessionReminderChannelName => 'Beichterinnerungen';

  @override
  String get confessionReminderChannelDescription =>
      'Erinnerungen an die Beichte';

  @override
  String get journalReminderChannelName => 'Tagebuch-Erinnerungen';

  @override
  String get journalReminderChannelDescription =>
      'Tägliche Erinnerung an die abendliche Rückschau';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bisher $count benannt',
      one: 'Bisher eine benannt',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Bevor du beginnst';

  @override
  String get invitationCardAction => 'Sprich mir Mut zu';

  @override
  String get homeCtaBeginTitle => 'Beginne deine Gewissenserforschung';

  @override
  String get homeCtaBeginSubtitle => 'Bereite dein Herz vor der Beichte';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gewissenserforschung fortsetzen ($count ausgewählt)',
      one: 'Gewissenserforschung fortsetzen (1 ausgewählt)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle =>
      'Mach dort weiter, wo du aufgehört hast';

  @override
  String get homeCtaReadyTitle => 'Du bist bereit';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sünden warten in deiner Beichtliste',
      one: '1 Sünde wartet in deiner Beichtliste',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Verrichte deine Buße';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bußen warten noch',
      one: '1 Buße wartet noch',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Ermutigung, eine Schritt-für-Schritt-Anleitung, Gebete und häufige Fragen';

  @override
  String get homeQuoteReadMore => 'Mehr lesen';

  @override
  String get homeQuoteShowLess => 'Weniger anzeigen';

  @override
  String get tutorialJournalDesc =>
      'Schau jeden Abend auf deinen Tag zurück: eine kurze Rückschau und deine Serie.';
}
