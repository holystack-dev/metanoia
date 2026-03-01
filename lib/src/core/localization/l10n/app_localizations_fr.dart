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
  String get homeTitle => 'Bienvenue';

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
  String get getReminded => 'Soyez rappelé de vous confesser';

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
    return '$count sélectionnés';
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
  String get shareAppSubtitle => 'Partager avec amis et famille';

  @override
  String get rateApp => 'Noter l\'App';

  @override
  String get rateAppSubtitle => 'Notez-nous sur le Play Store';

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
  String get welcomeSubtitle => 'Votre guide pour une confession significative';

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
  String get addCustomSin => 'Ajouter Péché Personnalisé';

  @override
  String get editCustomSin => 'Modifier Péché Personnalisé';

  @override
  String get deleteCustomSin => 'Supprimer Péché Personnalisé';

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
  String get selectCommandment => 'Sélectionner Commandement (Optionnel)';

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
      'Êtes-vous sûr de vouloir supprimer ce péché personnalisé ?';

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
  String get addPenance => 'Ajouter Pénitence';

  @override
  String get editPenance => 'Modifier Pénitence';

  @override
  String get penanceDescription => 'Quelle pénitence vous a-t-on donnée ?';

  @override
  String get penanceHint =>
      'ex: Dire 3 Je vous salue Marie, Lire un passage...';

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
  String get skipPenance => 'Sauter';

  @override
  String get savePenance => 'Sauvegarder Pénitence';

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
    return '$count sélectionnés';
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
      'Cela supprimera toutes les questions sélectionnées. Êtes-vous sûr ?';

  @override
  String get clearDraft => 'Effacer le Brouillon';

  @override
  String get clear => 'Effacer';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restauré $count éléments de votre dernière session',
      one: 'Restauré 1 élément de votre dernière session',
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
      'Vous pourrez toujours accéder à l\'aide et aux paramètres plus tard depuis le menu.';

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
    return 'Changer la date de confession à $date ?';
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
  String get faqSubtitle => 'Un guide pour le Sacrement de Réconciliation';

  @override
  String get tapToExpand => 'Appuyez pour lire plus';

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
  String get enterPin => 'Entrer PIN';

  @override
  String get createPin => 'Créer PIN';

  @override
  String get confirmPin => 'Confirmer PIN';

  @override
  String get incorrectPin => 'PIN Incorrect';

  @override
  String get pinMismatch => 'Les PINs ne correspondent pas';

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
  String get changePin => 'Changer PIN';

  @override
  String get updateYourSecurityPin => 'Mettez à jour votre PIN de sécurité';

  @override
  String get enterCurrentPin => 'Entrer PIN Actuel';

  @override
  String get enterNewPin => 'Entrer Nouveau PIN';

  @override
  String get confirmNewPin => 'Confirmer Nouveau PIN';

  @override
  String get pinChangedSuccessfully => 'PIN changé avec succès';

  @override
  String get currentPinIncorrect => 'Le PIN actuel est incorrect';

  @override
  String get enableBiometricUnlock => 'Activer Déverrouillage Biométrique ?';

  @override
  String get biometricDescription =>
      'Utilisez votre empreinte ou visage pour déverrouiller l\'app rapidement et sûrement.';

  @override
  String get notNow => 'Pas Maintenant';

  @override
  String get enable => 'Activer';

  @override
  String get setUpPin => 'Configurer PIN';

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
  String get resetPinButton => 'Réinitialiser PIN & Supprimer Données';

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
      'Est-ce votre première confession depuis longtemps, ou vous sentez-vous anxieux d\'y aller ?';

  @override
  String get invitationDialogYes => 'Oui, j\'aimerais un peu d\'encouragement';

  @override
  String get invitationDialogNo => 'Non, je suis prêt à commencer';

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
      'Un compagnon spirituel pour la confession—pas un remplacement.';

  @override
  String get readyToBegin => 'Tout Est Prêt';

  @override
  String get readyToBeginSubtitle =>
      'Que votre chemin vers la réconciliation soit rempli de grâce et de paix.';

  @override
  String get sourceCode => 'Code Source';

  @override
  String get contentReferences => 'Références de Contenu';

  @override
  String get examinationModeTitle => 'Comment souhaitez-vous examiner?';

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
  String get imReady => 'Je Suis Prêt';

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
}
