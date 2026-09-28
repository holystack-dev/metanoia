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
  String get homeTitle => 'Início';

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
  String get getReminded => 'Receba lembretes para se confessar';

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
  String get retry => 'Tentar novamente';

  @override
  String get dailyQuoteError => 'Não foi possível carregar a citação de hoje.';

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
  String get spreadShareTitle => 'Compartilhe o Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Conhece alguém afastado da confissão? Ajude essa pessoa a voltar.';

  @override
  String get spreadShareAction => 'Compartilhar';

  @override
  String get spreadRateSubtitle =>
      'Se o Metanoia ajudou você a se preparar para a confissão, uma avaliação ajuda outros a encontrá-lo.';

  @override
  String get spreadRateAction => 'Avaliar';

  @override
  String get rateGateHint => 'Como você avalia sua experiência?';

  @override
  String get rateGateLowest => 'Mais baixa';

  @override
  String get rateGateHighest => 'Mais alta';

  @override
  String get rateGateThanks =>
      'Obrigado — sua opinião significa muito para nós.';

  @override
  String rateAppSubtitle(String store) {
    return 'Avalie o app na loja ($store)';
  }

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
  String get rateDialogNo => 'Prefiro não avaliar';

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
  String get penanceTracker => 'Acompanhamento de Penitências';

  @override
  String get addPenance => 'Adicionar Penitência';

  @override
  String get editPenance => 'Editar Penitência';

  @override
  String get penanceDescription => 'Qual penitência você recebeu?';

  @override
  String get penanceHint =>
      'ex.: Rezar 3 Ave-Marias, Ler uma passagem da Escritura...';

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
      'Você irá direto para a última página. Nada é configurado aqui — você pode mudar tudo depois nas configurações.';

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
  String get tooManyAttempts => 'Muitas tentativas incorretas';

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
  String get shortFilmTitle => 'Confissão: um curta-metragem';

  @override
  String get shortFilmSubtitle =>
      'Criado por Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Reino Unido';

  @override
  String get confessionGuideSubtitle => 'Guia passo a passo para o Sacramento';

  @override
  String get invitationTitle => 'Retornando à Confissão?';

  @override
  String get invitationSubtitle => 'Uma palavra de encorajamento para você';

  @override
  String get invitationDialogTitle => 'Boas-vindas';

  @override
  String get invitationDialogContent =>
      'É a sua primeira confissão em muito tempo, ou você está com receio de ir?';

  @override
  String get invitationDialogYes => 'Sim, eu gostaria de algum encorajamento';

  @override
  String get invitationDialogNo => 'Não, posso começar';

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
  String get onboardingOverviewTitle => 'O que este app faz';

  @override
  String get onboardingOverviewExamine =>
      'Prepare sua consciência, no seu ritmo.';

  @override
  String get onboardingOverviewConfess =>
      'Uma lista discreta, para que nada seja esquecido.';

  @override
  String get onboardingOverviewJournal =>
      'Uma breve reflexão noturna, para continuar crescendo entre as confissões.';

  @override
  String get onboardingOverviewFootnote =>
      'Orações, guias e lembretes opcionais estão dentro do app.';

  @override
  String get onboardingPrivacyTitle => 'Privado por princípio';

  @override
  String get onboardingPrivacyLocal =>
      'Tudo permanece neste telefone. Sem conta, sem nuvem.';

  @override
  String get onboardingPrivacyEncrypted => 'Criptografado no seu dispositivo.';

  @override
  String get onboardingPrivacyPin =>
      'Você criará um PIN na primeira vez que abrir um exame ou seu diário.';

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
  String get contemplativePrayerTitle => 'Vinde, Espírito Santo';

  @override
  String get contemplativePrayerText =>
      'Enchei o meu coração e acendei em mim o fogo do vosso amor. Iluminai a minha mente para que eu veja claramente os meus pecados.';

  @override
  String get imReady => 'Vamos Começar';

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

  @override
  String get reminderNotificationTitle => 'Hora da Confissão';

  @override
  String get reminderNotificationBody =>
      'Lembre-se de examinar sua consciência e se preparar para a confissão';

  @override
  String get notificationPermissionDenied =>
      'As notificações estão desativadas. Permita as notificações do Metanoia nas configurações do seu dispositivo para receber lembretes de confissão.';

  @override
  String get openSourceLicenses => 'Licenças de código aberto';

  @override
  String get couldNotOpenLink => 'Não foi possível abrir o link';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens confessados',
      one: '1 item confessado',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitências',
      one: '1 penitência',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pendentes',
      one: '1 pendente',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count no total',
      one: '1 no total',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count itens',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '1 dia',
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
  String get deleteAllConfessionsTitle => 'Excluir todas as confissões?';

  @override
  String get deleteAllConfessionsContent =>
      'Isso excluirá permanentemente todo o seu histórico de confissões. Esta ação não pode ser desfeita.';

  @override
  String get allConfessionsDeleted => 'Todas as confissões foram excluídas';

  @override
  String get deletePenanceConfirm =>
      'Tem certeza de que deseja excluir esta penitência?';

  @override
  String get completed => 'Concluída';

  @override
  String get tapToCollapse => 'Toque para recolher';

  @override
  String get dismiss => 'Dispensar';

  @override
  String showcaseStep(int current, int total) {
    return 'Passo $current de $total';
  }

  @override
  String get done => 'Concluir';

  @override
  String get navigate => 'Navegar';

  @override
  String get encouragement => 'Encorajamento';

  @override
  String get biometricPromptReason => 'Autentique-se para acessar o Metanoia';

  @override
  String get tryAgainInLabel => 'Tente novamente em';

  @override
  String get errorLoadingLanguage => 'Erro ao carregar o idioma';

  @override
  String get detailsNotSaved => 'Detalhes não salvos';

  @override
  String get discardStoredSinsTitle => 'Descartar os pecados salvos?';

  @override
  String get discardStoredSinsContent =>
      'O histórico de confissões agora está desativado. Os pecados já salvos de confissões anteriores continuam armazenados. Descartá-los? As datas serão mantidas, para que suas estatísticas e sequências permaneçam intactas.';

  @override
  String get keepThem => 'Manter';

  @override
  String get discard => 'Descartar';

  @override
  String get storedSinsDiscarded =>
      'Pecados salvos descartados. As datas das confissões foram mantidas.';

  @override
  String get journalTitle => 'Diário';

  @override
  String get journalHomeCardTitle => 'Reflexão da noite';

  @override
  String get journalHomeCardSubtitle => 'Como foi o seu dia?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Dias seguidos de reflexão';

  @override
  String get journalContinueToday => 'Continuar o registro de hoje';

  @override
  String get journalPreviousMonth => 'Mês anterior';

  @override
  String get journalNextMonth => 'Mês seguinte';

  @override
  String get journalGratitudeTitle => 'Gratidão';

  @override
  String get journalGratitudePrompt => 'Onde vi Deus hoje?';

  @override
  String get journalGratitudeHint =>
      'Uma graça pela qual quero agradecer a Ele…';

  @override
  String get journalPresenceLead =>
      'Deus está aqui com você. Aquiete-se diante d\'Ele e dê graças.';

  @override
  String get journalPresenceVerse =>
      'Parai – disse ele – e reconhecei que sou Deus.';

  @override
  String get journalPresenceRef => 'Sl 45,11';

  @override
  String get journalLightTitle => 'Peça luz';

  @override
  String get journalLightLead =>
      'Peça ao Espírito Santo a luz para ver o seu dia como Deus o vê.';

  @override
  String get journalLightVerse =>
      'Vinde, Espírito Santo, enchei os corações dos vossos fiéis e acendei neles o fogo do vosso amor.';

  @override
  String get journalReviewTitle => 'Reveja com Deus';

  @override
  String get journalReviewLead =>
      'Percorra novamente o seu dia com o Senhor: onde o amor veio até você, onde você o deu e onde você se afastou.';

  @override
  String get journalReviewVerse =>
      'Perscrutai-me, Senhor, para conhecer meu coração; provai-me e conhecei meus pensamentos. Vede se ando na senda do mal, e conduzi-me pelo caminho da eternidade.';

  @override
  String get journalReviewRef => 'Sl 138,23-24';

  @override
  String get journalReviewHint => 'Fale com Ele sobre o seu dia…';

  @override
  String get journalReviewBringSin =>
      'Há algo que você queira trazer diante d\'Ele?';

  @override
  String get journalContritionTitle => 'Contrição';

  @override
  String get journalContritionLead =>
      'Leve ao Pai o que você encontrou; Ele corre ao seu encontro.';

  @override
  String get journalContritionVerse =>
      'Tende piedade de mim, Senhor, segundo a vossa bondade. E conforme a imensidade de vossa misericórdia, apagai a minha iniquidade.';

  @override
  String get journalContritionRef => 'Sl 50,3';

  @override
  String get journalContritionPray => 'Reze o Ato de Contrição';

  @override
  String get journalContritionMercy =>
      'A dor que nasce do amor a Deus, com o propósito de se confessar, abre o seu coração esta noite à misericórdia d\'Ele — e a sua plenitude espera por você na Confissão, nas palavras da absolvição.';

  @override
  String get journalResolutionLead =>
      'Descanse na misericórdia d\'Ele. O amanhã recomeça n\'Ele.';

  @override
  String get journalResolutionVerse =>
      'É graças ao Senhor que não fomos aniquilados, porque não se esgotou sua piedade. Cada manhã ele se manifesta e grande é sua fidelidade.';

  @override
  String get journalResolutionRef => 'Lm 3,22-23';

  @override
  String get journalReflectionTitle => 'Reflexão';

  @override
  String get journalReflectionPrompt => 'Como foi o seu dia?';

  @override
  String get journalReflectionHint => 'Escreva livremente...';

  @override
  String get journalSinsTitle => 'Marcar pecados';

  @override
  String get journalSinsPrompt => 'Em que falhei hoje?';

  @override
  String get journalNoSinsMarked => 'Ainda nada marcado';

  @override
  String get journalAddSin => 'Marcar um pecado';

  @override
  String get journalRemoveSin => 'Remover';

  @override
  String get journalResolutionTitle => 'Esperança e Propósito';

  @override
  String get journalResolutionPrompt => 'Um dom para amanhã';

  @override
  String get journalResolutionHint => 'Com a vossa graça, amanhã eu vou…';

  @override
  String get journalMoodTitle => 'Estado de espírito';

  @override
  String get journalMoodPrompt => 'Como está a sua alma esta noite?';

  @override
  String get journalMoodDesolate => 'Desolação';

  @override
  String get journalMoodStruggling => 'Luta';

  @override
  String get journalMoodSteady => 'Serenidade';

  @override
  String get journalMoodGrateful => 'Gratidão';

  @override
  String get journalMoodConsoled => 'Consolação';

  @override
  String get journalSaved => 'Salvo';

  @override
  String get journalSaving => 'Salvando...';

  @override
  String get journalDeleteEntry => 'Excluir registro';

  @override
  String get journalDeleteEntryConfirm =>
      'Excluir o registro deste dia? Esta ação não pode ser desfeita.';

  @override
  String get journalEntryDeleted => 'Registro excluído';

  @override
  String get journalPickerQuestions => 'Perguntas';

  @override
  String get journalPickerMySins => 'Meus pecados';

  @override
  String get journalPickerOwnWords => 'Com minhas palavras';

  @override
  String get journalPickerFreeTextHint => 'Descreva com suas próprias palavras';

  @override
  String get journalSearchSins => 'Buscar pecados...';

  @override
  String get journalAbsolved => 'Confessado';

  @override
  String get journalSinCleared => 'Um pecado que você levou à confissão';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Incluir os $count pecados que você marcou no seu diário',
      one: 'Incluir o pecado que você marcou no seu diário',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Incluir';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pecados adicionados do seu diário',
      one: '1 pecado adicionado do seu diário',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Áreas de luta';

  @override
  String get journalStruggleAreasSubtitle =>
      'O que você mais marca no seu diário';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count marcas',
      one: '1 marca',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Lembrete do diário';

  @override
  String get journalReminderSubtitle =>
      'Um lembrete todas as noites para refletir sobre o seu dia';

  @override
  String get enableJournalReminder => 'Ativar lembrete do diário';

  @override
  String get journalReminderNotificationTitle => 'Reflexão da noite';

  @override
  String get journalReminderNotificationBody =>
      'Reserve um momento para rever o seu dia com Deus';

  @override
  String get confessionDayMode => 'Modo Confissão';

  @override
  String get confessionDayModeDescription =>
      'Texto grande e sem distrações para o confessionário';

  @override
  String get exitConfessionMode => 'Sair do modo confissão';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Passo $current de $total';
  }

  @override
  String get next => 'Próximo';

  @override
  String get actOfContrition => 'Ato de Contrição';

  @override
  String get actOfContritionUnavailable =>
      'O Ato de Contrição não está disponível';

  @override
  String get confessionDaySinsTitle => 'Pecados a confessar';

  @override
  String get confessionDayOpeningTitle => 'Início';

  @override
  String get confessionDayOpeningIntro =>
      'Faça o Sinal da Cruz e depois comece:';

  @override
  String get confessionDayOpeningFormula => 'Abençoe-me, Padre, porque pequei.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Faz $duration desde a minha última confissão.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Faz [dias/semanas/meses/anos] desde minha última confissão.';

  @override
  String get confessionDaySinsClosing =>
      'Por estes e todos os meus pecados, eu me arrependo de todo o coração.';

  @override
  String get confessionDayThanksgivingTitle => 'Vá em paz';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Dai graças ao Senhor, porque Ele é bom.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Porque a sua misericórdia é eterna.';

  @override
  String get confessionDayThanksgivingBody =>
      'A sua alma foi purificada. Cumpra a sua penitência e siga em frente na paz de Cristo.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '1 mês',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '1 ano',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Quaresma';

  @override
  String get seasonHolyWeek => 'Semana Santa';

  @override
  String get seasonAdvent => 'Advento';

  @override
  String get seasonChristmas => 'Natal';

  @override
  String get seasonEaster => 'Páscoa';

  @override
  String get seasonOrdinaryTime => 'Tempo Comum';

  @override
  String get feastAshWednesday => 'A Quarta-feira de Cinzas';

  @override
  String get feastPalmSunday => 'O Domingo de Ramos';

  @override
  String get feastEaster => 'A Páscoa';

  @override
  String get feastPentecost => 'Pentecostes';

  @override
  String get feastAssumption => 'A Assunção';

  @override
  String get feastAllSaints => 'A Solenidade de Todos os Santos';

  @override
  String get feastImmaculateConception => 'A Imaculada Conceição';

  @override
  String get feastFirstSundayOfAdvent => 'O primeiro domingo do Advento';

  @override
  String get feastChristmas => 'O Natal';

  @override
  String get liturgicalLentTitle => 'A Quaresma começou';

  @override
  String get liturgicalLentBody =>
      'Um tempo de voltar para Deus. Muitos o começam com a confissão.';

  @override
  String get liturgicalHolyWeekTitle => 'A Semana Santa começou';

  @override
  String get liturgicalHolyWeekBody =>
      'A Igreja caminha para a Páscoa. Ainda há tempo de preparar seu coração.';

  @override
  String get liturgicalAdventTitle => 'O Advento começou';

  @override
  String get liturgicalAdventBody =>
      'Um tempo de espera. Muitos preparam o coração com a confissão.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast se aproxima';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Faltam $count dias: prepare seu coração.',
      one: 'Falta um dia: prepare seu coração.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Passaram $count semanas desde sua última confissão',
      one: 'Passou uma semana desde sua última confissão',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Quando quiser, a misericórdia espera. Quer se preparar?';

  @override
  String get promptPrepare => 'Preparar-me';

  @override
  String get dataUnrecoverableTitle => 'Seus dados não podem ser desbloqueados';

  @override
  String get dataUnrecoverableBody =>
      'A chave que protege suas confissões não está mais disponível neste dispositivo. Isso pode acontecer após restaurar um backup ou se as configurações de segurança do dispositivo forem redefinidas.\n\nComo seus dados estão criptografados, não podem ser recuperados sem essa chave — nem mesmo por nós. Você pode apagá-los e começar de novo.';

  @override
  String get eraseAndStartOver => 'Apagar e começar de novo';

  @override
  String get eraseAndStartOverConfirm =>
      'Isso apaga permanentemente tudo o que está salvo neste dispositivo e reinicia o aplicativo. Não pode ser desfeito.';

  @override
  String get penanceSaveFailed =>
      'Não foi possível salvar a penitência. Tente novamente.';

  @override
  String get confessionReminderChannelName => 'Lembretes de confissão';

  @override
  String get confessionReminderChannelDescription =>
      'Lembretes para se confessar';

  @override
  String get journalReminderChannelName => 'Lembretes do diário';

  @override
  String get journalReminderChannelDescription =>
      'Lembrete diário para escrever a reflexão da noite';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count assinalados até agora',
      one: 'Um assinalado até agora',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Antes de começar';

  @override
  String get invitationCardAction => 'Encoraje-me';

  @override
  String get homeCtaBeginTitle => 'Comece o seu exame de consciência';

  @override
  String get homeCtaBeginSubtitle => 'Prepare o seu coração antes da confissão';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continue o seu exame ($count selecionados)',
      one: 'Continue o seu exame (1 selecionado)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Retome de onde parou';

  @override
  String get homeCtaReadyTitle => 'Você já pode começar';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pecados esperam na sua lista de confissão',
      one: '1 pecado espera na sua lista de confissão',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Cumpra a sua penitência';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitências ainda estão pendentes',
      one: '1 penitência ainda está pendente',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Encorajamento, um guia passo a passo, orações e perguntas frequentes';

  @override
  String get homeQuoteReadMore => 'Ler mais';

  @override
  String get homeQuoteShowLess => 'Mostrar menos';

  @override
  String get tutorialJournalDesc =>
      'Reveja o seu dia todas as noites: uma breve reflexão e a sua sequência.';
}
