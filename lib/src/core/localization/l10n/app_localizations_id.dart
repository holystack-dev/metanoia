// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Beranda';

  @override
  String get examineTitle => 'Periksa Batin';

  @override
  String get confessTitle => 'Mengaku';

  @override
  String get prayersTitle => 'Doa';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get examinationTitle => 'Pemeriksaan Batin';

  @override
  String get commandment => 'Perintah';

  @override
  String get guideTitle => 'Panduan';

  @override
  String get faqTitle => 'Memahami Pengakuan Dosa';

  @override
  String get language => 'Bahasa';

  @override
  String get chooseLanguage => 'Pilih bahasa yang Anda inginkan';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Pilih tema yang Anda inginkan';

  @override
  String get system => 'Sistem';

  @override
  String get light => 'Terang';

  @override
  String get dark => 'Gelap';

  @override
  String get reminders => 'Pengingat';

  @override
  String get getReminded => 'Dapatkan pengingat untuk mengaku dosa';

  @override
  String get enableReminders => 'Aktifkan Pengingat';

  @override
  String get weekly => 'Mingguan';

  @override
  String get biweekly => 'Dua Mingguan';

  @override
  String get monthly => 'Bulanan';

  @override
  String get quarterly => 'Tiga Bulanan';

  @override
  String get day => 'Hari';

  @override
  String get time => 'Waktu';

  @override
  String get remindMe => 'Ingatkan saya';

  @override
  String get onTheDay => 'Pada hari itu';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari sebelumnya',
      one: '1 hari sebelumnya',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Tindakan Cepat';

  @override
  String get lastConfession => 'Pengakuan Terakhir';

  @override
  String get noneYet => 'Belum ada';

  @override
  String get today => 'Hari Ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari yang lalu',
      one: '1 hari yang lalu',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Pengingat Berikutnya';

  @override
  String get off => 'Nonaktif';

  @override
  String get mon => 'Sen';

  @override
  String get tue => 'Sel';

  @override
  String get wed => 'Rab';

  @override
  String get thu => 'Kam';

  @override
  String get fri => 'Jum';

  @override
  String get sat => 'Sab';

  @override
  String get sun => 'Min';

  @override
  String get monday => 'Senin';

  @override
  String get tuesday => 'Selasa';

  @override
  String get wednesday => 'Rabu';

  @override
  String get thursday => 'Kamis';

  @override
  String get friday => 'Jumat';

  @override
  String get saturday => 'Sabtu';

  @override
  String get sunday => 'Minggu';

  @override
  String get appLanguage => 'Bahasa Aplikasi';

  @override
  String get appLanguageSubtitle => 'Bahasa untuk tombol, label, dan menu';

  @override
  String get contentLanguage => 'Bahasa Konten';

  @override
  String get contentLanguageSubtitle =>
      'Bahasa untuk pertanyaan pemeriksaan batin, tanya jawab, dan doa';

  @override
  String get version => 'Versi';

  @override
  String get selectDay => 'Pilih Hari';

  @override
  String selected(num count) {
    return '$count dipilih';
  }

  @override
  String get selectedLabel => 'dipilih';

  @override
  String get counter => 'Penghitung';

  @override
  String get searchPlaceholder => 'Cari perintah atau pertanyaan...';

  @override
  String get noResults => 'Tidak ada hasil';

  @override
  String get viewHistory => 'Lihat Riwayat';

  @override
  String get noActiveConfession => 'Tidak ada pengakuan yang sedang berjalan';

  @override
  String get startExaminationPrompt =>
      'Mulailah pemeriksaan batin untuk menambahkan dosa di sini.';

  @override
  String get startExamination => 'Mulai Pemeriksaan Batin';

  @override
  String get finishConfessionTitle => 'Selesaikan Pengakuan?';

  @override
  String get finishConfessionContent =>
      'Ini akan menandai pengakuan dosa sebagai selesai dan memindahkannya ke riwayat Anda.';

  @override
  String get cancel => 'Batal';

  @override
  String get finish => 'Selesai';

  @override
  String get confessionCompletedMessage =>
      'Pengakuan dosa selesai! Tuhan memberkati Anda.';

  @override
  String get finishConfession => 'Selesaikan Pengakuan';

  @override
  String get error => 'Kesalahan';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get dailyQuoteError => 'Kutipan hari ini tidak dapat dimuat.';

  @override
  String get keepHistory => 'Simpan Riwayat Pengakuan';

  @override
  String get keepHistorySubtitle =>
      'Simpan dosa-dosa Anda beserta tanggalnya. Jika dinonaktifkan, hanya tanggalnya yang disimpan.';

  @override
  String get deleteConfession => 'Hapus Pengakuan';

  @override
  String get deleteConfessionContent =>
      'Ini akan menghapus pengakuan dosa ini beserta seluruh isinya dari riwayat Anda secara permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get tutorialExamineDesc =>
      'Mulailah di sini untuk memeriksa batin Anda sebelum pengakuan dosa.';

  @override
  String get tutorialConfessDesc =>
      'Gunakan ini selama pengakuan dosa untuk mencatat dosa-dosa Anda.';

  @override
  String get tutorialPrayersDesc =>
      'Temukan doa-doa yang lazim untuk sebelum dan sesudah pengakuan dosa.';

  @override
  String get tutorialGuideDesc =>
      'Temukan peneguhan, panduan pengakuan dosa langkah demi langkah, dan tanya jawab di sini.';

  @override
  String get tutorialSettingsDesc =>
      'Sesuaikan pengalaman Anda di sini: ubah bahasa, tema, atur pengingat, dan kelola pengaturan keamanan.';

  @override
  String get tutorialSwipeDesc =>
      'Geser ke kiri atau ke kanan untuk berpindah antarperintah.';

  @override
  String get tutorialSelectDesc =>
      'Ketuk pertanyaan mana pun untuk memilihnya bagi pengakuan dosa Anda.';

  @override
  String get tutorialFinishDesc =>
      'Setelah selesai, ketuk di sini untuk mengakhiri dan melanjutkan ke pengakuan dosa.';

  @override
  String get tutorialCounterDesc =>
      'Ini menunjukkan berapa banyak butir yang telah Anda pilih untuk pengakuan dosa.';

  @override
  String get tutorialMenuDesc =>
      'Akses dosa buatan sendiri dan hapus pilihan Anda dari sini.';

  @override
  String get tutorialPenanceDesc =>
      'Catat penitensi yang diberikan oleh imam Anda di sini.';

  @override
  String get tutorialInsightsDesc =>
      'Lihat statistik dan rangkaian perjalanan pengakuan dosa Anda.';

  @override
  String get tutorialHistoryDesc =>
      'Akses pengakuan dosa Anda yang lalu beserta tanggalnya.';

  @override
  String get replayTutorial => 'Ulangi Tutorial';

  @override
  String get replayTutorialDesc => 'Lihat kembali tutorial aplikasi';

  @override
  String get tutorialReset =>
      'Tutorial disetel ulang! Anda akan melihat panduannya lagi.';

  @override
  String get about => 'Tentang';

  @override
  String get aboutSubtitle => 'Versi, lisensi, dan kode sumber';

  @override
  String get shareApp => 'Bagikan Aplikasi';

  @override
  String get shareAppSubtitle => 'Bagikan kepada teman dan keluarga';

  @override
  String get rateApp => 'Beri Nilai Aplikasi';

  @override
  String get spreadShareTitle => 'Bagikan Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Kenal seseorang yang sudah lama menjauh dari pengakuan dosa? Bantu dia menemukan jalan kembali.';

  @override
  String get spreadShareAction => 'Bagikan';

  @override
  String get spreadRateSubtitle =>
      'Jika Metanoia membantu Anda mempersiapkan diri untuk pengakuan dosa, penilaian membantu orang lain menemukannya.';

  @override
  String get spreadRateAction => 'Beri Nilai';

  @override
  String get rateGateHint => 'Bagaimana Anda menilai pengalaman Anda?';

  @override
  String get rateGateLowest => 'Terendah';

  @override
  String get rateGateHighest => 'Tertinggi';

  @override
  String get rateGateThanks =>
      'Terima kasih — masukan Anda sangat berarti bagi kami.';

  @override
  String rateAppSubtitle(String store) {
    return 'Beri nilai kami di $store';
  }

  @override
  String get website => 'Situs Web';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get madeWithLove => 'Dibuat dengan ❤️ oleh holystack.dev';

  @override
  String get rateDialogTitle => 'Menikmati Metanoia?';

  @override
  String get rateDialogContent =>
      'Jika aplikasi ini bermanfaat bagi Anda, luangkanlah sejenak untuk memberi nilai. Itu sangat membantu kami!';

  @override
  String get rateDialogYes => 'Beri Nilai Sekarang';

  @override
  String get rateDialogNo => 'Tidak, terima kasih';

  @override
  String get rateDialogLater => 'Ingatkan saya nanti';

  @override
  String get greekLabel => 'Yunani';

  @override
  String get nounLabel => 'kata benda';

  @override
  String get metanoiaDefinition =>
      'Perubahan budi dan hati yang mendalam; kebangkitan rohani yang mengubah seluruh diri seseorang dan mengarahkan kembali hidupnya kepada Allah.';

  @override
  String get turnBackToGrace => 'Kembalilah kepada Rahmat';

  @override
  String get welcomeSubtitle =>
      'Panduan Anda untuk pengakuan dosa yang bermakna';

  @override
  String get discoverInnerGrace => 'Temukan Rahmat Batin';

  @override
  String get sacredJourneyBegins => 'Perjalanan suci rekonsiliasi dimulai.';

  @override
  String get beginJourney => 'Mulai Perjalanan';

  @override
  String get getStarted => 'Mulai';

  @override
  String get chooseContentLanguage => 'Pilih Bahasa Konten';

  @override
  String get contentLanguageDescription =>
      'Pilih bahasa untuk doa, pemeriksaan batin, dan panduan';

  @override
  String get changeAnytimeNote =>
      'Anda dapat mengubahnya kapan saja di Pengaturan';

  @override
  String get continueButton => 'Lanjutkan';

  @override
  String get examineDescription =>
      'Periksalah batin Anda dengan Sepuluh Perintah Allah sebelum pengakuan dosa';

  @override
  String get confessDescription =>
      'Catat dosa-dosa Anda selama pengakuan dosa agar tidak ada yang terlupakan';

  @override
  String get prayersDescription =>
      'Akses doa-doa untuk sebelum dan sesudah pengakuan dosa, serta doa penitensi';

  @override
  String get remindersDescription =>
      'Atur pengingat berkala di Pengaturan agar Anda tidak pernah lupa untuk mengaku dosa';

  @override
  String get nextButton => 'Berikutnya';

  @override
  String get customSins => 'Dosa Buatan Sendiri';

  @override
  String get manageCustomSins => 'Kelola Dosa Buatan Sendiri';

  @override
  String get addCustomSin => 'Tambah Dosa Buatan Sendiri';

  @override
  String get editCustomSin => 'Ubah Dosa Buatan Sendiri';

  @override
  String get deleteCustomSin => 'Hapus Dosa Buatan Sendiri';

  @override
  String get sinDescription => 'Uraian Dosa';

  @override
  String get sinDescriptionHint => 'Uraikan dosa yang ingin Anda ingat';

  @override
  String get sinDescriptionRequired => 'Mohon masukkan uraian dosa';

  @override
  String get optionalNote => 'Catatan Tambahan';

  @override
  String get optionalNoteHint => 'Tambahkan keterangan lain bila perlu';

  @override
  String get selectCommandment => 'Pilih Perintah (Opsional)';

  @override
  String get noCommandment => 'Umum / Tanpa Perintah';

  @override
  String get customSinAdded => 'Dosa buatan sendiri ditambahkan';

  @override
  String get customSinUpdated => 'Dosa buatan sendiri diperbarui';

  @override
  String get customSinDeleted => 'Dosa buatan sendiri dihapus';

  @override
  String get deleteCustomSinConfirm =>
      'Apakah Anda yakin ingin menghapus dosa buatan sendiri ini?';

  @override
  String get noCustomSins => 'Belum ada dosa buatan sendiri';

  @override
  String get noCustomSinsDesc =>
      'Tambahkan dosa buatan sendiri untuk menyesuaikan pemeriksaan batin Anda';

  @override
  String get customVersion => 'Buatan Sendiri (Diubah)';

  @override
  String get searchCustomSins => 'Cari dosa buatan sendiri...';

  @override
  String get addButton => 'Tambah';

  @override
  String get updateButton => 'Perbarui';

  @override
  String get deleteButton => 'Hapus';

  @override
  String get addYourOwn => 'Tambahkan milik Anda sendiri...';

  @override
  String get penance => 'Penitensi';

  @override
  String get penanceTracker => 'Catatan Penitensi';

  @override
  String get addPenance => 'Tambah Penitensi';

  @override
  String get editPenance => 'Ubah Penitensi';

  @override
  String get penanceDescription => 'Penitensi apa yang diberikan kepada Anda?';

  @override
  String get penanceHint =>
      'mis., Daraskan 3 Salam Maria, bacalah satu perikop Kitab Suci...';

  @override
  String get penanceAdded => 'Penitensi ditambahkan';

  @override
  String get penanceUpdated => 'Penitensi diperbarui';

  @override
  String get penanceCompleted => 'Penitensi selesai! Tuhan memberkati Anda.';

  @override
  String get markAsComplete => 'Tandai Selesai';

  @override
  String get pendingPenances => 'Penitensi yang Belum Selesai';

  @override
  String get noPendingPenances => 'Tidak ada penitensi yang belum selesai';

  @override
  String get noPendingPenancesDesc =>
      'Semua penitensi Anda telah selesai. Tuhan memberkati!';

  @override
  String completedOn(Object date) {
    return 'Selesai pada $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Diberikan pada $date';
  }

  @override
  String get skipPenance => 'Lewati';

  @override
  String get savePenance => 'Simpan Penitensi';

  @override
  String get insights => 'Wawasan';

  @override
  String get confessionInsights => 'Wawasan Pengakuan Dosa';

  @override
  String get totalConfessions => 'Total Pengakuan Dosa';

  @override
  String get averageFrequency => 'Frekuensi Rata-rata';

  @override
  String everyXDays(Object count) {
    return 'Setiap $count hari';
  }

  @override
  String get daysSinceLastConfession => 'Hari Sejak Terakhir';

  @override
  String get currentStreak => 'Rangkaian Saat Ini';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minggu',
      one: '1 minggu',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Kegiatan Bulanan';

  @override
  String get confessionsThisYear => 'Pengakuan Dosa Tahun Ini';

  @override
  String get noInsightsYet => 'Belum ada wawasan';

  @override
  String get noInsightsYetDesc =>
      'Selesaikan pengakuan dosa pertama Anda untuk melihat statistik perjalanan rohani Anda';

  @override
  String get totalItemsConfessed => 'Total Butir yang Diakukan';

  @override
  String get firstConfession => 'Pengakuan Dosa Pertama';

  @override
  String get spiritualJourney => 'Perjalanan Rohani Anda';

  @override
  String get listView => 'Daftar';

  @override
  String get guidedView => 'Terpandu';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current dari $total';
  }

  @override
  String get previousCommandment => 'Sebelumnya';

  @override
  String get nextCommandment => 'Berikutnya';

  @override
  String get finishExamination => 'Selesai';

  @override
  String get noQuestionsSelected =>
      'Tidak ada pertanyaan yang dipilih di bagian ini';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count dipilih';
  }

  @override
  String get examinationSummary => 'Ringkasan pemeriksaan batin';

  @override
  String get examinationNote =>
      'Pemeriksaan batin yang menyeluruh melampaui daftar mana pun. Renungkanlah dalam doa keadaan hidup dan situasi Anda.';

  @override
  String selectedCount(Object count) {
    return '$count butir dipilih';
  }

  @override
  String get noSinsSelected => 'Belum ada dosa yang dipilih';

  @override
  String get continueEditing => 'Lanjutkan menyunting';

  @override
  String get proceedToConfess => 'Lanjutkan';

  @override
  String get clearDraftTitle => 'Kosongkan draf?';

  @override
  String get clearDraftMessage =>
      'Semua pertanyaan yang dipilih akan dihapus. Apakah Anda yakin?';

  @override
  String get clearDraft => 'Kosongkan draf';

  @override
  String get clear => 'Kosongkan';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count butir dipulihkan dari sesi terakhir Anda',
      one: '1 butir dipulihkan dari sesi terakhir Anda',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Baru saja';

  @override
  String minutesAgo(Object count) {
    return '$count mnt lalu';
  }

  @override
  String hoursAgo(Object count) {
    return '$count jam lalu';
  }

  @override
  String get general => 'Umum';

  @override
  String get noQuestionsInSection => 'Tidak ada pertanyaan di bagian ini';

  @override
  String get skip => 'Lewati';

  @override
  String get back => 'Kembali';

  @override
  String get skipOnboardingTitle => 'Lewati pengantar?';

  @override
  String get skipOnboardingMessage =>
      'Anda akan langsung menuju halaman terakhir. Tidak ada yang disiapkan di sini — Anda dapat mengubah semuanya nanti di Pengaturan.';

  @override
  String get confessionHistoryTitle => 'Riwayat pengakuan dosa';

  @override
  String get deleteAll => 'Hapus semua';

  @override
  String get editDate => 'Ubah tanggal';

  @override
  String get confessionDate => 'Tanggal pengakuan dosa';

  @override
  String get dateUpdated => 'Tanggal diperbarui';

  @override
  String get changeDateConfirmTitle => 'Ubah tanggal?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Ubah tanggal pengakuan dosa menjadi $date?';
  }

  @override
  String get noGuideContent => 'Tidak ada isi panduan';

  @override
  String get noGuideContentDesc => 'Isi panduan akan tampil di sini';

  @override
  String get noFaqContent => 'Tidak ada tanya jawab';

  @override
  String get noFaqContentDesc =>
      'Pertanyaan yang sering diajukan akan tampil di sini';

  @override
  String get faqSubtitle => 'Panduan untuk Sakramen Tobat';

  @override
  String get tapToExpand => 'Ketuk untuk membaca selengkapnya';

  @override
  String get continueExamination => 'Lanjutkan pemeriksaan batin';

  @override
  String get continueExaminationDesc =>
      'Anda memiliki pemeriksaan batin yang sedang berlangsung';

  @override
  String examinationProgress(Object count) {
    return '$count butir dipilih';
  }

  @override
  String get security => 'Keamanan';

  @override
  String get securitySubtitle => 'Lindungi data pribadi Anda';

  @override
  String get pinAndBiometric => 'PIN & biometrik';

  @override
  String get pinAndBiometricSubtitle => 'Atur pengaturan kunci aplikasi';

  @override
  String get enterPin => 'Masukkan PIN';

  @override
  String get createPin => 'Buat PIN';

  @override
  String get confirmPin => 'Konfirmasi PIN';

  @override
  String get incorrectPin => 'PIN salah';

  @override
  String get pinMismatch => 'PIN tidak cocok';

  @override
  String get biometricUnlock => 'Buka dengan biometrik';

  @override
  String get autoLockTimeout => 'Waktu kunci otomatis';

  @override
  String get tooManyAttempts => 'Terlalu banyak percobaan yang gagal';

  @override
  String tryAgainIn(Object time) {
    return 'Coba lagi dalam $time';
  }

  @override
  String get useBiometricUnlock => 'Gunakan buka kunci biometrik';

  @override
  String get unlockWithFingerprintOrFace => 'Buka dengan sidik jari atau wajah';

  @override
  String get biometricAccessWarning =>
      'Siapa pun yang sidik jari atau wajahnya terdaftar pada perangkat ini akan dapat mengakses aplikasi';

  @override
  String get lockAfter => 'Kunci setelah';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Lama aplikasi di latar belakang sebelum terkunci';

  @override
  String get changePin => 'Ubah PIN';

  @override
  String get updateYourSecurityPin => 'Perbarui PIN keamanan Anda';

  @override
  String get enterCurrentPin => 'Masukkan PIN saat ini';

  @override
  String get enterNewPin => 'Masukkan PIN baru';

  @override
  String get confirmNewPin => 'Konfirmasi PIN baru';

  @override
  String get pinChangedSuccessfully => 'PIN berhasil diubah';

  @override
  String get currentPinIncorrect => 'PIN saat ini salah';

  @override
  String get enableBiometricUnlock => 'Aktifkan buka kunci biometrik?';

  @override
  String get biometricDescription =>
      'Gunakan sidik jari atau wajah Anda untuk membuka aplikasi dengan cepat dan aman.';

  @override
  String get notNow => 'Nanti saja';

  @override
  String get enable => 'Aktifkan';

  @override
  String get setUpPin => 'Siapkan PIN';

  @override
  String get createSixDigitPin => 'Buat PIN 6 digit';

  @override
  String get pinProtectData =>
      'PIN ini akan digunakan untuk melindungi data Anda';

  @override
  String get confirmYourPin => 'Konfirmasi PIN Anda';

  @override
  String get enterSamePinAgain =>
      'Masukkan kembali PIN yang sama untuk mengonfirmasi';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Masukkan PIN Anda untuk membuka';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count percobaan tersisa',
      one: '1 percobaan tersisa',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count detik',
      one: '1 detik',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count menit',
      one: '1 menit',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Urungkan';

  @override
  String get confessionDeleted => 'Pengakuan dosa dihapus';

  @override
  String get noConfessionHistory => 'Belum ada riwayat pengakuan dosa';

  @override
  String get noConfessionHistoryDesc =>
      'Pengakuan dosa yang telah selesai akan tampil di sini';

  @override
  String get fontSize => 'Ukuran huruf';

  @override
  String get fontSizeSubtitle =>
      'Sesuaikan ukuran teks agar lebih mudah dibaca';

  @override
  String get fontSizeSmall => 'Kecil';

  @override
  String get fontSizeMedium => 'Sedang';

  @override
  String get fontSizeLarge => 'Besar';

  @override
  String get fontSizeExtraLarge => 'Sangat besar';

  @override
  String get forgotPin => 'Lupa PIN?';

  @override
  String get resetPinTitle => 'Atur ulang PIN';

  @override
  String get resetPinWarning =>
      'Peringatan: Tindakan ini akan menghapus seluruh data Anda secara permanen';

  @override
  String get resetPinDescription =>
      'Jika Anda mengatur ulang PIN, semua pengakuan dosa, dosa buatan sendiri, penitensi, dan data pribadi Anda yang lain akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get resetPinConfirmation => 'Ketik HAPUS untuk mengonfirmasi';

  @override
  String get resetPinButton => 'Atur ulang PIN & hapus data';

  @override
  String get resetPinSuccess =>
      'PIN berhasil diatur ulang. Silakan siapkan PIN baru.';

  @override
  String get resetPinError => 'Gagal mengatur ulang PIN. Silakan coba lagi.';

  @override
  String get deleteConfirmationText => 'HAPUS';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Harap tunggu $seconds detik';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Verifikasi identitas Anda untuk menyetel ulang PIN';

  @override
  String get confessionGuideTitle => 'Cara Mengaku Dosa dengan Baik';

  @override
  String get shortFilmTitle => 'Pengakuan Dosa: Sebuah Film Pendek';

  @override
  String get shortFilmSubtitle =>
      'Dibuat oleh Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Britania Raya';

  @override
  String get confessionGuideSubtitle =>
      'Panduan langkah demi langkah untuk Sakramen Tobat';

  @override
  String get invitationTitle => 'Kembali Mengaku Dosa?';

  @override
  String get invitationSubtitle => 'Sepatah kata peneguhan untuk Anda';

  @override
  String get invitationDialogTitle => 'Selamat Datang';

  @override
  String get invitationDialogContent =>
      'Apakah ini pengakuan dosa pertama Anda setelah sekian lama, atau Anda merasa cemas untuk pergi mengaku?';

  @override
  String get invitationDialogYes => 'Ya, saya ingin peneguhan';

  @override
  String get invitationDialogNo => 'Tidak, saya siap memulai';

  @override
  String get invitationDialogDontShowAgain => 'Jangan tampilkan lagi';

  @override
  String get searchPrayers => 'Cari doa...';

  @override
  String get allCategories => 'Semua';

  @override
  String get appDisclaimer =>
      'Aplikasi ini adalah sarana rohani untuk persiapan pengakuan dosa. Aplikasi ini bukan pengganti Sakramen Tobat bersama seorang imam.';

  @override
  String get onboardingDisclaimer =>
      'Pendamping rohani untuk pengakuan dosa—bukan penggantinya.';

  @override
  String get readyToBegin => 'Anda Sudah Siap';

  @override
  String get readyToBeginSubtitle =>
      'Semoga perjalanan Anda menuju rekonsiliasi dipenuhi rahmat dan damai.';

  @override
  String get onboardingOverviewTitle => 'Apa yang dilakukan aplikasi ini';

  @override
  String get onboardingOverviewExamine =>
      'Siapkan batin Anda, sesuai irama Anda sendiri.';

  @override
  String get onboardingOverviewConfess =>
      'Daftar periksa yang tidak mencolok, agar tidak ada yang terlupakan.';

  @override
  String get onboardingOverviewJournal =>
      'Refleksi singkat di malam hari, untuk terus bertumbuh di antara pengakuan dosa.';

  @override
  String get onboardingOverviewFootnote =>
      'Doa-doa, panduan, dan pengingat opsional tersedia di dalam.';

  @override
  String get onboardingPrivacyTitle => 'Privat sejak dirancang';

  @override
  String get onboardingPrivacyLocal =>
      'Semuanya tetap di ponsel ini. Tanpa akun, tanpa cloud.';

  @override
  String get onboardingPrivacyEncrypted => 'Terenkripsi di perangkat Anda.';

  @override
  String get onboardingPrivacyPin =>
      'Anda akan membuat PIN saat pertama kali membuka pemeriksaan batin atau jurnal Anda.';

  @override
  String get sourceCode => 'Kode Sumber';

  @override
  String get contentReferences => 'Referensi Konten';

  @override
  String get examinationModeTitle => 'Bagaimana Anda ingin memeriksa batin?';

  @override
  String get quickReviewMode => 'Tinjauan Cepat';

  @override
  String get quickReviewDescription =>
      'Telusuri semua pertanyaan menurut kategori';

  @override
  String get deepReflectionMode => 'Refleksi Mendalam';

  @override
  String get deepReflectionDescription =>
      'Satu pertanyaan pada satu waktu untuk pemeriksaan yang penuh perenungan';

  @override
  String get contemplativePrayerTitle => 'Datanglah, Roh Kudus';

  @override
  String get contemplativePrayerText =>
      'Penuhilah hatiku dan nyalakanlah di dalam diriku api cinta-Mu. Terangilah budiku agar aku dapat melihat dosa-dosaku dengan jelas.';

  @override
  String get imReady => 'Saya Siap';

  @override
  String get skipPrayer => 'Lewati';

  @override
  String get yesThisApplies => 'Ya';

  @override
  String get noThisDoesnt => 'Tidak';

  @override
  String get skipQuestion => 'Lewati';

  @override
  String questionProgress(int current, int total) {
    return '$current dari $total';
  }

  @override
  String get examinationComplete => 'Pemeriksaan Batin Selesai';

  @override
  String get reviewYourSelections => 'Tinjau pilihan Anda';

  @override
  String get examinationModeSettingTitle => 'Mode Pemeriksaan Batin';

  @override
  String get examinationModeSettingSubtitle =>
      'Pilih bagaimana Anda ingin memeriksa batin Anda';

  @override
  String get askEveryTime => 'Tanyakan Setiap Kali';

  @override
  String get reminderNotificationTitle => 'Waktunya Mengaku Dosa';

  @override
  String get reminderNotificationBody =>
      'Ingatlah untuk memeriksa batin Anda dan bersiap untuk pengakuan dosa';

  @override
  String get notificationPermissionDenied =>
      'Notifikasi dinonaktifkan. Izinkan notifikasi untuk Metanoia di pengaturan perangkat Anda untuk menerima pengingat pengakuan dosa.';

  @override
  String get openSourceLicenses => 'Lisensi Sumber Terbuka';

  @override
  String get couldNotOpenLink => 'Tidak dapat membuka tautan';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count butir diakukan',
      one: '1 butir diakukan',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitensi',
      one: '1 penitensi',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tertunda',
      one: '1 tertunda',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'total $count',
      one: 'total 1',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count butir',
      one: '1 butir',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
      one: '1 hari',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mgg',
      one: '1 mgg',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Hapus Semua Pengakuan?';

  @override
  String get deleteAllConfessionsContent =>
      'Ini akan menghapus seluruh riwayat pengakuan dosa Anda secara permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get allConfessionsDeleted => 'Semua pengakuan dihapus';

  @override
  String get deletePenanceConfirm =>
      'Apakah Anda yakin ingin menghapus penitensi ini?';

  @override
  String get completed => 'Selesai';

  @override
  String get tapToCollapse => 'Ketuk untuk menutup';

  @override
  String get dismiss => 'Tutup';

  @override
  String showcaseStep(int current, int total) {
    return 'Langkah $current dari $total';
  }

  @override
  String get done => 'Selesai';

  @override
  String get navigate => 'Buka';

  @override
  String get encouragement => 'Peneguhan';

  @override
  String get biometricPromptReason => 'Autentikasi untuk mengakses Metanoia';

  @override
  String get tryAgainInLabel => 'Coba lagi dalam';

  @override
  String get errorLoadingLanguage => 'Gagal memuat bahasa';

  @override
  String get detailsNotSaved => 'Rincian tidak disimpan';

  @override
  String get discardStoredSinsTitle => 'Buang dosa yang tersimpan?';

  @override
  String get discardStoredSinsContent =>
      'Riwayat pengakuan kini nonaktif. Dosa-dosa yang sudah tersimpan dari pengakuan sebelumnya masih ada. Buang semuanya? Tanggalnya akan tetap disimpan, sehingga wawasan dan rangkaian Anda tetap utuh.';

  @override
  String get keepThem => 'Simpan saja';

  @override
  String get discard => 'Buang';

  @override
  String get storedSinsDiscarded =>
      'Dosa-dosa tersimpan telah dibuang. Tanggal pengakuan tetap disimpan.';

  @override
  String get journalTitle => 'Jurnal';

  @override
  String get journalHomeCardTitle => 'Refleksi malam';

  @override
  String get journalHomeCardSubtitle => 'Bagaimana hari ini?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
      one: '$count hari',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Hari refleksi berturut-turut';

  @override
  String get journalContinueToday => 'Lanjutkan catatan hari ini';

  @override
  String get journalPreviousMonth => 'Bulan sebelumnya';

  @override
  String get journalNextMonth => 'Bulan berikutnya';

  @override
  String get journalGratitudeTitle => 'Syukur';

  @override
  String get journalGratitudePrompt => 'Di mana aku melihat Tuhan hari ini?';

  @override
  String get journalGratitudeHint =>
      'Sebuah rahmat yang ingin kusyukuri kepada-Nya…';

  @override
  String get journalPresenceLead =>
      'Allah hadir di sini bersamamu. Diamlah di hadapan-Nya, dan bersyukurlah.';

  @override
  String get journalPresenceVerse =>
      'Diamlah dan ketahuilah, bahwa Akulah Allah!';

  @override
  String get journalPresenceRef => 'Mazmur 46:11';

  @override
  String get journalLightTitle => 'Mohon Terang';

  @override
  String get journalLightLead =>
      'Mohonlah terang kepada Roh Kudus untuk melihat harimu sebagaimana Allah melihatnya.';

  @override
  String get journalLightVerse =>
      'Datanglah, ya Roh Kudus, penuhilah hati umat-Mu, dan nyalakanlah di dalamnya api cinta-Mu.';

  @override
  String get journalReviewTitle => 'Meninjau Bersama Allah';

  @override
  String get journalReviewLead =>
      'Telusuri kembali harimu bersama Tuhan: di mana kasih datang kepadamu, di mana engkau memberikannya, dan di mana engkau berpaling.';

  @override
  String get journalReviewVerse =>
      'Selidikilah aku, ya Allah, dan kenallah hatiku, ujilah aku dan kenallah pikiran-pikiranku; lihatlah, apakah jalanku serong, dan tuntunlah aku di jalan yang kekal!';

  @override
  String get journalReviewRef => 'Mazmur 139:23-24';

  @override
  String get journalReviewHint => 'Bicaralah kepada-Nya tentang harimu…';

  @override
  String get journalReviewBringSin =>
      'Adakah sesuatu yang ingin engkau bawa kepada-Nya?';

  @override
  String get journalContritionTitle => 'Penyesalan';

  @override
  String get journalContritionLead =>
      'Bawalah kepada Bapa apa yang telah kautemukan; Ia berlari menyambutmu.';

  @override
  String get journalContritionVerse =>
      'Kasihanilah aku, ya Allah, menurut kasih setia-Mu, hapuskanlah pelanggaranku menurut rahmat-Mu yang besar!';

  @override
  String get journalContritionRef => 'Mazmur 51:3';

  @override
  String get journalContritionPray => 'Ucapkan Doa Tobat';

  @override
  String get journalContritionMercy =>
      'Penyesalan yang lahir dari cinta kepada Allah, disertai niat untuk mengaku dosa, membuka hatimu bagi kerahiman-Nya malam ini; dan kepenuhannya menanti engkau dalam Sakramen Pengakuan, dalam kata-kata absolusi.';

  @override
  String get journalResolutionLead =>
      'Beristirahatlah dalam kerahiman-Nya. Esok dimulai kembali di dalam Dia.';

  @override
  String get journalResolutionVerse =>
      'Tak berkesudahan kasih setia TUHAN, tak habis-habisnya rahmat-Nya, selalu baru tiap pagi; besar kesetiaan-Mu!';

  @override
  String get journalResolutionRef => 'Ratapan 3:22-23';

  @override
  String get journalReflectionTitle => 'Refleksi';

  @override
  String get journalReflectionPrompt => 'Bagaimana hari Anda?';

  @override
  String get journalReflectionHint => 'Tulislah dengan bebas...';

  @override
  String get journalSinsTitle => 'Tandai dosa';

  @override
  String get journalSinsPrompt => 'Dalam hal apa aku gagal hari ini?';

  @override
  String get journalNoSinsMarked => 'Belum ada yang ditandai';

  @override
  String get journalAddSin => 'Tandai sebuah dosa';

  @override
  String get journalRemoveSin => 'Hapus';

  @override
  String get journalResolutionTitle => 'Harapan & Niat';

  @override
  String get journalResolutionPrompt => 'Satu anugerah untuk esok hari';

  @override
  String get journalResolutionHint => 'Dengan rahmat-Mu, esok aku akan…';

  @override
  String get journalMoodTitle => 'Suasana hati';

  @override
  String get journalMoodPrompt => 'Bagaimana keadaan jiwa Anda malam ini?';

  @override
  String get journalMoodDesolate => 'Hampa';

  @override
  String get journalMoodStruggling => 'Berjuang';

  @override
  String get journalMoodSteady => 'Tenang';

  @override
  String get journalMoodGrateful => 'Bersyukur';

  @override
  String get journalMoodConsoled => 'Terhibur';

  @override
  String get journalSaved => 'Tersimpan';

  @override
  String get journalSaving => 'Menyimpan...';

  @override
  String get journalDeleteEntry => 'Hapus catatan';

  @override
  String get journalDeleteEntryConfirm =>
      'Hapus catatan ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get journalEntryDeleted => 'Catatan dihapus';

  @override
  String get journalPickerQuestions => 'Pertanyaan';

  @override
  String get journalPickerMySins => 'Dosa saya';

  @override
  String get journalPickerOwnWords => 'Dengan kata-kata saya sendiri';

  @override
  String get journalPickerFreeTextHint =>
      'Uraikan dengan kata-kata Anda sendiri';

  @override
  String get journalSearchSins => 'Cari dosa...';

  @override
  String get journalAbsolved => 'Sudah diakukan';

  @override
  String get journalSinCleared =>
      'Sebuah dosa yang Anda bawa ke pengakuan dosa';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sertakan $count dosa yang Anda tandai dalam jurnal',
      one: 'Sertakan dosa yang Anda tandai dalam jurnal',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Sertakan';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosa ditambahkan dari jurnal Anda',
      one: '1 dosa ditambahkan dari jurnal Anda',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Bidang perjuangan';

  @override
  String get journalStruggleAreasSubtitle =>
      'Paling sering ditandai dalam jurnal Anda';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tanda',
      one: '1 tanda',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Pengingat jurnal';

  @override
  String get journalReminderSubtitle =>
      'Ajakan lembut setiap malam untuk merenungkan hari Anda';

  @override
  String get enableJournalReminder => 'Aktifkan pengingat jurnal';

  @override
  String get journalReminderNotificationTitle => 'Refleksi malam';

  @override
  String get journalReminderNotificationBody =>
      'Luangkan sejenak untuk menengok kembali hari Anda bersama Tuhan';

  @override
  String get confessionDayMode => 'Mode Pengakuan Dosa';

  @override
  String get confessionDayModeDescription =>
      'Teks besar dan bebas gangguan untuk di kamar pengakuan';

  @override
  String get exitConfessionMode => 'Keluar dari mode pengakuan dosa';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Langkah $current dari $total';
  }

  @override
  String get next => 'Berikutnya';

  @override
  String get actOfContrition => 'Doa Tobat';

  @override
  String get actOfContritionUnavailable => 'Doa Tobat tidak tersedia';

  @override
  String get confessionDaySinsTitle => 'Dosa-dosa yang akan diakukan';

  @override
  String get confessionDayOpeningTitle => 'Pembukaan';

  @override
  String get confessionDayOpeningIntro => 'Buatlah Tanda Salib, lalu mulailah:';

  @override
  String get confessionDayOpeningFormula =>
      'Berkatilah saya, Romo, sebab saya telah berdosa.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Sudah $duration sejak pengakuan dosa saya yang terakhir.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Sudah [hari/minggu/bulan/tahun] sejak pengakuan dosa saya yang terakhir.';

  @override
  String get confessionDaySinsClosing =>
      'Saya sungguh menyesal atas dosa-dosa ini dan semua dosa saya.';

  @override
  String get confessionDayThanksgivingTitle => 'Pergilah dalam damai';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Bersyukurlah kepada Tuhan, sebab Ia baik.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Kekal abadi kasih setia-Nya.';

  @override
  String get confessionDayThanksgivingBody =>
      'Jiwamu telah dibasuh bersih. Laksanakan penitensimu dan melangkahlah dalam damai Kristus.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minggu',
      one: '1 minggu',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bulan',
      one: '1 bulan',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tahun',
      one: '1 tahun',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Masa Prapaskah';

  @override
  String get seasonHolyWeek => 'Pekan Suci';

  @override
  String get seasonAdvent => 'Masa Adven';

  @override
  String get seasonChristmas => 'Masa Natal';

  @override
  String get seasonEaster => 'Masa Paskah';

  @override
  String get seasonOrdinaryTime => 'Masa Biasa';

  @override
  String get feastAshWednesday => 'Rabu Abu';

  @override
  String get feastPalmSunday => 'Minggu Palma';

  @override
  String get feastEaster => 'Paskah';

  @override
  String get feastPentecost => 'Pentakosta';

  @override
  String get feastAssumption => 'Maria Diangkat ke Surga';

  @override
  String get feastAllSaints => 'Semua Orang Kudus';

  @override
  String get feastImmaculateConception => 'Maria Dikandung Tanpa Noda';

  @override
  String get feastFirstSundayOfAdvent => 'Minggu Adven Pertama';

  @override
  String get feastChristmas => 'Natal';

  @override
  String get liturgicalLentTitle => 'Masa Prapaskah telah dimulai';

  @override
  String get liturgicalLentBody =>
      'Masa untuk kembali. Banyak orang mengawalinya dengan pengakuan dosa.';

  @override
  String get liturgicalHolyWeekTitle => 'Pekan Suci telah dimulai';

  @override
  String get liturgicalHolyWeekBody =>
      'Gereja melangkah menuju Paskah. Masih ada waktu untuk mempersiapkan hati Anda.';

  @override
  String get liturgicalAdventTitle => 'Masa Adven telah dimulai';

  @override
  String get liturgicalAdventBody =>
      'Masa penantian. Banyak orang mempersiapkan hati mereka dengan pengakuan dosa.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast sudah dekat';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tinggal $count hari lagi — persiapkanlah hati Anda.',
      one: 'Tinggal satu hari lagi — persiapkanlah hati Anda.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sudah $count minggu sejak pengakuan dosa Anda yang terakhir',
      one: 'Sudah satu minggu sejak pengakuan dosa Anda yang terakhir',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Kapan pun Anda siap, kerahiman menanti. Maukah Anda bersiap?';

  @override
  String get promptPrepare => 'Bersiap';

  @override
  String get dataUnrecoverableTitle => 'Data Anda tidak dapat dibuka';

  @override
  String get dataUnrecoverableBody =>
      'Kunci yang melindungi pengakuan dosa Anda tidak lagi tersedia di perangkat ini. Hal ini dapat terjadi setelah pemulihan dari cadangan, atau jika pengaturan keamanan perangkat disetel ulang.\n\nKarena data Anda terenkripsi, data itu tidak dapat dipulihkan tanpa kunci tersebut — bahkan oleh kami sekalipun. Anda dapat menghapusnya dan memulai kembali.';

  @override
  String get eraseAndStartOver => 'Hapus dan mulai dari awal';

  @override
  String get eraseAndStartOverConfirm =>
      'Ini akan menghapus secara permanen semua yang tersimpan di perangkat ini dan memulai aplikasi dari awal. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get penanceSaveFailed =>
      'Penitensi tidak dapat disimpan. Silakan coba lagi.';

  @override
  String get confessionReminderChannelName => 'Pengingat Pengakuan Dosa';

  @override
  String get confessionReminderChannelDescription =>
      'Pengingat untuk mengaku dosa';

  @override
  String get journalReminderChannelName => 'Pengingat Jurnal';

  @override
  String get journalReminderChannelDescription =>
      'Pengingat harian untuk menulis renungan malam';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosa disebutkan sejauh ini',
      one: 'Satu dosa disebutkan sejauh ini',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Sebelum Anda mulai';

  @override
  String get invitationCardAction => 'Teguhkan saya';

  @override
  String get homeCtaBeginTitle => 'Mulai pemeriksaan batin Anda';

  @override
  String get homeCtaBeginSubtitle =>
      'Persiapkan hati Anda sebelum pengakuan dosa';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Lanjutkan pemeriksaan batin Anda ($count dipilih)',
      one: 'Lanjutkan pemeriksaan batin Anda (1 dipilih)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Lanjutkan dari tempat Anda berhenti';

  @override
  String get homeCtaReadyTitle => 'Anda sudah siap';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dosa menanti dalam daftar pengakuan Anda',
      one: '1 dosa menanti dalam daftar pengakuan Anda',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Selesaikan penitensi Anda';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count penitensi masih menanti',
      one: '1 penitensi masih menanti',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Peneguhan, panduan langkah demi langkah, doa-doa, dan tanya jawab';

  @override
  String get homeQuoteReadMore => 'Baca selengkapnya';

  @override
  String get homeQuoteShowLess => 'Tampilkan lebih sedikit';

  @override
  String get tutorialJournalDesc =>
      'Tengoklah kembali hari Anda setiap malam: renungan singkat, dan rangkaian hari Anda.';
}
