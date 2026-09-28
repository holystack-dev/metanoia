// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get examineTitle => 'Examiner';

  @override
  String get confessTitle => 'Confesser';

  @override
  String get prayersTitle => 'Prières';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get examinationTitle => 'Examen';

  @override
  String get commandment => 'Commandement';

  @override
  String get guideTitle => 'Guide';

  @override
  String get faqTitle => 'Comprendre la Confession';

  @override
  String get language => 'Langue';

  @override
  String get chooseLanguage => 'Choisissez votre langue préférée';

  @override
  String get theme => 'Thème';

  @override
  String get chooseTheme => 'Choisissez votre thème préféré';

  @override
  String get system => 'Système';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get reminders => 'Rappels';

  @override
  String get getReminded => 'Recevez un rappel pour aller vous confesser';

  @override
  String get enableReminders => 'Activer les Rappels';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get biweekly => 'Tous les 15 jours';

  @override
  String get monthly => 'Mensuel';

  @override
  String get quarterly => 'Trimestriel';

  @override
  String get day => 'Jour';

  @override
  String get time => 'Heure';

  @override
  String get remindMe => 'Rappelez-moi';

  @override
  String get onTheDay => 'Le jour même';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours avant',
      one: '1 jour avant',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Actions Rapides';

  @override
  String get lastConfession => 'Dernière Confession';

  @override
  String get noneYet => 'Aucune encore';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count jours',
      one: 'il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Prochain Rappel';

  @override
  String get off => 'Désactivé';

  @override
  String get mon => 'Lun';

  @override
  String get tue => 'Mar';

  @override
  String get wed => 'Mer';

  @override
  String get thu => 'Jeu';

  @override
  String get fri => 'Ven';

  @override
  String get sat => 'Sam';

  @override
  String get sun => 'Dim';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get appLanguage => 'Langue de l\'App';

  @override
  String get appLanguageSubtitle =>
      'Langue pour les boutons, étiquettes et menus';

  @override
  String get contentLanguage => 'Langue du Contenu';

  @override
  String get contentLanguageSubtitle =>
      'Langue pour l\'examen, FAQs et prières';

  @override
  String get version => 'Version';

  @override
  String get selectDay => 'Sélectionner le Jour';

  @override
  String selected(num count) {
    return '$count sélectionné(s)';
  }

  @override
  String get selectedLabel => 'sélectionné';

  @override
  String get counter => 'Compteur';

  @override
  String get searchPlaceholder =>
      'Rechercher des commandements ou questions...';

  @override
  String get noResults => 'Aucun résultat trouvé';

  @override
  String get viewHistory => 'Voir l\'Historique';

  @override
  String get noActiveConfession => 'Pas de confession active';

  @override
  String get startExaminationPrompt =>
      'Commencez un examen pour ajouter des péchés ici.';

  @override
  String get startExamination => 'Commencer l\'Examen';

  @override
  String get finishConfessionTitle => 'Terminer la Confession ?';

  @override
  String get finishConfessionContent =>
      'Cela marquera la confession comme terminée et la déplacera dans votre historique.';

  @override
  String get cancel => 'Annuler';

  @override
  String get finish => 'Terminer';

  @override
  String get confessionCompletedMessage =>
      'Confession terminée ! Que Dieu vous bénisse.';

  @override
  String get finishConfession => 'Terminer la Confession';

  @override
  String get error => 'Erreur';

  @override
  String get retry => 'Réessayer';

  @override
  String get dailyQuoteError => 'La citation du jour n\'a pas pu être chargée.';

  @override
  String get keepHistory => 'Garder l\'Historique des Confessions';

  @override
  String get keepHistorySubtitle =>
      'Sauvegarde vos péchés avec la date. Si désactivé, seule la date sera sauvegardée.';

  @override
  String get deleteConfession => 'Supprimer la Confession';

  @override
  String get deleteConfessionContent =>
      'Cela supprimera définitivement cette confession et tous ses éléments de votre historique. Cette action ne peut pas être annulée.';

  @override
  String get tutorialExamineDesc =>
      'Commencez ici pour examiner votre conscience avant la confession.';

  @override
  String get tutorialConfessDesc =>
      'Utilisez ceci pendant la confession pour suivre vos péchés.';

  @override
  String get tutorialPrayersDesc =>
      'Trouvez des prières courantes pour avant et après la confession.';

  @override
  String get tutorialGuideDesc =>
      'Trouvez de l\'encouragement, un guide étape par étape et des FAQs ici.';

  @override
  String get tutorialSettingsDesc =>
      'Personnalisez votre expérience ici : changez la langue, le thème, définissez des rappels et gérez les paramètres de sécurité.';

  @override
  String get tutorialSwipeDesc =>
      'Glissez à gauche ou à droite pour naviguer entre les commandements.';

  @override
  String get tutorialSelectDesc =>
      'Appuyez sur n\'importe quelle question pour la sélectionner pour votre confession.';

  @override
  String get tutorialFinishDesc =>
      'Une fois terminé, appuyez ici pour finir et passer à la confession.';

  @override
  String get tutorialCounterDesc =>
      'Cela montre combien d\'éléments vous avez sélectionnés pour la confession.';

  @override
  String get tutorialMenuDesc =>
      'Accédez aux péchés personnalisés et effacez vos sélections d\'ici.';

  @override
  String get tutorialPenanceDesc =>
      'Suivez les pénitences données par votre confesseur ici.';

  @override
  String get tutorialInsightsDesc =>
      'Voyez les statistiques et séries de votre parcours de confession.';

  @override
  String get tutorialHistoryDesc =>
      'Accédez à vos confessions passées et leurs dates.';

  @override
  String get replayTutorial => 'Rejouer le Tutoriel';

  @override
  String get replayTutorialDesc =>
      'Voir le tutoriel de l\'application à nouveau';

  @override
  String get tutorialReset =>
      'Tutoriel réinitialisé ! Vous verrez les guides à nouveau.';

  @override
  String get about => 'À propos';

  @override
  String get aboutSubtitle => 'Version, licence et code source';

  @override
  String get shareApp => 'Partager l\'App';

  @override
  String get shareAppSubtitle => 'Partager avec vos amis et votre famille';

  @override
  String get rateApp => 'Noter l\'App';

  @override
  String get spreadShareTitle => 'Partager Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Vous connaissez quelqu\'un éloigné de la confession ? Aidez cette personne à revenir.';

  @override
  String get spreadShareAction => 'Partager';

  @override
  String get spreadRateSubtitle =>
      'Si Metanoia vous aide à vous préparer à la confession, une note aide les autres à le découvrir.';

  @override
  String get spreadRateAction => 'Noter';

  @override
  String get rateGateHint => 'Comment évalueriez-vous votre expérience ?';

  @override
  String get rateGateLowest => 'La plus basse';

  @override
  String get rateGateHighest => 'La plus haute';

  @override
  String get rateGateThanks => 'Merci — votre avis compte beaucoup pour nous.';

  @override
  String rateAppSubtitle(String store) {
    return 'Notez-nous sur $store';
  }

  @override
  String get website => 'Site Web';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get madeWithLove => 'Fait avec ❤️ par holystack.dev';

  @override
  String get rateDialogTitle => 'Vous aimez Metanoia ?';

  @override
  String get rateDialogContent =>
      'Si vous trouvez cette application utile, veuillez prendre un moment pour la noter. Cela nous aide beaucoup !';

  @override
  String get rateDialogYes => 'Noter Maintenant';

  @override
  String get rateDialogNo => 'Non, merci';

  @override
  String get rateDialogLater => 'Me rappeler plus tard';

  @override
  String get greekLabel => 'Grec';

  @override
  String get nounLabel => 'nom';

  @override
  String get metanoiaDefinition =>
      'Un changement profond d\'esprit et de cœur ; un éveil spirituel qui transforme tout l\'être et redirige la vie vers Dieu.';

  @override
  String get turnBackToGrace => 'Retour à la Grâce';

  @override
  String get welcomeSubtitle => 'Votre guide pour une confession fructueuse';

  @override
  String get discoverInnerGrace => 'Découvrez la Grâce Intérieure';

  @override
  String get sacredJourneyBegins =>
      'Un voyage sacré de réconciliation commence.';

  @override
  String get beginJourney => 'Commencer le Voyage';

  @override
  String get getStarted => 'Commencer';

  @override
  String get chooseContentLanguage => 'Choisir la Langue du Contenu';

  @override
  String get contentLanguageDescription =>
      'Sélectionnez la langue pour les prières, l\'examen et les guides';

  @override
  String get changeAnytimeNote =>
      'Vous pouvez changer cela à tout moment dans les Paramètres';

  @override
  String get continueButton => 'Continuer';

  @override
  String get examineDescription =>
      'Examinez votre conscience en utilisant les Dix Commandements avant la confession';

  @override
  String get confessDescription =>
      'Suivez vos péchés pendant la confession pour vous assurer de ne rien oublier';

  @override
  String get prayersDescription =>
      'Accédez aux prières pour avant et après la confession, et aux prières de pénitence';

  @override
  String get remindersDescription =>
      'Définissez des rappels réguliers dans les Paramètres pour ne jamais oublier de vous confesser';

  @override
  String get nextButton => 'Suivant';

  @override
  String get customSins => 'Péchés Personnalisés';

  @override
  String get manageCustomSins => 'Gérer les Péchés Personnalisés';

  @override
  String get addCustomSin => 'Ajouter un péché personnalisé';

  @override
  String get editCustomSin => 'Modifier le péché personnalisé';

  @override
  String get deleteCustomSin => 'Supprimer le péché personnalisé';

  @override
  String get sinDescription => 'Description du Péché';

  @override
  String get sinDescriptionHint =>
      'Décrivez le péché dont vous voulez vous souvenir';

  @override
  String get sinDescriptionRequired =>
      'Veuillez entrer une description du péché';

  @override
  String get optionalNote => 'Note Optionnelle';

  @override
  String get optionalNoteHint => 'Ajoutez des détails supplémentaires';

  @override
  String get selectCommandment => 'Choisir un commandement (facultatif)';

  @override
  String get noCommandment => 'Général / Pas de Commandement';

  @override
  String get customSinAdded => 'Péché personnalisé ajouté';

  @override
  String get customSinUpdated => 'Péché personnalisé mis à jour';

  @override
  String get customSinDeleted => 'Péché personnalisé supprimé';

  @override
  String get deleteCustomSinConfirm =>
      'Voulez-vous vraiment supprimer ce péché personnalisé ?';

  @override
  String get noCustomSins => 'Pas encore de péchés personnalisés';

  @override
  String get noCustomSinsDesc =>
      'Ajoutez des péchés personnalisés pour personnaliser votre examen';

  @override
  String get customVersion => 'Personnalisé (Modifié)';

  @override
  String get searchCustomSins => 'Rechercher péchés personnalisés...';

  @override
  String get addButton => 'Ajouter';

  @override
  String get updateButton => 'Mettre à jour';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get addYourOwn => 'Ajoutez le vôtre...';

  @override
  String get penance => 'Pénitence';

  @override
  String get penanceTracker => 'Suivi de Pénitence';

  @override
  String get addPenance => 'Ajouter une pénitence';

  @override
  String get editPenance => 'Modifier la pénitence';

  @override
  String get penanceDescription => 'Quelle pénitence vous a-t-on donnée ?';

  @override
  String get penanceHint =>
      'ex. : Dire 3 Je vous salue Marie, Lire un passage de l\'Écriture…';

  @override
  String get penanceAdded => 'Pénitence ajoutée';

  @override
  String get penanceUpdated => 'Pénitence mise à jour';

  @override
  String get penanceCompleted => 'Pénitence terminée ! Que Dieu vous bénisse.';

  @override
  String get markAsComplete => 'Marquer comme Terminée';

  @override
  String get pendingPenances => 'Pénitences en Attente';

  @override
  String get noPendingPenances => 'Pas de pénitences en attente';

  @override
  String get noPendingPenancesDesc =>
      'Toutes vos pénitences sont terminées. Que Dieu vous bénisse !';

  @override
  String completedOn(Object date) {
    return 'Terminée le $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Attribuée le $date';
  }

  @override
  String get skipPenance => 'Passer';

  @override
  String get savePenance => 'Enregistrer la pénitence';

  @override
  String get insights => 'Statistiques';

  @override
  String get confessionInsights => 'Statistiques de Confession';

  @override
  String get totalConfessions => 'Total des Confessions';

  @override
  String get averageFrequency => 'Fréquence Moyenne';

  @override
  String everyXDays(Object count) {
    return 'Tous les $count jours';
  }

  @override
  String get daysSinceLastConfession => 'Jours Depuis la Dernière';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaines',
      one: '1 semaine',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Activité Mensuelle';

  @override
  String get confessionsThisYear => 'Confessions Cette Année';

  @override
  String get noInsightsYet => 'Pas encore de statistiques';

  @override
  String get noInsightsYetDesc =>
      'Complétez votre première confession pour voir les statistiques de votre parcours spirituel';

  @override
  String get totalItemsConfessed => 'Total d\'Éléments Confessés';

  @override
  String get firstConfession => 'Première Confession';

  @override
  String get spiritualJourney => 'Votre Parcours Spirituel';

  @override
  String get listView => 'Liste';

  @override
  String get guidedView => 'Guidée';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current sur $total';
  }

  @override
  String get previousCommandment => 'Précédent';

  @override
  String get nextCommandment => 'Suivant';

  @override
  String get finishExamination => 'Terminer';

  @override
  String get noQuestionsSelected =>
      'Aucune question sélectionnée dans cette section';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count sélectionné(s)';
  }

  @override
  String get examinationSummary => 'Résumé de l\'Examen';

  @override
  String get examinationNote =>
      'Un examen de conscience approfondi va au-delà de toute liste. Réfléchissez dans la prière sur votre état de vie et vos circonstances.';

  @override
  String selectedCount(Object count) {
    return '$count éléments sélectionnés';
  }

  @override
  String get noSinsSelected => 'Aucun péché sélectionné';

  @override
  String get continueEditing => 'Continuer l\'Édition';

  @override
  String get proceedToConfess => 'Procéder';

  @override
  String get clearDraftTitle => 'Effacer le Brouillon ?';

  @override
  String get clearDraftMessage =>
      'Cela supprimera toutes les questions sélectionnées. Voulez-vous vraiment continuer ?';

  @override
  String get clearDraft => 'Effacer le Brouillon';

  @override
  String get clear => 'Effacer';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments restaurés de votre dernière session',
      one: '1 élément restauré de votre dernière session',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'À l\'instant';

  @override
  String minutesAgo(Object count) {
    return 'il y a ${count}m';
  }

  @override
  String hoursAgo(Object count) {
    return 'il y a ${count}h';
  }

  @override
  String get general => 'Général';

  @override
  String get noQuestionsInSection => 'Pas de questions dans cette section';

  @override
  String get skip => 'Passer';

  @override
  String get back => 'Retour';

  @override
  String get skipOnboardingTitle => 'Passer l\'Introduction ?';

  @override
  String get skipOnboardingMessage =>
      'Vous irez directement à la dernière page. Rien n\'est configuré ici : vous pourrez tout modifier plus tard dans les paramètres.';

  @override
  String get confessionHistoryTitle => 'Historique des Confessions';

  @override
  String get deleteAll => 'Tout Supprimer';

  @override
  String get editDate => 'Modifier la Date';

  @override
  String get confessionDate => 'Date de Confession';

  @override
  String get dateUpdated => 'Date mise à jour';

  @override
  String get changeDateConfirmTitle => 'Changer la Date ?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Remplacer la date de confession par le $date ?';
  }

  @override
  String get noGuideContent => 'Contenu du guide non disponible';

  @override
  String get noGuideContentDesc => 'Le contenu du guide apparaîtra ici';

  @override
  String get noFaqContent => 'FAQs non disponibles';

  @override
  String get noFaqContentDesc => 'Les questions fréquentes apparaîtront ici';

  @override
  String get faqSubtitle => 'Un guide pour le sacrement de la Réconciliation';

  @override
  String get tapToExpand => 'Appuyez pour en lire plus';

  @override
  String get continueExamination => 'Continuer l\'Examen';

  @override
  String get continueExaminationDesc => 'Vous avez un examen en cours';

  @override
  String examinationProgress(Object count) {
    return '$count éléments sélectionnés';
  }

  @override
  String get security => 'Sécurité';

  @override
  String get securitySubtitle => 'Protégez vos données personnelles';

  @override
  String get pinAndBiometric => 'PIN & Biométrie';

  @override
  String get pinAndBiometricSubtitle => 'Configurer le verrouillage de l\'app';

  @override
  String get enterPin => 'Saisir le code PIN';

  @override
  String get createPin => 'Créer un code PIN';

  @override
  String get confirmPin => 'Confirmer le code PIN';

  @override
  String get incorrectPin => 'PIN Incorrect';

  @override
  String get pinMismatch => 'Les codes PIN ne correspondent pas';

  @override
  String get biometricUnlock => 'Déverrouillage Biométrique';

  @override
  String get autoLockTimeout => 'Délai de Verrouillage Auto';

  @override
  String get tooManyAttempts => 'Trop de tentatives échouées';

  @override
  String tryAgainIn(Object time) {
    return 'Réessayez dans $time';
  }

  @override
  String get useBiometricUnlock => 'Utiliser Déverrouillage Biométrique';

  @override
  String get unlockWithFingerprintOrFace =>
      'Déverrouiller avec empreinte ou visage';

  @override
  String get biometricAccessWarning =>
      'Toute personne ayant une empreinte digitale ou un visage enregistré sur cet appareil pourra accéder à l\'application';

  @override
  String get lockAfter => 'Verrouiller Après';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Temps en arrière-plan avant verrouillage';

  @override
  String get changePin => 'Changer le code PIN';

  @override
  String get updateYourSecurityPin => 'Mettez à jour votre PIN de sécurité';

  @override
  String get enterCurrentPin => 'Saisir le PIN actuel';

  @override
  String get enterNewPin => 'Saisir le nouveau PIN';

  @override
  String get confirmNewPin => 'Confirmer le nouveau PIN';

  @override
  String get pinChangedSuccessfully => 'PIN changé avec succès';

  @override
  String get currentPinIncorrect => 'Le PIN actuel est incorrect';

  @override
  String get enableBiometricUnlock => 'Activer Déverrouillage Biométrique ?';

  @override
  String get biometricDescription =>
      'Utilisez votre empreinte ou votre visage pour déverrouiller l\'app rapidement et en toute sécurité.';

  @override
  String get notNow => 'Pas Maintenant';

  @override
  String get enable => 'Activer';

  @override
  String get setUpPin => 'Configurer un code PIN';

  @override
  String get createSixDigitPin => 'Créez un PIN à 6 chiffres';

  @override
  String get pinProtectData => 'Ce PIN sera utilisé pour protéger vos données';

  @override
  String get confirmYourPin => 'Confirmez votre PIN';

  @override
  String get enterSamePinAgain => 'Entrez le même PIN à nouveau pour confirmer';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Entrez votre PIN pour déverrouiller';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tentatives restantes',
      one: '1 tentative restante',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondes',
      one: '1 seconde',
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
  String get undo => 'Annuler';

  @override
  String get confessionDeleted => 'Confession supprimée';

  @override
  String get noConfessionHistory => 'Pas d\'historique de confession';

  @override
  String get noConfessionHistoryDesc =>
      'Les confessions terminées apparaîtront ici';

  @override
  String get fontSize => 'Taille de Police';

  @override
  String get fontSizeSubtitle =>
      'Ajuster la taille du texte pour une meilleure lisibilité';

  @override
  String get fontSizeSmall => 'Petit';

  @override
  String get fontSizeMedium => 'Moyen';

  @override
  String get fontSizeLarge => 'Grand';

  @override
  String get fontSizeExtraLarge => 'Très Grand';

  @override
  String get forgotPin => 'PIN Oublié ?';

  @override
  String get resetPinTitle => 'Réinitialiser PIN';

  @override
  String get resetPinWarning =>
      'Attention : Cela supprimera définitivement toutes vos données';

  @override
  String get resetPinDescription =>
      'Si vous réinitialisez votre PIN, toutes vos confessions, péchés personnalisés, pénitences et autres données personnelles seront supprimés définitivement. Cette action ne peut pas être annulée.';

  @override
  String get resetPinConfirmation => 'Tapez SUPPRIMER pour confirmer';

  @override
  String get resetPinButton => 'Réinitialiser le PIN et supprimer les données';

  @override
  String get resetPinSuccess =>
      'PIN réinitialisé avec succès. Veuillez configurer un nouveau PIN.';

  @override
  String get resetPinError =>
      'Échec de la réinitialisation du PIN. Veuillez réessayer.';

  @override
  String get deleteConfirmationText => 'SUPPRIMER';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Veuillez patienter $seconds secondes';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Vérifiez votre identité pour réinitialiser le PIN';

  @override
  String get confessionGuideTitle => 'Comment faire une bonne confession';

  @override
  String get shortFilmTitle => 'La confession : un court-métrage';

  @override
  String get shortFilmSubtitle =>
      'Créé par Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Royaume-Uni';

  @override
  String get confessionGuideSubtitle =>
      'Guide étape par étape pour le Sacrement';

  @override
  String get invitationTitle => 'Retour à la Confession ?';

  @override
  String get invitationSubtitle => 'Un mot d\'encouragement pour vous';

  @override
  String get invitationDialogTitle => 'Bienvenue';

  @override
  String get invitationDialogContent =>
      'Est-ce votre première confession depuis longtemps, ou éprouvez-vous de l\'appréhension à l\'idée d\'y aller ?';

  @override
  String get invitationDialogYes => 'Oui, j\'aimerais un peu d\'encouragement';

  @override
  String get invitationDialogNo => 'Non, je peux commencer';

  @override
  String get invitationDialogDontShowAgain => 'Ne plus montrer ceci';

  @override
  String get searchPrayers => 'Rechercher des prières...';

  @override
  String get allCategories => 'Toutes';

  @override
  String get appDisclaimer =>
      'Cette application est une aide spirituelle pour la préparation à la confession. Elle ne remplace pas le Sacrement de la Réconciliation avec un prêtre.';

  @override
  String get onboardingDisclaimer =>
      'Un compagnon spirituel pour la confession — mais qui ne la remplace pas.';

  @override
  String get readyToBegin => 'Tout Est Prêt';

  @override
  String get readyToBeginSubtitle =>
      'Que votre chemin vers la réconciliation soit rempli de grâce et de paix.';

  @override
  String get onboardingOverviewTitle => 'Ce que fait cette application';

  @override
  String get onboardingOverviewExamine =>
      'Préparez votre conscience, à votre rythme.';

  @override
  String get onboardingOverviewConfess =>
      'Une liste discrète, pour ne rien oublier.';

  @override
  String get onboardingOverviewJournal =>
      'Une brève réflexion du soir, pour continuer à grandir entre les confessions.';

  @override
  String get onboardingOverviewFootnote =>
      'Les prières, les guides et les rappels facultatifs sont à l\'intérieur.';

  @override
  String get onboardingPrivacyTitle => 'Confidentiel par conception';

  @override
  String get onboardingPrivacyLocal =>
      'Tout reste sur ce téléphone. Aucun compte, aucun cloud.';

  @override
  String get onboardingPrivacyEncrypted => 'Chiffré sur votre appareil.';

  @override
  String get onboardingPrivacyPin =>
      'Vous créerez un code PIN la première fois que vous ouvrirez un examen ou votre journal.';

  @override
  String get sourceCode => 'Code Source';

  @override
  String get contentReferences => 'Références de Contenu';

  @override
  String get examinationModeTitle =>
      'Comment souhaitez-vous faire votre examen ?';

  @override
  String get quickReviewMode => 'Revue Rapide';

  @override
  String get quickReviewDescription =>
      'Parcourez toutes les questions par catégorie';

  @override
  String get deepReflectionMode => 'Réflexion Profonde';

  @override
  String get deepReflectionDescription =>
      'Une question à la fois pour un examen réfléchi';

  @override
  String get contemplativePrayerTitle => 'Viens, Esprit Saint';

  @override
  String get contemplativePrayerText =>
      'Remplis mon cœur et allume en moi le feu de Ton amour. Éclaire mon esprit pour que je puisse voir clairement mes péchés.';

  @override
  String get imReady => 'Commençons';

  @override
  String get skipPrayer => 'Passer';

  @override
  String get yesThisApplies => 'Oui';

  @override
  String get noThisDoesnt => 'Non';

  @override
  String get skipQuestion => 'Passer';

  @override
  String questionProgress(int current, int total) {
    return '$current sur $total';
  }

  @override
  String get examinationComplete => 'Examen Terminé';

  @override
  String get reviewYourSelections => 'Passez en revue vos sélections';

  @override
  String get examinationModeSettingTitle => 'Mode d\'Examen';

  @override
  String get examinationModeSettingSubtitle =>
      'Choisissez comment vous souhaitez examiner votre conscience';

  @override
  String get askEveryTime => 'Demander à Chaque Fois';

  @override
  String get reminderNotificationTitle => 'C\'est l\'heure de la confession';

  @override
  String get reminderNotificationBody =>
      'Pensez à examiner votre conscience et à vous préparer à la confession';

  @override
  String get notificationPermissionDenied =>
      'Les notifications sont désactivées. Autorisez les notifications pour Metanoia dans les réglages de votre appareil afin de recevoir les rappels de confession.';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String get couldNotOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments confessés',
      one: '1 élément confessé',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pénitences',
      one: '1 pénitence',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count en attente',
      one: '1 en attente',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count au total',
      one: '1 au total',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments',
      one: '1 élément',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sem',
      one: '1 sem',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Supprimer toutes les confessions ?';

  @override
  String get deleteAllConfessionsContent =>
      'Cela supprimera définitivement tout votre historique de confessions. Cette action ne peut pas être annulée.';

  @override
  String get allConfessionsDeleted =>
      'Toutes les confessions ont été supprimées';

  @override
  String get deletePenanceConfirm =>
      'Voulez-vous vraiment supprimer cette pénitence ?';

  @override
  String get completed => 'Terminée';

  @override
  String get tapToCollapse => 'Appuyez pour réduire';

  @override
  String get dismiss => 'Fermer';

  @override
  String showcaseStep(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get done => 'Terminé';

  @override
  String get navigate => 'Naviguer';

  @override
  String get encouragement => 'Encouragement';

  @override
  String get biometricPromptReason =>
      'Authentifiez-vous pour accéder à Metanoia';

  @override
  String get tryAgainInLabel => 'Réessayez dans';

  @override
  String get errorLoadingLanguage => 'Erreur lors du chargement de la langue';

  @override
  String get detailsNotSaved => 'Détails non enregistrés';

  @override
  String get discardStoredSinsTitle => 'Supprimer les péchés enregistrés ?';

  @override
  String get discardStoredSinsContent =>
      'L\'historique des confessions est désormais désactivé. Les péchés déjà enregistrés lors de confessions passées sont toujours conservés. Les supprimer ? Les dates seront conservées, afin que vos statistiques et vos séries restent intactes.';

  @override
  String get keepThem => 'Les conserver';

  @override
  String get discard => 'Supprimer';

  @override
  String get storedSinsDiscarded =>
      'Péchés enregistrés supprimés. Les dates de confession ont été conservées.';

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalHomeCardTitle => 'Réflexion du soir';

  @override
  String get journalHomeCardSubtitle => 'Comment s\'est passée votre journée ?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Jours de réflexion d\'affilée';

  @override
  String get journalContinueToday => 'Poursuivre l\'entrée du jour';

  @override
  String get journalPreviousMonth => 'Mois précédent';

  @override
  String get journalNextMonth => 'Mois suivant';

  @override
  String get journalGratitudeTitle => 'Gratitude';

  @override
  String get journalGratitudePrompt => 'Où ai-je vu Dieu aujourd\'hui ?';

  @override
  String get journalGratitudeHint => 'Une grâce dont je veux Le remercier…';

  @override
  String get journalPresenceLead =>
      'Dieu est ici avec toi. Fais silence devant Lui et rends grâce.';

  @override
  String get journalPresenceVerse => 'Arrêtez ! Sachez que je suis Dieu.';

  @override
  String get journalPresenceRef => 'Psaume 45 (46), 11';

  @override
  String get journalLightTitle => 'Demande la lumière';

  @override
  String get journalLightLead =>
      'Demande à l\'Esprit Saint la lumière pour voir ta journée comme Dieu la voit.';

  @override
  String get journalLightVerse =>
      'Viens, Esprit Saint, remplis les cœurs de tes fidèles et allume en eux le feu de ton amour.';

  @override
  String get journalReviewTitle => 'Relis ta journée avec Dieu';

  @override
  String get journalReviewLead =>
      'Reparcours ta journée avec le Seigneur : où l\'amour est venu à toi, où tu l\'as donné, et où tu t\'es détourné.';

  @override
  String get journalReviewVerse =>
      'Scrute-moi, mon Dieu, tu sauras ma pensée ; éprouve-moi, tu connaîtras mon cœur. Vois si je prends le chemin des idoles, et conduis-moi sur le chemin d\'éternité.';

  @override
  String get journalReviewRef => 'Psaume 138 (139), 23-24';

  @override
  String get journalReviewHint => 'Parle-Lui de ta journée…';

  @override
  String get journalReviewBringSin =>
      'Y a-t-il quelque chose que tu veux Lui apporter ?';

  @override
  String get journalContritionTitle => 'Contrition';

  @override
  String get journalContritionLead =>
      'Apporte au Père ce que tu as trouvé ; Il court à ta rencontre.';

  @override
  String get journalContritionVerse =>
      'Pitié pour moi, mon Dieu, dans ton amour, selon ta grande miséricorde, efface mon péché.';

  @override
  String get journalContritionRef => 'Psaume 50 (51), 3';

  @override
  String get journalContritionPray => 'Récite l\'acte de contrition';

  @override
  String get journalContritionMercy =>
      'La douleur née de l\'amour de Dieu, avec la résolution de te confesser, ouvre ton cœur à sa miséricorde ce soir ; et sa plénitude t\'attend dans la Confession, dans les paroles de l\'absolution.';

  @override
  String get journalResolutionLead =>
      'Repose-toi dans sa miséricorde. Demain recommence en Lui.';

  @override
  String get journalResolutionVerse =>
      'Grâce à l\'amour du Seigneur, nous ne sommes pas anéantis ; ses tendresses ne s\'épuisent pas ; elles se renouvellent chaque matin, – oui, ta fidélité surabonde.';

  @override
  String get journalResolutionRef => 'Lamentations 3, 22-23';

  @override
  String get journalReflectionTitle => 'Réflexion';

  @override
  String get journalReflectionPrompt => 'Comment s\'est passée ta journée ?';

  @override
  String get journalReflectionHint => 'Écris librement...';

  @override
  String get journalSinsTitle => 'Marquer les péchés';

  @override
  String get journalSinsPrompt => 'Où ai-je manqué aujourd\'hui ?';

  @override
  String get journalNoSinsMarked => 'Rien de marqué pour l\'instant';

  @override
  String get journalAddSin => 'Marquer un péché';

  @override
  String get journalRemoveSin => 'Retirer';

  @override
  String get journalResolutionTitle => 'Espérance et résolution';

  @override
  String get journalResolutionPrompt => 'Une grâce pour demain';

  @override
  String get journalResolutionHint => 'Avec ta grâce, demain je vais…';

  @override
  String get journalMoodTitle => 'État d\'âme';

  @override
  String get journalMoodPrompt => 'Comment va ton âme ce soir ?';

  @override
  String get journalMoodDesolate => 'Désolation';

  @override
  String get journalMoodStruggling => 'Lutte';

  @override
  String get journalMoodSteady => 'Sérénité';

  @override
  String get journalMoodGrateful => 'Gratitude';

  @override
  String get journalMoodConsoled => 'Consolation';

  @override
  String get journalSaved => 'Enregistré';

  @override
  String get journalSaving => 'Enregistrement...';

  @override
  String get journalDeleteEntry => 'Supprimer l\'entrée';

  @override
  String get journalDeleteEntryConfirm =>
      'Supprimer l\'entrée de ce jour ? Cette action est irréversible.';

  @override
  String get journalEntryDeleted => 'Entrée supprimée';

  @override
  String get journalPickerQuestions => 'Questions';

  @override
  String get journalPickerMySins => 'Mes péchés';

  @override
  String get journalPickerOwnWords => 'Dans mes mots';

  @override
  String get journalPickerFreeTextHint => 'Décris-le avec tes propres mots';

  @override
  String get journalSearchSins => 'Rechercher des péchés...';

  @override
  String get journalAbsolved => 'Confessé';

  @override
  String get journalSinCleared => 'Un péché porté à la confession';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Inclure les $count péchés notés dans votre journal',
      one: 'Inclure le péché noté dans votre journal',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Inclure';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count péchés ajoutés depuis votre journal',
      one: '1 péché ajouté depuis votre journal',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Points de combat';

  @override
  String get journalStruggleAreasSubtitle =>
      'Ce que vous notez le plus souvent dans votre journal';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: '1 note',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Rappel du journal';

  @override
  String get journalReminderSubtitle =>
      'Une invitation chaque soir à relire votre journée';

  @override
  String get enableJournalReminder => 'Activer le rappel du journal';

  @override
  String get journalReminderNotificationTitle => 'Relecture du soir';

  @override
  String get journalReminderNotificationBody =>
      'Prenez un instant pour relire votre journée avec Dieu';

  @override
  String get confessionDayMode => 'Mode Confession';

  @override
  String get confessionDayModeDescription =>
      'Texte agrandi et sans distraction pour le confessionnal';

  @override
  String get exitConfessionMode => 'Quitter le mode confession';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get next => 'Suivant';

  @override
  String get actOfContrition => 'Acte de Contrition';

  @override
  String get actOfContritionUnavailable =>
      'L\'Acte de Contrition n\'est pas disponible';

  @override
  String get confessionDaySinsTitle => 'Péchés à confesser';

  @override
  String get confessionDayOpeningTitle => 'Ouverture';

  @override
  String get confessionDayOpeningIntro =>
      'Fais le signe de croix, puis commence :';

  @override
  String get confessionDayOpeningFormula =>
      'Bénissez-moi, mon Père, parce que j\'ai péché.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Ma dernière confession remonte à $duration.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Cela fait [jours/semaines/mois/années] depuis ma dernière confession.';

  @override
  String get confessionDaySinsClosing =>
      'Pour ces péchés et tous ceux de ma vie passée, je demande pardon à Dieu.';

  @override
  String get confessionDayThanksgivingTitle => 'Allez en paix';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Rendez grâce au Seigneur, car Il est bon.';

  @override
  String get confessionDayThanksgivingResponse => 'Car éternel est son amour.';

  @override
  String get confessionDayThanksgivingBody =>
      'Ton âme a été lavée. Accomplis ta pénitence et avance dans la paix du Christ.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaines',
      one: '1 semaine',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mois',
      one: '1 mois',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '1 an',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Carême';

  @override
  String get seasonHolyWeek => 'Semaine Sainte';

  @override
  String get seasonAdvent => 'Avent';

  @override
  String get seasonChristmas => 'Noël';

  @override
  String get seasonEaster => 'Pâques';

  @override
  String get seasonOrdinaryTime => 'Temps Ordinaire';

  @override
  String get feastAshWednesday => 'Le Mercredi des Cendres';

  @override
  String get feastPalmSunday => 'Le Dimanche des Rameaux';

  @override
  String get feastEaster => 'Pâques';

  @override
  String get feastPentecost => 'La Pentecôte';

  @override
  String get feastAssumption => 'L\'Assomption';

  @override
  String get feastAllSaints => 'La Toussaint';

  @override
  String get feastImmaculateConception => 'L\'Immaculée Conception';

  @override
  String get feastFirstSundayOfAdvent => 'Le premier dimanche de l\'Avent';

  @override
  String get feastChristmas => 'Noël';

  @override
  String get liturgicalLentTitle => 'Le Carême a commencé';

  @override
  String get liturgicalLentBody =>
      'Un temps pour revenir à Dieu. Beaucoup le commencent par la confession.';

  @override
  String get liturgicalHolyWeekTitle => 'La Semaine Sainte a commencé';

  @override
  String get liturgicalHolyWeekBody =>
      'L\'Église marche vers Pâques. Il est encore temps de préparer votre cœur.';

  @override
  String get liturgicalAdventTitle => 'L\'Avent a commencé';

  @override
  String get liturgicalAdventBody =>
      'Un temps d\'attente. Beaucoup préparent leur cœur par la confession.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast approche';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dans $count jours : préparez votre cœur.',
      one: 'Dans un jour : préparez votre cœur.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count semaines se sont écoulées depuis votre dernière confession',
      one: 'Une semaine s\'est écoulée depuis votre dernière confession',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Quand vous le voudrez, la miséricorde vous attend. Souhaitez-vous vous préparer ?';

  @override
  String get promptPrepare => 'Me préparer';

  @override
  String get dataUnrecoverableTitle =>
      'Vos données ne peuvent pas être déverrouillées';

  @override
  String get dataUnrecoverableBody =>
      'La clé qui protège vos confessions n\'est plus disponible sur cet appareil. Cela peut arriver après la restauration d\'une sauvegarde ou si les paramètres de sécurité de l\'appareil ont été réinitialisés.\n\nVos données étant chiffrées, elles ne peuvent pas être récupérées sans cette clé, pas même par nous. Vous pouvez les effacer et recommencer.';

  @override
  String get eraseAndStartOver => 'Effacer et recommencer';

  @override
  String get eraseAndStartOverConfirm =>
      'Cela efface définitivement tout ce qui est enregistré sur cet appareil et réinitialise l\'application. Cette action est irréversible.';

  @override
  String get penanceSaveFailed =>
      'Impossible d\'enregistrer la pénitence. Veuillez réessayer.';

  @override
  String get confessionReminderChannelName => 'Rappels de confession';

  @override
  String get confessionReminderChannelDescription =>
      'Rappels pour se confesser';

  @override
  String get journalReminderChannelName => 'Rappels du journal';

  @override
  String get journalReminderChannelDescription =>
      'Rappel quotidien pour écrire la réflexion du soir';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count points relevés jusqu\'ici',
      one: 'Un point relevé jusqu\'ici',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Avant de commencer';

  @override
  String get invitationCardAction => 'Encouragez-moi';

  @override
  String get homeCtaBeginTitle => 'Commencez votre examen de conscience';

  @override
  String get homeCtaBeginSubtitle => 'Préparez votre cœur avant la confession';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Poursuivez votre examen ($count sélectionnés)',
      one: 'Poursuivez votre examen (1 sélectionné)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Reprenez où vous en étiez';

  @override
  String get homeCtaReadyTitle => 'Vous pouvez commencer';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count péchés vous attendent dans votre liste de confession',
      one: '1 péché vous attend dans votre liste de confession',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Accomplissez votre pénitence';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pénitences restent à accomplir',
      one: '1 pénitence reste à accomplir',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Encouragement, guide pas à pas, prières et questions fréquentes';

  @override
  String get homeQuoteReadMore => 'Lire la suite';

  @override
  String get homeQuoteShowLess => 'Réduire';

  @override
  String get tutorialJournalDesc =>
      'Relisez votre journée chaque soir : une courte réflexion, et votre série.';
}
