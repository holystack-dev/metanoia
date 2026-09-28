// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get examineTitle => 'Examinar';

  @override
  String get confessTitle => 'Confesar';

  @override
  String get prayersTitle => 'Oraciones';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get examinationTitle => 'Examen';

  @override
  String get commandment => 'Mandamiento';

  @override
  String get guideTitle => 'Guía';

  @override
  String get faqTitle => 'Entendiendo la Confesión';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Elige tu idioma preferido';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Elige tu tema preferido';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get reminders => 'Recordatorios';

  @override
  String get getReminded => 'Recibe recordatorios para confesarte';

  @override
  String get enableReminders => 'Activar Recordatorios';

  @override
  String get weekly => 'Semanalmente';

  @override
  String get biweekly => 'Cada dos semanas';

  @override
  String get monthly => 'Mensualmente';

  @override
  String get quarterly => 'Trimestralmente';

  @override
  String get day => 'Día';

  @override
  String get time => 'Hora';

  @override
  String get remindMe => 'Recordarme';

  @override
  String get onTheDay => 'El mismo día';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días antes',
      one: '1 día antes',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Acciones Rápidas';

  @override
  String get lastConfession => 'Última Confesión';

  @override
  String get noneYet => 'Ninguna aún';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hace $count días',
      one: 'hace 1 día',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Próximo Recordatorio';

  @override
  String get off => 'Apagado';

  @override
  String get mon => 'Lun';

  @override
  String get tue => 'Mar';

  @override
  String get wed => 'Mié';

  @override
  String get thu => 'Jue';

  @override
  String get fri => 'Vie';

  @override
  String get sat => 'Sáb';

  @override
  String get sun => 'Dom';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get appLanguage => 'Idioma de la App';

  @override
  String get appLanguageSubtitle => 'Idioma para botones, etiquetas y menús';

  @override
  String get contentLanguage => 'Idioma del Contenido';

  @override
  String get contentLanguageSubtitle =>
      'Idioma para el examen, preguntas frecuentes y oraciones';

  @override
  String get version => 'Versión';

  @override
  String get selectDay => 'Seleccionar Día';

  @override
  String selected(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count seleccionados',
      one: '1 seleccionado',
    );
    return '$_temp0';
  }

  @override
  String get selectedLabel => 'seleccionado';

  @override
  String get counter => 'Contador';

  @override
  String get searchPlaceholder => 'Buscar mandamientos o preguntas...';

  @override
  String get noResults => 'No se encontraron resultados';

  @override
  String get viewHistory => 'Ver Historial';

  @override
  String get noActiveConfession => 'No hay confesión activa';

  @override
  String get startExaminationPrompt =>
      'Inicia un examen para añadir pecados aquí.';

  @override
  String get startExamination => 'Iniciar Examen';

  @override
  String get finishConfessionTitle => '¿Finalizar Confesión?';

  @override
  String get finishConfessionContent =>
      'Esto marcará la confesión como completada y la moverá a tu historial.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get finish => 'Finalizar';

  @override
  String get confessionCompletedMessage =>
      '¡Confesión completada! Dios te bendiga.';

  @override
  String get finishConfession => 'Finalizar Confesión';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Reintentar';

  @override
  String get dailyQuoteError => 'No se pudo cargar la cita de hoy.';

  @override
  String get keepHistory => 'Guardar Historial de Confesiones';

  @override
  String get keepHistorySubtitle =>
      'Guarda tus pecados junto con la fecha. Si se desactiva, solo se guardará la fecha.';

  @override
  String get deleteConfession => 'Eliminar Confesión';

  @override
  String get deleteConfessionContent =>
      'Esto eliminará permanentemente esta confesión y todos sus elementos de tu historial. Esta acción no se puede deshacer.';

  @override
  String get tutorialExamineDesc =>
      'Comienza aquí para examinar tu conciencia antes de la confesión.';

  @override
  String get tutorialConfessDesc =>
      'Usa esto durante la confesión para llevar la cuenta de tus pecados.';

  @override
  String get tutorialPrayersDesc =>
      'Encuentra oraciones comunes para antes y después de la confesión.';

  @override
  String get tutorialGuideDesc =>
      'Encuentra aliento, una guía paso a paso y preguntas frecuentes aquí.';

  @override
  String get tutorialSettingsDesc =>
      'Personaliza tu experiencia aquí: cambia idioma, tema, configura recordatorios y gestiona la seguridad.';

  @override
  String get tutorialSwipeDesc =>
      'Desliza a la izquierda o derecha para navegar entre mandamientos.';

  @override
  String get tutorialSelectDesc =>
      'Toca cualquier pregunta para seleccionarla para tu confesión.';

  @override
  String get tutorialFinishDesc =>
      'Cuando termines, toca aquí para finalizar y proceder a la confesión.';

  @override
  String get tutorialCounterDesc =>
      'Esto muestra cuántos elementos has seleccionado para la confesión.';

  @override
  String get tutorialMenuDesc =>
      'Accede a pecados personalizados y borra tus selecciones desde aquí.';

  @override
  String get tutorialPenanceDesc =>
      'Registra las penitencias dadas por tu confesor aquí.';

  @override
  String get tutorialInsightsDesc =>
      'Mira las estadísticas y rachas de tu camino de confesión.';

  @override
  String get tutorialHistoryDesc =>
      'Accede a tus confesiones pasadas y sus fechas.';

  @override
  String get replayTutorial => 'Repetir Tutorial';

  @override
  String get replayTutorialDesc => 'Ver el tutorial de la app de nuevo';

  @override
  String get tutorialReset => '¡Tutorial reiniciado! Verás las guías de nuevo.';

  @override
  String get about => 'Acerca de';

  @override
  String get aboutSubtitle => 'Versión, licencia y código fuente';

  @override
  String get shareApp => 'Compartir App';

  @override
  String get shareAppSubtitle => 'Compartir con amigos y familia';

  @override
  String get rateApp => 'Calificar App';

  @override
  String get spreadShareTitle => 'Comparte Metanoia';

  @override
  String get spreadShareSubtitle =>
      '¿Conoces a alguien alejado de la confesión? Ayúdale a volver.';

  @override
  String get spreadShareAction => 'Compartir';

  @override
  String get spreadRateSubtitle =>
      'Si Metanoia te ha ayudado a prepararte para la confesión, una valoración ayuda a que otros la encuentren.';

  @override
  String get spreadRateAction => 'Valorar';

  @override
  String get rateGateHint => '¿Cómo valorarías tu experiencia?';

  @override
  String get rateGateLowest => 'Más baja';

  @override
  String get rateGateHighest => 'Más alta';

  @override
  String get rateGateThanks =>
      'Gracias: tu opinión significa mucho para nosotros.';

  @override
  String rateAppSubtitle(String store) {
    return 'Califícanos en $store';
  }

  @override
  String get website => 'Sitio Web';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get madeWithLove => 'Hecho con ❤️ por holystack.dev';

  @override
  String get rateDialogTitle => '¿Disfrutando Metanoia?';

  @override
  String get rateDialogContent =>
      'Si encuentras útil esta app, por favor tómate un momento para calificarla. ¡Nos ayuda mucho!';

  @override
  String get rateDialogYes => 'Calificar Ahora';

  @override
  String get rateDialogNo => 'No, gracias';

  @override
  String get rateDialogLater => 'Recordarme luego';

  @override
  String get greekLabel => 'Griego';

  @override
  String get nounLabel => 'sustantivo';

  @override
  String get metanoiaDefinition =>
      'Un cambio profundo de mente y corazón; un despertar espiritual que transforma todo el ser y redirige la vida hacia Dios.';

  @override
  String get turnBackToGrace => 'Volver a la Gracia';

  @override
  String get welcomeSubtitle => 'Tu guía para una confesión significativa';

  @override
  String get discoverInnerGrace => 'Descubre la Gracia Interior';

  @override
  String get sacredJourneyBegins =>
      'Un viaje sagrado de reconciliación comienza.';

  @override
  String get beginJourney => 'Comenzar Viaje';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get chooseContentLanguage => 'Elegir Idioma del Contenido';

  @override
  String get contentLanguageDescription =>
      'Selecciona el idioma para oraciones, examen y guías';

  @override
  String get changeAnytimeNote =>
      'Puedes cambiar esto en cualquier momento en Ajustes';

  @override
  String get continueButton => 'Continuar';

  @override
  String get examineDescription =>
      'Examina tu conciencia usando los Diez Mandamientos antes de la confesión';

  @override
  String get confessDescription =>
      'Lleva la cuenta de tus pecados durante la confesión para no olvidar nada';

  @override
  String get prayersDescription =>
      'Accede a oraciones para antes y después de la confesión, y oraciones de penitencia';

  @override
  String get remindersDescription =>
      'Configura recordatorios regulares en Ajustes para nunca olvidar confesarte';

  @override
  String get nextButton => 'Siguiente';

  @override
  String get customSins => 'Pecados Personalizados';

  @override
  String get manageCustomSins => 'Gestionar Pecados Personalizados';

  @override
  String get addCustomSin => 'Añadir Pecado Personalizado';

  @override
  String get editCustomSin => 'Editar Pecado Personalizado';

  @override
  String get deleteCustomSin => 'Eliminar Pecado Personalizado';

  @override
  String get sinDescription => 'Descripción del Pecado';

  @override
  String get sinDescriptionHint => 'Describe el pecado que quieres recordar';

  @override
  String get sinDescriptionRequired =>
      'Por favor ingresa una descripción del pecado';

  @override
  String get optionalNote => 'Nota Opcional';

  @override
  String get optionalNoteHint => 'Añade detalles adicionales';

  @override
  String get selectCommandment => 'Seleccionar Mandamiento (Opcional)';

  @override
  String get noCommandment => 'General / Sin Mandamiento';

  @override
  String get customSinAdded => 'Pecado personalizado añadido';

  @override
  String get customSinUpdated => 'Pecado personalizado actualizado';

  @override
  String get customSinDeleted => 'Pecado personalizado eliminado';

  @override
  String get deleteCustomSinConfirm =>
      '¿Seguro que quieres eliminar este pecado personalizado?';

  @override
  String get noCustomSins => 'Aún no hay pecados personalizados';

  @override
  String get noCustomSinsDesc =>
      'Añade pecados personalizados para personalizar tu examen';

  @override
  String get customVersion => 'Personalizado (Editado)';

  @override
  String get searchCustomSins => 'Buscar pecados personalizados...';

  @override
  String get addButton => 'Añadir';

  @override
  String get updateButton => 'Actualizar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get addYourOwn => 'Añade el tuyo...';

  @override
  String get penance => 'Penitencia';

  @override
  String get penanceTracker => 'Registro de penitencias';

  @override
  String get addPenance => 'Añadir Penitencia';

  @override
  String get editPenance => 'Editar Penitencia';

  @override
  String get penanceDescription => '¿Qué penitencia se te dio?';

  @override
  String get penanceHint =>
      'ej., Rezar 3 avemarías, leer un pasaje de la Escritura...';

  @override
  String get penanceAdded => 'Penitencia añadida';

  @override
  String get penanceUpdated => 'Penitencia actualizada';

  @override
  String get penanceCompleted => '¡Penitencia completada! Dios te bendiga.';

  @override
  String get markAsComplete => 'Marcar como Completada';

  @override
  String get pendingPenances => 'Penitencias Pendientes';

  @override
  String get noPendingPenances => 'No hay penitencias pendientes';

  @override
  String get noPendingPenancesDesc =>
      'Todas tus penitencias están completadas. ¡Dios te bendiga!';

  @override
  String completedOn(Object date) {
    return 'Completada el $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Asignada el $date';
  }

  @override
  String get skipPenance => 'Omitir';

  @override
  String get savePenance => 'Guardar Penitencia';

  @override
  String get insights => 'Estadísticas';

  @override
  String get confessionInsights => 'Estadísticas de Confesión';

  @override
  String get totalConfessions => 'Total de Confesiones';

  @override
  String get averageFrequency => 'Frecuencia Promedio';

  @override
  String everyXDays(Object count) {
    return 'Cada $count días';
  }

  @override
  String get daysSinceLastConfession => 'Días desde la última';

  @override
  String get currentStreak => 'Racha Actual';

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
  String get monthlyActivity => 'Actividad Mensual';

  @override
  String get confessionsThisYear => 'Confesiones este Año';

  @override
  String get noInsightsYet => 'Aún no hay estadísticas';

  @override
  String get noInsightsYetDesc =>
      'Completa tu primera confesión para ver las estadísticas de tu viaje espiritual';

  @override
  String get totalItemsConfessed => 'Total de Elementos Confesados';

  @override
  String get firstConfession => 'Primera Confesión';

  @override
  String get spiritualJourney => 'Tu Viaje Espiritual';

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
  String get nextCommandment => 'Siguiente';

  @override
  String get finishExamination => 'Finalizar';

  @override
  String get noQuestionsSelected =>
      'No hay preguntas seleccionadas en esta sección';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count seleccionadas';
  }

  @override
  String get examinationSummary => 'Resumen del Examen';

  @override
  String get examinationNote =>
      'Un examen de conciencia completo va más allá de cualquier lista. Reflexiona en oración sobre tu estado de vida y circunstancias.';

  @override
  String selectedCount(Object count) {
    return '$count elementos seleccionados';
  }

  @override
  String get noSinsSelected => 'Ningún pecado seleccionado';

  @override
  String get continueEditing => 'Continuar Editando';

  @override
  String get proceedToConfess => 'Proceder';

  @override
  String get clearDraftTitle => '¿Borrar Borrador?';

  @override
  String get clearDraftMessage =>
      'Esto eliminará todas las preguntas seleccionadas. ¿Seguro que quieres continuar?';

  @override
  String get clearDraft => 'Borrar Borrador';

  @override
  String get clear => 'Borrar';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restaurados $count ítems de tu última sesión',
      one: 'Restaurado 1 ítem de tu última sesión',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Justo ahora';

  @override
  String minutesAgo(Object count) {
    return 'hace ${count}m';
  }

  @override
  String hoursAgo(Object count) {
    return 'hace ${count}h';
  }

  @override
  String get general => 'General';

  @override
  String get noQuestionsInSection => 'No hay preguntas en esta sección';

  @override
  String get skip => 'Saltar';

  @override
  String get back => 'Atrás';

  @override
  String get skipOnboardingTitle => '¿Saltar Introducción?';

  @override
  String get skipOnboardingMessage =>
      'Irás directamente a la última página. Aquí no se configura nada: puedes cambiarlo todo más tarde en Ajustes.';

  @override
  String get confessionHistoryTitle => 'Historial de Confesiones';

  @override
  String get deleteAll => 'Eliminar Todo';

  @override
  String get editDate => 'Editar Fecha';

  @override
  String get confessionDate => 'Fecha de Confesión';

  @override
  String get dateUpdated => 'Fecha actualizada';

  @override
  String get changeDateConfirmTitle => '¿Cambiar Fecha?';

  @override
  String changeDateConfirmMessage(Object date) {
    return '¿Cambiar fecha de confesión a $date?';
  }

  @override
  String get noGuideContent => 'Contenido de la guía no disponible';

  @override
  String get noGuideContentDesc => 'El contenido de la guía aparecerá aquí';

  @override
  String get noFaqContent => 'No hay preguntas frecuentes disponibles';

  @override
  String get noFaqContentDesc => 'Las preguntas frecuentes aparecerán aquí';

  @override
  String get faqSubtitle => 'Una guía para el Sacramento de la Reconciliación';

  @override
  String get tapToExpand => 'Toca para leer más';

  @override
  String get continueExamination => 'Continuar Examen';

  @override
  String get continueExaminationDesc => 'Tienes un examen en progreso';

  @override
  String examinationProgress(Object count) {
    return '$count elementos seleccionados';
  }

  @override
  String get security => 'Seguridad';

  @override
  String get securitySubtitle => 'Protege tus datos personales';

  @override
  String get pinAndBiometric => 'PIN y Biometría';

  @override
  String get pinAndBiometricSubtitle => 'Configurar ajustes de bloqueo de app';

  @override
  String get enterPin => 'Ingresar PIN';

  @override
  String get createPin => 'Crear PIN';

  @override
  String get confirmPin => 'Confirmar PIN';

  @override
  String get incorrectPin => 'PIN Incorrecto';

  @override
  String get pinMismatch => 'Los PINs no coinciden';

  @override
  String get biometricUnlock => 'Desbloqueo Biométrico';

  @override
  String get autoLockTimeout => 'Tiempo de Auto-Bloqueo';

  @override
  String get tooManyAttempts => 'Demasiados intentos fallidos';

  @override
  String tryAgainIn(Object time) {
    return 'Intenta de nuevo en $time';
  }

  @override
  String get useBiometricUnlock => 'Usar Desbloqueo Biométrico';

  @override
  String get unlockWithFingerprintOrFace =>
      'Desbloquear con huella digital o rostro';

  @override
  String get biometricAccessWarning =>
      'Cualquier persona con una huella digital o rostro registrado en este dispositivo podrá acceder a la aplicación';

  @override
  String get lockAfter => 'Bloquear Después de';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Tiempo en segundo plano antes de bloquear';

  @override
  String get changePin => 'Cambiar PIN';

  @override
  String get updateYourSecurityPin => 'Actualiza tu PIN de seguridad';

  @override
  String get enterCurrentPin => 'Ingresa PIN Actual';

  @override
  String get enterNewPin => 'Ingresa Nuevo PIN';

  @override
  String get confirmNewPin => 'Confirma Nuevo PIN';

  @override
  String get pinChangedSuccessfully => 'PIN cambiado con éxito';

  @override
  String get currentPinIncorrect => 'El PIN actual es incorrecto';

  @override
  String get enableBiometricUnlock => '¿Activar Desbloqueo Biométrico?';

  @override
  String get biometricDescription =>
      'Usa tu huella o rostro para desbloquear la app rápida y seguramente.';

  @override
  String get notNow => 'Ahora no';

  @override
  String get enable => 'Activar';

  @override
  String get setUpPin => 'Configurar PIN';

  @override
  String get createSixDigitPin => 'Crea un PIN de 6 dígitos';

  @override
  String get pinProtectData => 'Este PIN se usará para proteger tus datos';

  @override
  String get confirmYourPin => 'Confirma tu PIN';

  @override
  String get enterSamePinAgain =>
      'Ingresa el mismo PIN de nuevo para confirmar';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Ingresa tu PIN para desbloquear';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'quedan $count intentos',
      one: 'queda 1 intento',
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
  String get undo => 'Deshacer';

  @override
  String get confessionDeleted => 'Confesión eliminada';

  @override
  String get noConfessionHistory => 'Sin historial de confesiones';

  @override
  String get noConfessionHistoryDesc =>
      'Las confesiones completadas aparecerán aquí';

  @override
  String get fontSize => 'Tamaño de Fuente';

  @override
  String get fontSizeSubtitle =>
      'Ajustar tamaño de texto para mejor legibilidad';

  @override
  String get fontSizeSmall => 'Pequeño';

  @override
  String get fontSizeMedium => 'Mediano';

  @override
  String get fontSizeLarge => 'Grande';

  @override
  String get fontSizeExtraLarge => 'Extra Grande';

  @override
  String get forgotPin => '¿Olvidaste el PIN?';

  @override
  String get resetPinTitle => 'Restablecer PIN';

  @override
  String get resetPinWarning =>
      'Advertencia: Esto eliminará permanentemente todos tus datos';

  @override
  String get resetPinDescription =>
      'Si restableces tu PIN, todas tus confesiones, pecados personalizados, penitencias y otros datos personales se eliminarán permanentemente. Esta acción no se puede deshacer.';

  @override
  String get resetPinConfirmation => 'Escribe ELIMINAR para confirmar';

  @override
  String get resetPinButton => 'Restablecer PIN y Borrar Datos';

  @override
  String get resetPinSuccess =>
      'PIN restablecido con éxito. Por favor configura un nuevo PIN.';

  @override
  String get resetPinError =>
      'Error al restablecer PIN. Por favor intenta de nuevo.';

  @override
  String get deleteConfirmationText => 'ELIMINAR';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Por favor espera $seconds segundos';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Verifica tu identidad para restablecer el PIN';

  @override
  String get confessionGuideTitle => 'Cómo hacer una buena confesión';

  @override
  String get shortFilmTitle => 'Confesión: un cortometraje';

  @override
  String get shortFilmSubtitle =>
      'Creado por Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Reino Unido';

  @override
  String get confessionGuideSubtitle => 'Guía paso a paso para el Sacramento';

  @override
  String get invitationTitle => '¿Regresando a la Confesión?';

  @override
  String get invitationSubtitle => 'Una palabra de aliento para ti';

  @override
  String get invitationDialogTitle => 'Te damos la bienvenida';

  @override
  String get invitationDialogContent =>
      '¿Es tu primera confesión en mucho tiempo, o sientes ansiedad por ir?';

  @override
  String get invitationDialogYes => 'Sí, me gustaría algo de aliento';

  @override
  String get invitationDialogNo => 'No, puedo comenzar';

  @override
  String get invitationDialogDontShowAgain => 'No mostrar esto de nuevo';

  @override
  String get searchPrayers => 'Buscar oraciones...';

  @override
  String get allCategories => 'Todas';

  @override
  String get appDisclaimer =>
      'Esta app es una ayuda espiritual para la preparación de la confesión. No es un sustituto del Sacramento de la Reconciliación con un sacerdote.';

  @override
  String get onboardingDisclaimer =>
      'Un compañero espiritual para la confesión—no un reemplazo.';

  @override
  String get readyToBegin => 'Todo Listo';

  @override
  String get readyToBeginSubtitle =>
      'Que tu camino hacia la reconciliación esté lleno de gracia y paz.';

  @override
  String get onboardingOverviewTitle => 'Lo que hace esta app';

  @override
  String get onboardingOverviewExamine => 'Prepara tu conciencia, a tu ritmo.';

  @override
  String get onboardingOverviewConfess =>
      'Una lista discreta, para que nada se olvide.';

  @override
  String get onboardingOverviewJournal =>
      'Una breve reflexión nocturna, para seguir creciendo entre confesiones.';

  @override
  String get onboardingOverviewFootnote =>
      'Las oraciones, las guías y los recordatorios opcionales están dentro.';

  @override
  String get onboardingPrivacyTitle => 'Privado por diseño';

  @override
  String get onboardingPrivacyLocal =>
      'Todo permanece en este teléfono. Sin cuenta, sin nube.';

  @override
  String get onboardingPrivacyEncrypted => 'Cifrado en tu dispositivo.';

  @override
  String get onboardingPrivacyPin =>
      'Crearás un PIN la primera vez que abras un examen o tu diario.';

  @override
  String get sourceCode => 'Código Fuente';

  @override
  String get contentReferences => 'Referencias de Contenido';

  @override
  String get examinationModeTitle => '¿Cómo te gustaría examinar?';

  @override
  String get quickReviewMode => 'Revisión Rápida';

  @override
  String get quickReviewDescription =>
      'Revisa todas las preguntas por categoría';

  @override
  String get deepReflectionMode => 'Reflexión Profunda';

  @override
  String get deepReflectionDescription =>
      'Una pregunta a la vez para un examen reflexivo';

  @override
  String get contemplativePrayerTitle => 'Ven, Espíritu Santo';

  @override
  String get contemplativePrayerText =>
      'Llena mi corazón y enciende en mí el fuego de Tu amor. Ilumina mi mente para que pueda ver mis pecados claramente.';

  @override
  String get imReady => 'Comencemos';

  @override
  String get skipPrayer => 'Omitir';

  @override
  String get yesThisApplies => 'Sí';

  @override
  String get noThisDoesnt => 'No';

  @override
  String get skipQuestion => 'Omitir';

  @override
  String questionProgress(int current, int total) {
    return '$current de $total';
  }

  @override
  String get examinationComplete => 'Examen Completado';

  @override
  String get reviewYourSelections => 'Revisa tus selecciones';

  @override
  String get examinationModeSettingTitle => 'Modo de Examen';

  @override
  String get examinationModeSettingSubtitle =>
      'Elige cómo te gustaría examinar tu conciencia';

  @override
  String get askEveryTime => 'Preguntar Cada Vez';

  @override
  String get reminderNotificationTitle => 'Hora de Confesarse';

  @override
  String get reminderNotificationBody =>
      'Recuerda examinar tu conciencia y prepararte para la confesión';

  @override
  String get notificationPermissionDenied =>
      'Las notificaciones están desactivadas. Permite las notificaciones de Metanoia en los ajustes de tu dispositivo para recibir recordatorios de confesión.';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String get couldNotOpenLink => 'No se pudo abrir el enlace';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos confesados',
      one: '1 elemento confesado',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitencias',
      one: '1 penitencia',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pendientes',
      one: '1 pendiente',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count en total',
      one: '1 en total',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
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
  String get deleteAllConfessionsTitle => '¿Eliminar todas las confesiones?';

  @override
  String get deleteAllConfessionsContent =>
      'Esto eliminará permanentemente todo tu historial de confesiones. Esta acción no se puede deshacer.';

  @override
  String get allConfessionsDeleted => 'Todas las confesiones eliminadas';

  @override
  String get deletePenanceConfirm =>
      '¿Seguro que quieres eliminar esta penitencia?';

  @override
  String get completed => 'Completada';

  @override
  String get tapToCollapse => 'Toca para contraer';

  @override
  String get dismiss => 'Descartar';

  @override
  String showcaseStep(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get done => 'Listo';

  @override
  String get navigate => 'Navegar';

  @override
  String get encouragement => 'Ánimo';

  @override
  String get biometricPromptReason => 'Autentícate para acceder a Metanoia';

  @override
  String get tryAgainInLabel => 'Inténtalo de nuevo en';

  @override
  String get errorLoadingLanguage => 'Error al cargar el idioma';

  @override
  String get detailsNotSaved => 'Detalles no guardados';

  @override
  String get discardStoredSinsTitle => '¿Descartar los pecados guardados?';

  @override
  String get discardStoredSinsContent =>
      'El historial de confesiones ya está desactivado. Los pecados guardados de confesiones anteriores siguen almacenados. ¿Descartarlos? Se conservarán las fechas, para que tus estadísticas y rachas permanezcan intactas.';

  @override
  String get keepThem => 'Conservarlos';

  @override
  String get discard => 'Descartar';

  @override
  String get storedSinsDiscarded =>
      'Pecados guardados descartados. Se conservaron las fechas de confesión.';

  @override
  String get journalTitle => 'Diario';

  @override
  String get journalHomeCardTitle => 'Reflexión de la noche';

  @override
  String get journalHomeCardSubtitle => '¿Cómo fue hoy?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Días seguidos de reflexión';

  @override
  String get journalContinueToday => 'Continúa la entrada de hoy';

  @override
  String get journalPreviousMonth => 'Mes anterior';

  @override
  String get journalNextMonth => 'Mes siguiente';

  @override
  String get journalGratitudeTitle => 'Gratitud';

  @override
  String get journalGratitudePrompt => '¿Dónde vi a Dios hoy?';

  @override
  String get journalGratitudeHint => 'Una gracia que quiero agradecerle…';

  @override
  String get journalPresenceLead =>
      'Dios está aquí contigo. Aquiétate ante Él y da gracias.';

  @override
  String get journalPresenceVerse => 'Rendíos, reconoced que yo soy Dios.';

  @override
  String get journalPresenceRef => 'Salmo 46,11';

  @override
  String get journalLightTitle => 'Pide luz';

  @override
  String get journalLightLead =>
      'Pide al Espíritu Santo la luz para ver tu día como Dios lo ve.';

  @override
  String get journalLightVerse =>
      'Ven, Espíritu Santo, llena los corazones de tus fieles y enciende en ellos el fuego de tu amor.';

  @override
  String get journalReviewTitle => 'Revisa con Dios';

  @override
  String get journalReviewLead =>
      'Recorre de nuevo tu día con el Señor: dónde el amor vino a ti, dónde lo diste y dónde te apartaste.';

  @override
  String get journalReviewVerse =>
      'Sondéame, oh Dios, y conoce mi corazón, ponme a prueba y conoce mis sentimientos, mira si mi camino se desvía, guíame por el camino eterno.';

  @override
  String get journalReviewRef => 'Salmo 139,23-24';

  @override
  String get journalReviewHint => 'Háblale de tu día…';

  @override
  String get journalReviewBringSin => '¿Hay algo que quieras traer ante Él?';

  @override
  String get journalContritionTitle => 'Contrición';

  @override
  String get journalContritionLead =>
      'Lleva lo que has encontrado al Padre, que corre a tu encuentro.';

  @override
  String get journalContritionVerse =>
      'Misericordia, Dios mío, por tu bondad, por tu inmensa compasión borra mi culpa.';

  @override
  String get journalContritionRef => 'Salmo 51,3';

  @override
  String get journalContritionPray => 'Reza el Acto de Contrición';

  @override
  String get journalContritionMercy =>
      'El dolor que nace del amor a Dios, con el propósito de confesarte, abre tu corazón a su misericordia esta noche; y su plenitud te espera en la Confesión, en las palabras de la absolución.';

  @override
  String get journalResolutionLead =>
      'Descansa en su misericordia. Mañana comienza de nuevo en Él.';

  @override
  String get journalResolutionVerse =>
      'No se agota la bondad del Señor, no se acaba su misericordia; se renuevan cada mañana, ¡qué grande es tu fidelidad!';

  @override
  String get journalResolutionRef => 'Lamentaciones 3,22-23';

  @override
  String get journalReflectionTitle => 'Reflexión';

  @override
  String get journalReflectionPrompt => '¿Cómo fue tu día?';

  @override
  String get journalReflectionHint => 'Escribe libremente...';

  @override
  String get journalSinsTitle => 'Marcar pecados';

  @override
  String get journalSinsPrompt => '¿En qué fallé hoy?';

  @override
  String get journalNoSinsMarked => 'Nada marcado todavía';

  @override
  String get journalAddSin => 'Marcar un pecado';

  @override
  String get journalRemoveSin => 'Quitar';

  @override
  String get journalResolutionTitle => 'Esperanza y propósito';

  @override
  String get journalResolutionPrompt => 'Un don para mañana';

  @override
  String get journalResolutionHint => 'Con tu gracia, mañana voy a…';

  @override
  String get journalMoodTitle => 'Estado de ánimo';

  @override
  String get journalMoodPrompt => '¿Cómo está tu alma esta noche?';

  @override
  String get journalMoodDesolate => 'Desolación';

  @override
  String get journalMoodStruggling => 'Lucha';

  @override
  String get journalMoodSteady => 'Serenidad';

  @override
  String get journalMoodGrateful => 'Gratitud';

  @override
  String get journalMoodConsoled => 'Consuelo';

  @override
  String get journalSaved => 'Guardado';

  @override
  String get journalSaving => 'Guardando...';

  @override
  String get journalDeleteEntry => 'Eliminar entrada';

  @override
  String get journalDeleteEntryConfirm =>
      '¿Eliminar la entrada de este día? Esta acción no se puede deshacer.';

  @override
  String get journalEntryDeleted => 'Entrada eliminada';

  @override
  String get journalPickerQuestions => 'Preguntas';

  @override
  String get journalPickerMySins => 'Mis pecados';

  @override
  String get journalPickerOwnWords => 'En mis palabras';

  @override
  String get journalPickerFreeTextHint => 'Descríbelo con tus propias palabras';

  @override
  String get journalSearchSins => 'Buscar pecados...';

  @override
  String get journalAbsolved => 'Confesado';

  @override
  String get journalSinCleared => 'Un pecado que llevaste a la confesión';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Incluye los $count pecados que marcaste en tu diario',
      one: 'Incluye el pecado que marcaste en tu diario',
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
      other: '$count pecados añadidos desde tu diario',
      one: '1 pecado añadido desde tu diario',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Áreas de lucha';

  @override
  String get journalStruggleAreasSubtitle => 'Lo que más marcas en tu diario';

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
  String get journalReminder => 'Recordatorio del diario';

  @override
  String get journalReminderSubtitle =>
      'Un aviso cada noche para reflexionar sobre tu día';

  @override
  String get enableJournalReminder => 'Activar recordatorio del diario';

  @override
  String get journalReminderNotificationTitle => 'Reflexión de la noche';

  @override
  String get journalReminderNotificationBody =>
      'Tómate un momento para repasar tu día con Dios';

  @override
  String get confessionDayMode => 'Modo Confesión';

  @override
  String get confessionDayModeDescription =>
      'Texto grande y sin distracciones para el confesionario';

  @override
  String get exitConfessionMode => 'Salir del modo confesión';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get next => 'Siguiente';

  @override
  String get actOfContrition => 'Acto de Contrición';

  @override
  String get actOfContritionUnavailable =>
      'El Acto de Contrición no está disponible';

  @override
  String get confessionDaySinsTitle => 'Pecados por confesar';

  @override
  String get confessionDayOpeningTitle => 'Inicio';

  @override
  String get confessionDayOpeningIntro =>
      'Haz la Señal de la Cruz y luego comienza:';

  @override
  String get confessionDayOpeningFormula =>
      'Bendígame, Padre, porque he pecado.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Mi última confesión fue hace $duration.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Han pasado [días/semanas/meses/años] desde mi última confesión.';

  @override
  String get confessionDaySinsClosing =>
      'De estos y de todos mis pecados, me arrepiento de todo corazón.';

  @override
  String get confessionDayThanksgivingTitle => 'Ve en paz';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Da gracias al Señor, porque es bueno.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Porque es eterna su misericordia.';

  @override
  String get confessionDayThanksgivingBody =>
      'Tu alma ha quedado limpia. Cumple tu penitencia y avanza en la paz de Cristo.';

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
      one: '1 mes',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count años',
      one: '1 año',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Cuaresma';

  @override
  String get seasonHolyWeek => 'Semana Santa';

  @override
  String get seasonAdvent => 'Adviento';

  @override
  String get seasonChristmas => 'Navidad';

  @override
  String get seasonEaster => 'Pascua';

  @override
  String get seasonOrdinaryTime => 'Tiempo Ordinario';

  @override
  String get feastAshWednesday => 'El Miércoles de Ceniza';

  @override
  String get feastPalmSunday => 'El Domingo de Ramos';

  @override
  String get feastEaster => 'La Pascua';

  @override
  String get feastPentecost => 'Pentecostés';

  @override
  String get feastAssumption => 'La Asunción';

  @override
  String get feastAllSaints => 'Todos los Santos';

  @override
  String get feastImmaculateConception => 'La Inmaculada Concepción';

  @override
  String get feastFirstSundayOfAdvent => 'El primer domingo de Adviento';

  @override
  String get feastChristmas => 'La Navidad';

  @override
  String get liturgicalLentTitle => 'Ha comenzado la Cuaresma';

  @override
  String get liturgicalLentBody =>
      'Un tiempo para volver a Dios. Muchos lo empiezan con la confesión.';

  @override
  String get liturgicalHolyWeekTitle => 'Ha comenzado la Semana Santa';

  @override
  String get liturgicalHolyWeekBody =>
      'La Iglesia camina hacia la Pascua. Todavía hay tiempo para preparar tu corazón.';

  @override
  String get liturgicalAdventTitle => 'Ha comenzado el Adviento';

  @override
  String get liturgicalAdventBody =>
      'Un tiempo de espera. Muchos preparan su corazón con la confesión.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast se acerca';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Faltan $count días: prepara tu corazón.',
      one: 'Falta un día: prepara tu corazón.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Han pasado $count semanas desde tu última confesión',
      one: 'Ha pasado una semana desde tu última confesión',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Cuando quieras, la misericordia te espera. ¿Quieres prepararte?';

  @override
  String get promptPrepare => 'Prepararme';

  @override
  String get dataUnrecoverableTitle => 'No se pueden desbloquear tus datos';

  @override
  String get dataUnrecoverableBody =>
      'La clave que protege tus confesiones ya no está disponible en este dispositivo. Esto puede ocurrir tras restaurar una copia de seguridad o si se restablecieron los ajustes de seguridad del dispositivo.\n\nComo tus datos están cifrados, no pueden recuperarse sin esa clave; ni siquiera nosotros podemos hacerlo. Puedes borrarlos y empezar de nuevo.';

  @override
  String get eraseAndStartOver => 'Borrar y empezar de nuevo';

  @override
  String get eraseAndStartOverConfirm =>
      'Esto borra permanentemente todo lo guardado en este dispositivo y reinicia la aplicación. No se puede deshacer.';

  @override
  String get penanceSaveFailed =>
      'No se pudo guardar la penitencia. Inténtalo de nuevo.';

  @override
  String get confessionReminderChannelName => 'Recordatorios de confesión';

  @override
  String get confessionReminderChannelDescription =>
      'Recordatorios para confesarte';

  @override
  String get journalReminderChannelName => 'Recordatorios del diario';

  @override
  String get journalReminderChannelDescription =>
      'Recordatorio diario para escribir la reflexión de la noche';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count señalados hasta ahora',
      one: 'Uno señalado hasta ahora',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Antes de comenzar';

  @override
  String get invitationCardAction => 'Anímame';

  @override
  String get homeCtaBeginTitle => 'Comienza tu examen de conciencia';

  @override
  String get homeCtaBeginSubtitle => 'Prepara tu corazón antes de la confesión';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Continúa tu examen ($count seleccionados)',
      one: 'Continúa tu examen (1 seleccionado)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Retoma donde lo dejaste';

  @override
  String get homeCtaReadyTitle => 'Ya puedes comenzar';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pecados te esperan en tu lista de confesión',
      one: '1 pecado te espera en tu lista de confesión',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Cumple tu penitencia';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitencias siguen pendientes',
      one: '1 penitencia sigue pendiente',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Aliento, una guía paso a paso, oraciones y preguntas frecuentes';

  @override
  String get homeQuoteReadMore => 'Leer más';

  @override
  String get homeQuoteShowLess => 'Mostrar menos';

  @override
  String get tutorialJournalDesc =>
      'Repasa tu día cada noche: una breve reflexión y tu racha.';
}
