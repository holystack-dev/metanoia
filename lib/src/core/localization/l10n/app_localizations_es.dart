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
  String get homeTitle => 'Bienvenido';

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
      'Idioma para el examen, FAQs y oraciones';

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
      'Encuentra aliento, una guía paso a paso y FAQs aquí.';

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
      'Mira las estadísticas y rachas de tu jornada de confesión.';

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
  String get rateAppSubtitle => 'Califícanos en Play Store';

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
      '¿Estás seguro de que deseas eliminar este pecado personalizado?';

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
  String get penanceTracker => 'Rastreador de Penitencia';

  @override
  String get addPenance => 'Añadir Penitencia';

  @override
  String get editPenance => 'Editar Penitencia';

  @override
  String get penanceDescription => '¿Qué penitencia se te dio?';

  @override
  String get penanceHint => 'ej., Rezar 3 Avemarías, Leer un pasaje...';

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
  String get totalItemsConfessed => 'Total de Ítems Confesados';

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
    return '$count ítems seleccionados';
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
      'Esto eliminará todas las preguntas seleccionadas. ¿Estás seguro?';

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
      'Siempre puedes acceder a la ayuda y ajustes más tarde desde el menú.';

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
  String get noFaqContent => 'FAQs no disponibles';

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
    return '$count ítems seleccionados';
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
  String get confessionGuideSubtitle => 'Guía paso a paso para el Sacramento';

  @override
  String get invitationTitle => '¿Regresando a la Confesión?';

  @override
  String get invitationSubtitle => 'Una palabra de aliento para ti';

  @override
  String get invitationDialogTitle => 'Bienvenido';

  @override
  String get invitationDialogContent =>
      '¿Es tu primera confesión en mucho tiempo, o te sientes ansioso por ir?';

  @override
  String get invitationDialogYes => 'Sí, me gustaría algo de aliento';

  @override
  String get invitationDialogNo => 'No, estoy listo para comenzar';

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
  String get imReady => 'Estoy Listo';

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
}
