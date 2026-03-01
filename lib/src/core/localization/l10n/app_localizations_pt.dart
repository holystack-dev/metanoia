// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Bem-vindo';

  @override
  String get examineTitle => 'Examinar';

  @override
  String get confessTitle => 'Confessar';

  @override
  String get prayersTitle => 'Orações';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get examinationTitle => 'Exame';

  @override
  String get commandment => 'Mandamento';

  @override
  String get guideTitle => 'Guia';

  @override
  String get faqTitle => 'Entendendo a Confissão';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Escolha seu idioma preferido';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Escolha seu tema preferido';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get reminders => 'Lembretes';

  @override
  String get getReminded => 'Seja lembrado de confessar';

  @override
  String get enableReminders => 'Ativar Lembretes';

  @override
  String get weekly => 'Semanalmente';

  @override
  String get biweekly => 'Quinzenalmente';

  @override
  String get monthly => 'Mensalmente';

  @override
  String get quarterly => 'Trimestralmente';

  @override
  String get day => 'Dia';

  @override
  String get time => 'Hora';

  @override
  String get remindMe => 'Lembrar-me';

  @override
  String get onTheDay => 'No dia';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias antes',
      one: '1 dia antes',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Ações Rápidas';

  @override
  String get lastConfession => 'Última Confissão';

  @override
  String get noneYet => 'Nenhuma ainda';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count dias',
      one: 'há 1 dia',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Próximo Lembrete';

  @override
  String get off => 'Desligado';

  @override
  String get mon => 'Seg';

  @override
  String get tue => 'Ter';

  @override
  String get wed => 'Qua';

  @override
  String get thu => 'Qui';

  @override
  String get fri => 'Sex';

  @override
  String get sat => 'Sáb';

  @override
  String get sun => 'Dom';

  @override
  String get monday => 'Segunda-feira';

  @override
  String get tuesday => 'Terça-feira';

  @override
  String get wednesday => 'Quarta-feira';

  @override
  String get thursday => 'Quinta-feira';

  @override
  String get friday => 'Sexta-feira';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get appLanguage => 'Idioma do App';

  @override
  String get appLanguageSubtitle => 'Idioma para botões, rótulos e menus';

  @override
  String get contentLanguage => 'Idioma do Conteúdo';

  @override
  String get contentLanguageSubtitle => 'Idioma para exame, FAQs e orações';

  @override
  String get version => 'Versão';

  @override
  String get selectDay => 'Selecionar Dia';

  @override
  String selected(num count) {
    return '$count selecionados';
  }

  @override
  String get selectedLabel => 'selecionado';

  @override
  String get counter => 'Contador';

  @override
  String get searchPlaceholder => 'Buscar mandamentos ou perguntas...';

  @override
  String get noResults => 'Nenhum resultado encontrado';

  @override
  String get viewHistory => 'Ver Histórico';

  @override
  String get noActiveConfession => 'Nenhuma confissão ativa';

  @override
  String get startExaminationPrompt =>
      'Inicie um exame para adicionar pecados aqui.';

  @override
  String get startExamination => 'Iniciar Exame';

  @override
  String get finishConfessionTitle => 'Finalizar Confissão?';

  @override
  String get finishConfessionContent =>
      'Isso marcará a confissão como concluída e a moverá para seu histórico.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get finish => 'Finalizar';

  @override
  String get confessionCompletedMessage =>
      'Confissão concluída! Deus te abençoe.';

  @override
  String get finishConfession => 'Finalizar Confissão';

  @override
  String get error => 'Erro';

  @override
  String get keepHistory => 'Manter Histórico de Confissões';

  @override
  String get keepHistorySubtitle =>
      'Salva seus pecados junto com a data. Se desativado, apenas a data será salva.';

  @override
  String get deleteConfession => 'Excluir Confissão';

  @override
  String get deleteConfessionContent =>
      'Isso excluirá permanentemente esta confissão e todos os seus itens do seu histórico. Esta ação não pode ser desfeita.';

  @override
  String get tutorialExamineDesc =>
      'Comece aqui para examinar sua consciência antes da confissão.';

  @override
  String get tutorialConfessDesc =>
      'Use isto durante a confissão para acompanhar seus pecados.';

  @override
  String get tutorialPrayersDesc =>
      'Encontre orações comuns para antes e depois da confissão.';

  @override
  String get tutorialGuideDesc =>
      'Encontre encorajamento, guia passo a passo e FAQs aqui.';

  @override
  String get tutorialSettingsDesc =>
      'Personalize sua experiência aqui: altere idioma, tema, defina lembretes e gerencie as configurações de segurança.';

  @override
  String get tutorialSwipeDesc =>
      'Deslize para a esquerda ou direita para navegar entre os mandamentos.';

  @override
  String get tutorialSelectDesc =>
      'Toque em qualquer pergunta para selecioná-la para sua confissão.';

  @override
  String get tutorialFinishDesc =>
      'Quando terminar, toque aqui para finalizar e prosseguir para a confissão.';

  @override
  String get tutorialCounterDesc =>
      'Isso mostra quantos itens você selecionou para a confissão.';

  @override
  String get tutorialMenuDesc =>
      'Acesse pecados personalizados e limpe suas seleções daqui.';

  @override
  String get tutorialPenanceDesc =>
      'Acompanhe as penitências dadas pelo seu confessor aqui.';

  @override
  String get tutorialInsightsDesc =>
      'Veja as estatísticas e sequências da sua jornada de confissão.';

  @override
  String get tutorialHistoryDesc =>
      'Acesse suas confissões passadas e suas datas.';

  @override
  String get replayTutorial => 'Repetir Tutorial';

  @override
  String get replayTutorialDesc => 'Ver o tutorial do app novamente';

  @override
  String get tutorialReset =>
      'Tutorial reiniciado! Você verá os guias novamente.';

  @override
  String get about => 'Sobre';

  @override
  String get aboutSubtitle => 'Versão, licença e código fonte';

  @override
  String get shareApp => 'Compartilhar App';

  @override
  String get shareAppSubtitle => 'Compartilhar com amigos e família';

  @override
  String get rateApp => 'Avaliar App';

  @override
  String get rateAppSubtitle => 'Nos avalie na Play Store';

  @override
  String get website => 'Site';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get madeWithLove => 'Feito com ❤️ por holystack.dev';

  @override
  String get rateDialogTitle => 'Gostando do Metanoia?';

  @override
  String get rateDialogContent =>
      'Se você acha este app útil, por favor, reserve um momento para avaliá-lo. Isso nos ajuda muito!';

  @override
  String get rateDialogYes => 'Avaliar Agora';

  @override
  String get rateDialogNo => 'Não, obrigado';

  @override
  String get rateDialogLater => 'Lembrar mais tarde';

  @override
  String get greekLabel => 'Grego';

  @override
  String get nounLabel => 'substantivo';

  @override
  String get metanoiaDefinition =>
      'Uma mudança profunda de mente e coração; um despertar espiritual que transforma todo o ser e redireciona a vida para Deus.';

  @override
  String get turnBackToGrace => 'Voltar à Graça';

  @override
  String get welcomeSubtitle => 'Seu guia para uma confissão significativa';

  @override
  String get discoverInnerGrace => 'Descubra a Graça Interior';

  @override
  String get sacredJourneyBegins =>
      'Uma jornada sagrada de reconciliação começa.';

  @override
  String get beginJourney => 'Começar Jornada';

  @override
  String get getStarted => 'Começar';

  @override
  String get chooseContentLanguage => 'Escolher Idioma do Conteúdo';

  @override
  String get contentLanguageDescription =>
      'Selecione o idioma para orações, exame e guias';

  @override
  String get changeAnytimeNote =>
      'Você pode mudar isso a qualquer momento nas Configurações';

  @override
  String get continueButton => 'Continuar';

  @override
  String get examineDescription =>
      'Examine sua consciência usando os Dez Mandamentos antes da confissão';

  @override
  String get confessDescription =>
      'Acompanhe seus pecados durante a confissão para garantir que nada seja esquecido';

  @override
  String get prayersDescription =>
      'Acesse orações para antes e depois da confissão, e orações de penitência';

  @override
  String get remindersDescription =>
      'Defina lembretes regulares nas Configurações para nunca esquecer de confessar';

  @override
  String get nextButton => 'Próximo';

  @override
  String get customSins => 'Pecados Personalizados';

  @override
  String get manageCustomSins => 'Gerenciar Pecados Personalizados';

  @override
  String get addCustomSin => 'Adicionar Pecado Personalizado';

  @override
  String get editCustomSin => 'Editar Pecado Personalizado';

  @override
  String get deleteCustomSin => 'Excluir Pecado Personalizado';

  @override
  String get sinDescription => 'Descrição do Pecado';

  @override
  String get sinDescriptionHint => 'Descreva o pecado que você quer lembrar';

  @override
  String get sinDescriptionRequired =>
      'Por favor, insira uma descrição do pecado';

  @override
  String get optionalNote => 'Nota Opcional';

  @override
  String get optionalNoteHint => 'Adicione detalhes adicionais';

  @override
  String get selectCommandment => 'Selecionar Mandamento (Opcional)';

  @override
  String get noCommandment => 'Geral / Sem Mandamento';

  @override
  String get customSinAdded => 'Pecado personalizado adicionado';

  @override
  String get customSinUpdated => 'Pecado personalizado atualizado';

  @override
  String get customSinDeleted => 'Pecado personalizado excluído';

  @override
  String get deleteCustomSinConfirm =>
      'Tem certeza que deseja excluir este pecado personalizado?';

  @override
  String get noCustomSins => 'Nenhum pecado personalizado ainda';

  @override
  String get noCustomSinsDesc =>
      'Adicione pecados personalizados para personalizar seu exame';

  @override
  String get customVersion => 'Personalizado (Editado)';

  @override
  String get searchCustomSins => 'Buscar pecados personalizados...';

  @override
  String get addButton => 'Adicionar';

  @override
  String get updateButton => 'Atualizar';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get addYourOwn => 'Adicione o seu...';

  @override
  String get penance => 'Penitência';

  @override
  String get penanceTracker => 'Rastreador de Penitência';

  @override
  String get addPenance => 'Adicionar Penitência';

  @override
  String get editPenance => 'Editar Penitência';

  @override
  String get penanceDescription => 'Qual penitência você recebeu?';

  @override
  String get penanceHint => 'ex: Rezar 3 Ave Marias, Ler uma passagem...';

  @override
  String get penanceAdded => 'Penitência adicionada';

  @override
  String get penanceUpdated => 'Penitência atualizada';

  @override
  String get penanceCompleted => 'Penitência concluída! Deus te abençoe.';

  @override
  String get markAsComplete => 'Marcar como Concluída';

  @override
  String get pendingPenances => 'Penitências Pendentes';

  @override
  String get noPendingPenances => 'Nenhuma penitência pendente';

  @override
  String get noPendingPenancesDesc =>
      'Todas as suas penitências estão concluídas. Deus te abençoe!';

  @override
  String completedOn(Object date) {
    return 'Concluída em $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Atribuída em $date';
  }

  @override
  String get skipPenance => 'Pular';

  @override
  String get savePenance => 'Salvar Penitência';

  @override
  String get insights => 'Estatísticas';

  @override
  String get confessionInsights => 'Estatísticas de Confissão';

  @override
  String get totalConfessions => 'Total de Confissões';

  @override
  String get averageFrequency => 'Frequência Média';

  @override
  String everyXDays(Object count) {
    return 'A cada $count dias';
  }

  @override
  String get daysSinceLastConfession => 'Dias Desde a Última';

  @override
  String get currentStreak => 'Sequência Atual';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Atividade Mensal';

  @override
  String get confessionsThisYear => 'Confissões Este Ano';

  @override
  String get noInsightsYet => 'Nenhuma estatística ainda';

  @override
  String get noInsightsYetDesc =>
      'Complete sua primeira confissão para ver as estatísticas da sua jornada espiritual';

  @override
  String get totalItemsConfessed => 'Total de Itens Confessados';

  @override
  String get firstConfession => 'Primeira Confissão';

  @override
  String get spiritualJourney => 'Sua Jornada Espiritual';

  @override
  String get listView => 'Lista';

  @override
  String get guidedView => 'Guiada';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current de $total';
  }

  @override
  String get previousCommandment => 'Anterior';

  @override
  String get nextCommandment => 'Próximo';

  @override
  String get finishExamination => 'Concluir';

  @override
  String get noQuestionsSelected => 'Nenhuma pergunta selecionada nesta seção';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count selecionados';
  }

  @override
  String get examinationSummary => 'Resumo do Exame';

  @override
  String get examinationNote =>
      'Um exame de consciência completo vai além de qualquer lista. Reflita em oração sobre seu estado de vida e circunstâncias.';

  @override
  String selectedCount(Object count) {
    return '$count itens selecionados';
  }

  @override
  String get noSinsSelected => 'Nenhum pecado selecionado';

  @override
  String get continueEditing => 'Continuar Editando';

  @override
  String get proceedToConfess => 'Prosseguir';

  @override
  String get clearDraftTitle => 'Limpar Rascunho?';

  @override
  String get clearDraftMessage =>
      'Isso removerá todas as perguntas selecionadas. Tem certeza?';

  @override
  String get clearDraft => 'Limpar Rascunho';

  @override
  String get clear => 'Limpar';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restaurados $count itens da sua última sessão',
      one: 'Restaurado 1 item da sua última sessão',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Agora mesmo';

  @override
  String minutesAgo(Object count) {
    return 'há ${count}m';
  }

  @override
  String hoursAgo(Object count) {
    return 'há ${count}h';
  }

  @override
  String get general => 'Geral';

  @override
  String get noQuestionsInSection => 'Nenhuma pergunta nesta seção';

  @override
  String get skip => 'Pular';

  @override
  String get back => 'Voltar';

  @override
  String get skipOnboardingTitle => 'Pular Introdução?';

  @override
  String get skipOnboardingMessage =>
      'Você sempre pode acessar a ajuda e configurações mais tarde no menu.';

  @override
  String get confessionHistoryTitle => 'Histórico de Confissões';

  @override
  String get deleteAll => 'Excluir Tudo';

  @override
  String get editDate => 'Editar Data';

  @override
  String get confessionDate => 'Data da Confissão';

  @override
  String get dateUpdated => 'Data atualizada';

  @override
  String get changeDateConfirmTitle => 'Mudar Data?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Mudar data da confissão para $date?';
  }

  @override
  String get noGuideContent => 'Conteúdo do guia não disponível';

  @override
  String get noGuideContentDesc => 'O conteúdo do guia aparecerá aqui';

  @override
  String get noFaqContent => 'FAQs não disponíveis';

  @override
  String get noFaqContentDesc => 'Perguntas frequentes aparecerão aqui';

  @override
  String get faqSubtitle => 'Um guia para o Sacramento da Reconciliação';

  @override
  String get tapToExpand => 'Toque para ler mais';

  @override
  String get continueExamination => 'Continuar Exame';

  @override
  String get continueExaminationDesc => 'Você tem um exame em andamento';

  @override
  String examinationProgress(Object count) {
    return '$count itens selecionados';
  }

  @override
  String get security => 'Segurança';

  @override
  String get securitySubtitle => 'Proteja seus dados pessoais';

  @override
  String get pinAndBiometric => 'PIN e Biometria';

  @override
  String get pinAndBiometricSubtitle => 'Configurar bloqueio do app';

  @override
  String get enterPin => 'Inserir PIN';

  @override
  String get createPin => 'Criar PIN';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get incorrectPin => 'PIN Incorreto';

  @override
  String get pinMismatch => 'Os PINs não coincidem';

  @override
  String get biometricUnlock => 'Desbloqueio Biométrico';

  @override
  String get autoLockTimeout => 'Tempo de Bloqueio Automático';

  @override
  String get tooManyAttempts => 'Muitas tentativas falharam';

  @override
  String tryAgainIn(Object time) {
    return 'Tente novamente em $time';
  }

  @override
  String get useBiometricUnlock => 'Usar Desbloqueio Biométrico';

  @override
  String get unlockWithFingerprintOrFace =>
      'Desbloquear com impressão digital ou rosto';

  @override
  String get biometricAccessWarning =>
      'Qualquer pessoa com uma impressão digital ou rosto registrado neste dispositivo poderá acessar o aplicativo';

  @override
  String get lockAfter => 'Bloquear Após';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Tempo em segundo plano antes de bloquear';

  @override
  String get changePin => 'Mudar PIN';

  @override
  String get updateYourSecurityPin => 'Atualize seu PIN de segurança';

  @override
  String get enterCurrentPin => 'Inserir PIN Atual';

  @override
  String get enterNewPin => 'Inserir Novo PIN';

  @override
  String get confirmNewPin => 'Confirmar Novo PIN';

  @override
  String get pinChangedSuccessfully => 'PIN alterado com sucesso';

  @override
  String get currentPinIncorrect => 'O PIN atual está incorreto';

  @override
  String get enableBiometricUnlock => 'Ativar Desbloqueio Biométrico?';

  @override
  String get biometricDescription =>
      'Use sua impressão digital ou rosto para desbloquear o app de forma rápida e segura.';

  @override
  String get notNow => 'Agora Não';

  @override
  String get enable => 'Ativar';

  @override
  String get setUpPin => 'Configurar PIN';

  @override
  String get createSixDigitPin => 'Crie um PIN de 6 dígitos';

  @override
  String get pinProtectData => 'Este PIN será usado para proteger seus dados';

  @override
  String get confirmYourPin => 'Confirme seu PIN';

  @override
  String get enterSamePinAgain => 'Insira o mesmo PIN novamente para confirmar';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Insira seu PIN para desbloquear';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tentativas restantes',
      one: '1 tentativa restante',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '1 segundo',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Desfazer';

  @override
  String get confessionDeleted => 'Confissão excluída';

  @override
  String get noConfessionHistory => 'Sem histórico de confissões';

  @override
  String get noConfessionHistoryDesc => 'Confissões concluídas aparecerão aqui';

  @override
  String get fontSize => 'Tamanho da Fonte';

  @override
  String get fontSizeSubtitle => 'Ajustar tamanho do texto para melhor leitura';

  @override
  String get fontSizeSmall => 'Pequeno';

  @override
  String get fontSizeMedium => 'Médio';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeExtraLarge => 'Extra Grande';

  @override
  String get forgotPin => 'Esqueceu o PIN?';

  @override
  String get resetPinTitle => 'Redefinir PIN';

  @override
  String get resetPinWarning =>
      'Aviso: Isso excluirá permanentemente todos os seus dados';

  @override
  String get resetPinDescription =>
      'Se você redefinir seu PIN, todas as suas confissões, pecados personalizados, penitências e outros dados pessoais serão excluídos permanentemente. Esta ação não pode ser desfeita.';

  @override
  String get resetPinConfirmation => 'Digite EXCLUIR para confirmar';

  @override
  String get resetPinButton => 'Redefinir PIN e Excluir Dados';

  @override
  String get resetPinSuccess =>
      'PIN redefinido com sucesso. Por favor, configure um novo PIN.';

  @override
  String get resetPinError =>
      'Falha ao redefinir PIN. Por favor, tente novamente.';

  @override
  String get deleteConfirmationText => 'EXCLUIR';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Por favor aguarde $seconds segundos';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Verifique sua identidade para redefinir o PIN';

  @override
  String get confessionGuideTitle => 'Como Fazer uma Boa Confissão';

  @override
  String get confessionGuideSubtitle => 'Guia passo a passo para o Sacramento';

  @override
  String get invitationTitle => 'Retornando à Confissão?';

  @override
  String get invitationSubtitle => 'Uma palavra de encorajamento para você';

  @override
  String get invitationDialogTitle => 'Bem-vindo';

  @override
  String get invitationDialogContent =>
      'É sua primeira confissão em muito tempo, ou você está se sentindo ansioso para ir?';

  @override
  String get invitationDialogYes => 'Sim, eu gostaria de algum encorajamento';

  @override
  String get invitationDialogNo => 'Não, estou pronto para começar';

  @override
  String get invitationDialogDontShowAgain => 'Não mostrar isso novamente';

  @override
  String get searchPrayers => 'Buscar orações...';

  @override
  String get allCategories => 'Todas';

  @override
  String get appDisclaimer =>
      'Este app é uma ajuda espiritual para a preparação da confissão. Não é um substituto do Sacramento da Reconciliação com um padre.';

  @override
  String get onboardingDisclaimer =>
      'Um companheiro espiritual para a confissão—não um substituto.';

  @override
  String get readyToBegin => 'Tudo Pronto';

  @override
  String get readyToBeginSubtitle =>
      'Que sua jornada rumo à reconciliação seja repleta de graça e paz.';

  @override
  String get sourceCode => 'Código Fonte';

  @override
  String get contentReferences => 'Referências de Conteúdo';

  @override
  String get examinationModeTitle => 'Como você gostaria de examinar?';

  @override
  String get quickReviewMode => 'Revisão Rápida';

  @override
  String get quickReviewDescription =>
      'Revise todas as perguntas por categoria';

  @override
  String get deepReflectionMode => 'Reflexão Profunda';

  @override
  String get deepReflectionDescription =>
      'Uma pergunta por vez para um exame reflexivo';

  @override
  String get contemplativePrayerTitle => 'Vem, Espírito Santo';

  @override
  String get contemplativePrayerText =>
      'Enche o meu coração e acende em mim o fogo do Teu amor. Ilumina a minha mente para que eu possa ver claramente os meus pecados.';

  @override
  String get imReady => 'Estou Pronto';

  @override
  String get skipPrayer => 'Pular';

  @override
  String get yesThisApplies => 'Sim';

  @override
  String get noThisDoesnt => 'Não';

  @override
  String get skipQuestion => 'Pular';

  @override
  String questionProgress(int current, int total) {
    return '$current de $total';
  }

  @override
  String get examinationComplete => 'Exame Concluído';

  @override
  String get reviewYourSelections => 'Reveja suas seleções';

  @override
  String get examinationModeSettingTitle => 'Modo de Exame';

  @override
  String get examinationModeSettingSubtitle =>
      'Escolha como você gostaria de examinar sua consciência';

  @override
  String get askEveryTime => 'Perguntar Toda Vez';
}
