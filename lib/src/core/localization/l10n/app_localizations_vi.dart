// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Chào mừng';

  @override
  String get examineTitle => 'Xét mình';

  @override
  String get confessTitle => 'Xưng tội';

  @override
  String get prayersTitle => 'Kinh nguyện';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get examinationTitle => 'Xét mình';

  @override
  String get commandment => 'Điều răn';

  @override
  String get guideTitle => 'Hướng dẫn';

  @override
  String get faqTitle => 'Tìm hiểu về việc xưng tội';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ bạn muốn dùng';

  @override
  String get theme => 'Giao diện';

  @override
  String get chooseTheme => 'Chọn giao diện bạn muốn dùng';

  @override
  String get system => 'Theo hệ thống';

  @override
  String get light => 'Sáng';

  @override
  String get dark => 'Tối';

  @override
  String get reminders => 'Nhắc nhở';

  @override
  String get getReminded => 'Được nhắc đi xưng tội';

  @override
  String get enableReminders => 'Bật nhắc nhở';

  @override
  String get weekly => 'Hằng tuần';

  @override
  String get biweekly => 'Hai tuần một lần';

  @override
  String get monthly => 'Hằng tháng';

  @override
  String get quarterly => 'Ba tháng một lần';

  @override
  String get day => 'Ngày';

  @override
  String get time => 'Giờ';

  @override
  String get remindMe => 'Nhắc tôi';

  @override
  String get onTheDay => 'Đúng ngày';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Trước $count ngày',
      one: 'Trước 1 ngày',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Thao tác nhanh';

  @override
  String get lastConfession => 'Lần xưng tội gần nhất';

  @override
  String get noneYet => 'Chưa có';

  @override
  String get today => 'Hôm nay';

  @override
  String get yesterday => 'Hôm qua';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày trước',
      one: '1 ngày trước',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Lần nhắc kế tiếp';

  @override
  String get off => 'Tắt';

  @override
  String get mon => 'T2';

  @override
  String get tue => 'T3';

  @override
  String get wed => 'T4';

  @override
  String get thu => 'T5';

  @override
  String get fri => 'T6';

  @override
  String get sat => 'T7';

  @override
  String get sun => 'CN';

  @override
  String get monday => 'Thứ Hai';

  @override
  String get tuesday => 'Thứ Ba';

  @override
  String get wednesday => 'Thứ Tư';

  @override
  String get thursday => 'Thứ Năm';

  @override
  String get friday => 'Thứ Sáu';

  @override
  String get saturday => 'Thứ Bảy';

  @override
  String get sunday => 'Chúa nhật';

  @override
  String get appLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get appLanguageSubtitle => 'Ngôn ngữ cho các nút, nhãn và trình đơn';

  @override
  String get contentLanguage => 'Ngôn ngữ nội dung';

  @override
  String get contentLanguageSubtitle =>
      'Ngôn ngữ cho các câu hỏi xét mình, câu hỏi thường gặp và kinh nguyện';

  @override
  String get version => 'Phiên bản';

  @override
  String get selectDay => 'Chọn ngày';

  @override
  String selected(num count) {
    return 'Đã chọn $count';
  }

  @override
  String get selectedLabel => 'đã chọn';

  @override
  String get counter => 'Bộ đếm';

  @override
  String get searchPlaceholder => 'Tìm điều răn hoặc câu hỏi...';

  @override
  String get noResults => 'Không tìm thấy kết quả nào';

  @override
  String get viewHistory => 'Xem lịch sử';

  @override
  String get noActiveConfession => 'Không có lần xưng tội nào đang mở';

  @override
  String get startExaminationPrompt =>
      'Bạn hãy bắt đầu xét mình để thêm tội vào đây.';

  @override
  String get startExamination => 'Bắt đầu xét mình';

  @override
  String get finishConfessionTitle => 'Kết thúc lần xưng tội?';

  @override
  String get finishConfessionContent =>
      'Thao tác này sẽ đánh dấu lần xưng tội là đã hoàn tất và chuyển vào lịch sử của bạn.';

  @override
  String get cancel => 'Hủy';

  @override
  String get finish => 'Kết thúc';

  @override
  String get confessionCompletedMessage =>
      'Đã xưng tội xong! Xin Chúa chúc lành cho bạn.';

  @override
  String get finishConfession => 'Kết thúc lần xưng tội';

  @override
  String get error => 'Lỗi';

  @override
  String get retry => 'Thử lại';

  @override
  String get dailyQuoteError => 'Không tải được lời trích hôm nay.';

  @override
  String get keepHistory => 'Lưu lịch sử xưng tội';

  @override
  String get keepHistorySubtitle =>
      'Lưu các tội của bạn cùng với ngày xưng. Nếu tắt, chỉ ngày xưng được lưu lại.';

  @override
  String get deleteConfession => 'Xóa lần xưng tội';

  @override
  String get deleteConfessionContent =>
      'Thao tác này sẽ xóa vĩnh viễn lần xưng tội này và mọi mục trong đó khỏi lịch sử của bạn. Không thể hoàn tác thao tác này.';

  @override
  String get tutorialExamineDesc =>
      'Bạn hãy bắt đầu ở đây để xét mình trước khi xưng tội.';

  @override
  String get tutorialConfessDesc =>
      'Dùng phần này trong lúc xưng tội để theo dõi các tội của bạn.';

  @override
  String get tutorialPrayersDesc =>
      'Tìm các kinh thường đọc trước và sau khi xưng tội.';

  @override
  String get tutorialGuideDesc =>
      'Ở đây bạn tìm được lời khích lệ, hướng dẫn xưng tội từng bước và các câu hỏi thường gặp.';

  @override
  String get tutorialSettingsDesc =>
      'Tùy chỉnh trải nghiệm của bạn ở đây: đổi ngôn ngữ, giao diện, đặt nhắc nhở và quản lý các thiết lập bảo mật.';

  @override
  String get tutorialSwipeDesc =>
      'Vuốt sang trái hoặc phải để chuyển giữa các điều răn.';

  @override
  String get tutorialSelectDesc =>
      'Chạm vào bất cứ câu hỏi nào để chọn cho lần xưng tội của bạn.';

  @override
  String get tutorialFinishDesc =>
      'Khi xong, bạn hãy chạm vào đây để kết thúc và chuyển sang phần xưng tội.';

  @override
  String get tutorialCounterDesc =>
      'Phần này cho biết bạn đã chọn bao nhiêu mục cho lần xưng tội.';

  @override
  String get tutorialMenuDesc =>
      'Từ đây bạn có thể thêm tội tự đặt và bỏ hết các mục đã chọn.';

  @override
  String get tutorialPenanceDesc =>
      'Theo dõi việc đền tội mà cha giải tội đã ra cho bạn ở đây.';

  @override
  String get tutorialInsightsDesc =>
      'Xem thống kê và chuỗi ngày trên hành trình xưng tội của bạn.';

  @override
  String get tutorialHistoryDesc =>
      'Xem lại những lần xưng tội trước đây và ngày tháng của chúng.';

  @override
  String get replayTutorial => 'Xem lại hướng dẫn';

  @override
  String get replayTutorialDesc => 'Xem lại phần hướng dẫn sử dụng ứng dụng';

  @override
  String get tutorialReset =>
      'Đã đặt lại hướng dẫn! Bạn sẽ thấy lại các phần chỉ dẫn.';

  @override
  String get about => 'Giới thiệu';

  @override
  String get aboutSubtitle => 'Phiên bản, giấy phép và mã nguồn';

  @override
  String get shareApp => 'Chia sẻ ứng dụng';

  @override
  String get shareAppSubtitle => 'Chia sẻ với bạn bè và gia đình';

  @override
  String get rateApp => 'Đánh giá ứng dụng';

  @override
  String get spreadShareTitle => 'Chia sẻ Metanoia';

  @override
  String get spreadShareSubtitle =>
      'Bạn có biết ai đó đã lâu không đi xưng tội? Hãy giúp họ tìm đường trở lại.';

  @override
  String get spreadShareAction => 'Chia sẻ';

  @override
  String get spreadRateSubtitle =>
      'Nếu Metanoia giúp bạn chuẩn bị xưng tội, một đánh giá sẽ giúp người khác tìm thấy ứng dụng.';

  @override
  String get spreadRateAction => 'Đánh giá';

  @override
  String get rateGateHint => 'Bạn đánh giá trải nghiệm của mình thế nào?';

  @override
  String get rateGateLowest => 'Thấp nhất';

  @override
  String get rateGateHighest => 'Cao nhất';

  @override
  String get rateGateThanks =>
      'Cảm ơn bạn — ý kiến của bạn rất ý nghĩa với chúng tôi.';

  @override
  String rateAppSubtitle(String store) {
    return 'Đánh giá cho chúng tôi trên $store';
  }

  @override
  String get website => 'Trang web';

  @override
  String get privacyPolicy => 'Chính sách quyền riêng tư';

  @override
  String get madeWithLove => 'Được thực hiện với ❤️ bởi holystack.dev';

  @override
  String get rateDialogTitle => 'Bạn thấy Metanoia hữu ích chứ?';

  @override
  String get rateDialogContent =>
      'Nếu ứng dụng này giúp ích cho bạn, xin dành chút thời gian để đánh giá. Điều đó giúp chúng tôi rất nhiều!';

  @override
  String get rateDialogYes => 'Đánh giá ngay';

  @override
  String get rateDialogNo => 'Không, cảm ơn';

  @override
  String get rateDialogLater => 'Nhắc tôi sau';

  @override
  String get greekLabel => 'Tiếng Hy Lạp';

  @override
  String get nounLabel => 'danh từ';

  @override
  String get metanoiaDefinition =>
      'Sự đổi mới sâu xa của tâm trí và cõi lòng; một cuộc thức tỉnh thiêng liêng biến đổi trọn con người và hướng đời sống về cùng Thiên Chúa.';

  @override
  String get turnBackToGrace => 'Trở về với ân sủng';

  @override
  String get welcomeSubtitle =>
      'Người bạn đồng hành cho một lần xưng tội sốt sắng';

  @override
  String get discoverInnerGrace => 'Khám phá ân sủng trong tâm hồn';

  @override
  String get sacredJourneyBegins =>
      'Một hành trình hòa giải thánh thiêng khởi đầu.';

  @override
  String get beginJourney => 'Bắt đầu hành trình';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get chooseContentLanguage => 'Chọn ngôn ngữ nội dung';

  @override
  String get contentLanguageDescription =>
      'Chọn ngôn ngữ cho kinh nguyện, phần xét mình và các hướng dẫn';

  @override
  String get changeAnytimeNote =>
      'Bạn có thể thay đổi bất cứ lúc nào trong phần Cài đặt';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String get examineDescription =>
      'Xét mình theo Mười Điều Răn trước khi xưng tội';

  @override
  String get confessDescription =>
      'Theo dõi các tội của bạn trong lúc xưng tội để không quên điều gì';

  @override
  String get prayersDescription =>
      'Tìm các kinh trước và sau khi xưng tội, cùng các kinh đền tội';

  @override
  String get remindersDescription =>
      'Đặt nhắc nhở định kỳ trong phần Cài đặt để bạn không bao giờ quên đi xưng tội';

  @override
  String get nextButton => 'Tiếp';

  @override
  String get customSins => 'Tội tự đặt';

  @override
  String get manageCustomSins => 'Quản lý tội tự đặt';

  @override
  String get addCustomSin => 'Thêm tội tự đặt';

  @override
  String get editCustomSin => 'Sửa tội tự đặt';

  @override
  String get deleteCustomSin => 'Xóa tội tự đặt';

  @override
  String get sinDescription => 'Mô tả tội';

  @override
  String get sinDescriptionHint => 'Mô tả tội bạn muốn ghi nhớ';

  @override
  String get sinDescriptionRequired => 'Bạn hãy nhập mô tả tội';

  @override
  String get optionalNote => 'Ghi chú (tùy chọn)';

  @override
  String get optionalNoteHint => 'Thêm chi tiết nếu cần';

  @override
  String get selectCommandment => 'Chọn điều răn (tùy chọn)';

  @override
  String get noCommandment => 'Chung / Không thuộc điều răn nào';

  @override
  String get customSinAdded => 'Đã thêm tội tự đặt';

  @override
  String get customSinUpdated => 'Đã cập nhật tội tự đặt';

  @override
  String get customSinDeleted => 'Đã xóa tội tự đặt';

  @override
  String get deleteCustomSinConfirm =>
      'Bạn có chắc muốn xóa tội tự đặt này không?';

  @override
  String get noCustomSins => 'Chưa có tội tự đặt nào';

  @override
  String get noCustomSinsDesc =>
      'Thêm tội tự đặt để phần xét mình sát với bạn hơn';

  @override
  String get customVersion => 'Tự đặt (đã sửa)';

  @override
  String get searchCustomSins => 'Tìm tội tự đặt...';

  @override
  String get addButton => 'Thêm';

  @override
  String get updateButton => 'Cập nhật';

  @override
  String get deleteButton => 'Xóa';

  @override
  String get addYourOwn => 'Tự thêm...';

  @override
  String get penance => 'Việc đền tội';

  @override
  String get penanceTracker => 'Theo dõi việc đền tội';

  @override
  String get addPenance => 'Thêm việc đền tội';

  @override
  String get editPenance => 'Sửa việc đền tội';

  @override
  String get penanceDescription => 'Bạn được ra việc đền tội nào?';

  @override
  String get penanceHint =>
      'vd: Đọc 3 Kinh Kính Mừng, đọc một đoạn Kinh Thánh...';

  @override
  String get penanceAdded => 'Đã thêm việc đền tội';

  @override
  String get penanceUpdated => 'Đã cập nhật việc đền tội';

  @override
  String get penanceCompleted =>
      'Đã làm xong việc đền tội! Xin Chúa chúc lành cho bạn.';

  @override
  String get markAsComplete => 'Đánh dấu đã hoàn tất';

  @override
  String get pendingPenances => 'Việc đền tội chưa làm';

  @override
  String get noPendingPenances => 'Không còn việc đền tội nào chưa làm';

  @override
  String get noPendingPenancesDesc =>
      'Bạn đã làm xong mọi việc đền tội. Xin Chúa chúc lành!';

  @override
  String completedOn(Object date) {
    return 'Hoàn tất ngày $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Được ra ngày $date';
  }

  @override
  String get skipPenance => 'Bỏ qua';

  @override
  String get savePenance => 'Lưu việc đền tội';

  @override
  String get insights => 'Thống kê';

  @override
  String get confessionInsights => 'Thống kê việc xưng tội';

  @override
  String get totalConfessions => 'Tổng số lần xưng tội';

  @override
  String get averageFrequency => 'Khoảng cách trung bình';

  @override
  String everyXDays(Object count) {
    return 'Mỗi $count ngày';
  }

  @override
  String get daysSinceLastConfession => 'Số ngày từ lần gần nhất';

  @override
  String get currentStreak => 'Chuỗi hiện tại';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuần',
      one: '1 tuần',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Hoạt động theo tháng';

  @override
  String get confessionsThisYear => 'Số lần xưng tội trong năm nay';

  @override
  String get noInsightsYet => 'Chưa có thống kê nào';

  @override
  String get noInsightsYetDesc =>
      'Hoàn tất lần xưng tội đầu tiên để xem thống kê hành trình thiêng liêng của bạn';

  @override
  String get totalItemsConfessed => 'Tổng số mục đã xưng';

  @override
  String get firstConfession => 'Lần xưng tội đầu tiên';

  @override
  String get spiritualJourney => 'Hành trình thiêng liêng của bạn';

  @override
  String get listView => 'Danh sách';

  @override
  String get guidedView => 'Có hướng dẫn';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current trên $total';
  }

  @override
  String get previousCommandment => 'Trước';

  @override
  String get nextCommandment => 'Tiếp';

  @override
  String get finishExamination => 'Kết thúc';

  @override
  String get noQuestionsSelected => 'Chưa chọn câu hỏi nào trong phần này';

  @override
  String questionsSelectedInSection(Object count) {
    return 'Đã chọn $count';
  }

  @override
  String get examinationSummary => 'Tóm tắt việc xét mình';

  @override
  String get examinationNote =>
      'Việc xét mình cẩn thận không dừng lại ở bất cứ danh sách nào. Bạn hãy cầu nguyện và suy xét về bậc sống cũng như hoàn cảnh riêng của mình.';

  @override
  String selectedCount(Object count) {
    return 'Đã chọn $count mục';
  }

  @override
  String get noSinsSelected => 'Chưa chọn tội nào';

  @override
  String get continueEditing => 'Tiếp tục chỉnh sửa';

  @override
  String get proceedToConfess => 'Tiếp tục';

  @override
  String get clearDraftTitle => 'Xóa bản nháp?';

  @override
  String get clearDraftMessage =>
      'Thao tác này sẽ bỏ hết các câu hỏi đã chọn. Bạn có chắc không?';

  @override
  String get clearDraft => 'Xóa bản nháp';

  @override
  String get clear => 'Xóa';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã khôi phục $count mục từ lần trước',
      one: 'Đã khôi phục 1 mục từ lần trước',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Vừa xong';

  @override
  String minutesAgo(Object count) {
    return '$count phút trước';
  }

  @override
  String hoursAgo(Object count) {
    return '$count giờ trước';
  }

  @override
  String get general => 'Chung';

  @override
  String get noQuestionsInSection => 'Không có câu hỏi nào trong phần này';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get back => 'Quay lại';

  @override
  String get skipOnboardingTitle => 'Bỏ qua phần giới thiệu?';

  @override
  String get skipOnboardingMessage =>
      'Bạn sẽ đến thẳng trang cuối. Ở đây không thiết lập gì cả — bạn có thể thay đổi mọi thứ sau trong phần Cài đặt.';

  @override
  String get confessionHistoryTitle => 'Lịch sử xưng tội';

  @override
  String get deleteAll => 'Xóa tất cả';

  @override
  String get editDate => 'Sửa ngày';

  @override
  String get confessionDate => 'Ngày xưng tội';

  @override
  String get dateUpdated => 'Đã cập nhật ngày';

  @override
  String get changeDateConfirmTitle => 'Đổi ngày?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Đổi ngày xưng tội thành $date?';
  }

  @override
  String get noGuideContent => 'Chưa có nội dung hướng dẫn';

  @override
  String get noGuideContentDesc => 'Nội dung hướng dẫn sẽ hiện ra ở đây';

  @override
  String get noFaqContent => 'Chưa có câu hỏi thường gặp';

  @override
  String get noFaqContentDesc => 'Các câu hỏi thường gặp sẽ hiện ra ở đây';

  @override
  String get faqSubtitle => 'Hướng dẫn về bí tích Hòa Giải';

  @override
  String get tapToExpand => 'Chạm để đọc thêm';

  @override
  String get continueExamination => 'Tiếp tục xét mình';

  @override
  String get continueExaminationDesc => 'Bạn đang xét mình dở dang';

  @override
  String examinationProgress(Object count) {
    return 'Đã chọn $count mục';
  }

  @override
  String get security => 'Bảo mật';

  @override
  String get securitySubtitle => 'Bảo vệ dữ liệu cá nhân của bạn';

  @override
  String get pinAndBiometric => 'Mã PIN và sinh trắc học';

  @override
  String get pinAndBiometricSubtitle => 'Thiết lập khóa ứng dụng';

  @override
  String get enterPin => 'Nhập mã PIN';

  @override
  String get createPin => 'Tạo mã PIN';

  @override
  String get confirmPin => 'Xác nhận mã PIN';

  @override
  String get incorrectPin => 'Mã PIN không đúng';

  @override
  String get pinMismatch => 'Hai mã PIN không khớp nhau';

  @override
  String get biometricUnlock => 'Mở khóa bằng sinh trắc học';

  @override
  String get autoLockTimeout => 'Thời gian tự động khóa';

  @override
  String get tooManyAttempts => 'Bạn đã nhập sai quá nhiều lần';

  @override
  String tryAgainIn(Object time) {
    return 'Thử lại sau $time';
  }

  @override
  String get useBiometricUnlock => 'Dùng sinh trắc học để mở khóa';

  @override
  String get unlockWithFingerprintOrFace =>
      'Mở khóa bằng vân tay hoặc khuôn mặt';

  @override
  String get biometricAccessWarning =>
      'Bất cứ ai đã đăng ký vân tay hoặc khuôn mặt trên thiết bị này đều có thể mở được ứng dụng';

  @override
  String get lockAfter => 'Khóa sau';

  @override
  String get timeInBackgroundBeforeLocking =>
      'Thời gian chạy nền trước khi khóa';

  @override
  String get changePin => 'Đổi mã PIN';

  @override
  String get updateYourSecurityPin => 'Cập nhật mã PIN bảo mật của bạn';

  @override
  String get enterCurrentPin => 'Nhập mã PIN hiện tại';

  @override
  String get enterNewPin => 'Nhập mã PIN mới';

  @override
  String get confirmNewPin => 'Xác nhận mã PIN mới';

  @override
  String get pinChangedSuccessfully => 'Đã đổi mã PIN thành công';

  @override
  String get currentPinIncorrect => 'Mã PIN hiện tại không đúng';

  @override
  String get enableBiometricUnlock => 'Bật mở khóa bằng sinh trắc học?';

  @override
  String get biometricDescription =>
      'Dùng vân tay hoặc khuôn mặt của bạn để mở khóa ứng dụng nhanh chóng và an toàn.';

  @override
  String get notNow => 'Để sau';

  @override
  String get enable => 'Bật';

  @override
  String get setUpPin => 'Thiết lập mã PIN';

  @override
  String get createSixDigitPin => 'Tạo mã PIN gồm 6 chữ số';

  @override
  String get pinProtectData => 'Mã PIN này dùng để bảo vệ dữ liệu của bạn';

  @override
  String get confirmYourPin => 'Xác nhận mã PIN của bạn';

  @override
  String get enterSamePinAgain => 'Nhập lại đúng mã PIN đó để xác nhận';

  @override
  String get metanoia => 'Metanoia';

  @override
  String get enterPinToUnlock => 'Nhập mã PIN để mở khóa';

  @override
  String attemptsRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Còn $count lần thử',
      one: 'Còn 1 lần thử',
    );
    return '$_temp0';
  }

  @override
  String seconds(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giây',
      one: '1 giây',
    );
    return '$_temp0';
  }

  @override
  String minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count phút',
      one: '1 phút',
    );
    return '$_temp0';
  }

  @override
  String get undo => 'Hoàn tác';

  @override
  String get confessionDeleted => 'Đã xóa lần xưng tội';

  @override
  String get noConfessionHistory => 'Chưa có lịch sử xưng tội';

  @override
  String get noConfessionHistoryDesc =>
      'Những lần xưng tội đã hoàn tất sẽ hiện ra ở đây';

  @override
  String get fontSize => 'Cỡ chữ';

  @override
  String get fontSizeSubtitle => 'Điều chỉnh cỡ chữ cho dễ đọc hơn';

  @override
  String get fontSizeSmall => 'Nhỏ';

  @override
  String get fontSizeMedium => 'Vừa';

  @override
  String get fontSizeLarge => 'Lớn';

  @override
  String get fontSizeExtraLarge => 'Rất lớn';

  @override
  String get forgotPin => 'Quên mã PIN?';

  @override
  String get resetPinTitle => 'Đặt lại mã PIN';

  @override
  String get resetPinWarning =>
      'Cảnh báo: Thao tác này sẽ xóa vĩnh viễn toàn bộ dữ liệu của bạn';

  @override
  String get resetPinDescription =>
      'Nếu bạn đặt lại mã PIN, mọi lần xưng tội, các tội tự đặt, việc đền tội và các dữ liệu cá nhân khác của bạn sẽ bị xóa vĩnh viễn. Không thể hoàn tác thao tác này.';

  @override
  String get resetPinConfirmation => 'Nhập XÓA để xác nhận';

  @override
  String get resetPinButton => 'Đặt lại mã PIN và xóa dữ liệu';

  @override
  String get resetPinSuccess =>
      'Đã đặt lại mã PIN. Bạn hãy thiết lập mã PIN mới.';

  @override
  String get resetPinError => 'Không đặt lại được mã PIN. Bạn hãy thử lại.';

  @override
  String get deleteConfirmationText => 'XÓA';

  @override
  String resetPinWaitTimer(int seconds) {
    return 'Bạn hãy đợi $seconds giây';
  }

  @override
  String get resetPinBiometricPrompt =>
      'Xác minh danh tính của bạn để đặt lại mã PIN';

  @override
  String get confessionGuideTitle => 'Xưng tội thế nào cho nên';

  @override
  String get shortFilmTitle => 'Xưng tội: Một bộ phim ngắn';

  @override
  String get shortFilmSubtitle =>
      'Do Blazing Youth Wembley, St Joseph\'s RC Church, Wembley, Vương quốc Anh thực hiện';

  @override
  String get confessionGuideSubtitle =>
      'Hướng dẫn từng bước về bí tích Hòa Giải';

  @override
  String get invitationTitle => 'Trở lại với việc xưng tội?';

  @override
  String get invitationSubtitle => 'Đôi lời khích lệ dành cho bạn';

  @override
  String get invitationDialogTitle => 'Chào mừng bạn';

  @override
  String get invitationDialogContent =>
      'Đây có phải là lần xưng tội đầu tiên sau một thời gian dài của bạn, hay bạn đang lo lắng khi đi xưng tội?';

  @override
  String get invitationDialogYes => 'Vâng, tôi muốn được khích lệ đôi lời';

  @override
  String get invitationDialogNo => 'Không, tôi đã sẵn sàng bắt đầu';

  @override
  String get invitationDialogDontShowAgain => 'Đừng hiện lại nữa';

  @override
  String get searchPrayers => 'Tìm kinh nguyện...';

  @override
  String get allCategories => 'Tất cả';

  @override
  String get appDisclaimer =>
      'Ứng dụng này là một trợ giúp thiêng liêng để chuẩn bị xưng tội. Ứng dụng không thay thế bí tích Hòa Giải với linh mục.';

  @override
  String get onboardingDisclaimer =>
      'Người bạn đồng hành thiêng liêng giúp bạn xưng tội — chứ không thay thế việc xưng tội.';

  @override
  String get readyToBegin => 'Bạn đã sẵn sàng';

  @override
  String get readyToBeginSubtitle =>
      'Nguyện xin hành trình hòa giải của bạn tràn đầy ân sủng và bình an.';

  @override
  String get onboardingOverviewTitle => 'Ứng dụng này giúp gì cho bạn';

  @override
  String get onboardingOverviewExamine =>
      'Chuẩn bị lương tâm, theo nhịp của riêng bạn.';

  @override
  String get onboardingOverviewConfess =>
      'Một bản danh sách kín đáo, để không quên điều gì.';

  @override
  String get onboardingOverviewJournal =>
      'Một phút hồi tâm buổi tối, để tiếp tục lớn lên giữa các lần xưng tội.';

  @override
  String get onboardingOverviewFootnote =>
      'Kinh nguyện, hướng dẫn và nhắc nhở tùy chọn đều có sẵn bên trong.';

  @override
  String get onboardingPrivacyTitle => 'Riêng tư ngay từ thiết kế';

  @override
  String get onboardingPrivacyLocal =>
      'Mọi thứ đều nằm lại trên điện thoại này. Không tài khoản, không đám mây.';

  @override
  String get onboardingPrivacyEncrypted =>
      'Được mã hóa ngay trên thiết bị của bạn.';

  @override
  String get onboardingPrivacyPin =>
      'Bạn sẽ tạo một mã PIN trong lần đầu mở phần xét mình hoặc nhật ký.';

  @override
  String get sourceCode => 'Mã nguồn';

  @override
  String get contentReferences => 'Nguồn tham khảo nội dung';

  @override
  String get examinationModeTitle => 'Bạn muốn xét mình cách nào?';

  @override
  String get quickReviewMode => 'Xem nhanh';

  @override
  String get quickReviewDescription => 'Lướt qua tất cả câu hỏi theo từng nhóm';

  @override
  String get deepReflectionMode => 'Suy xét sâu';

  @override
  String get deepReflectionDescription =>
      'Mỗi lần một câu hỏi, để xét mình kỹ lưỡng';

  @override
  String get contemplativePrayerTitle => 'Lạy Chúa Thánh Thần, xin ngự đến';

  @override
  String get contemplativePrayerText =>
      'Xin đổ đầy lòng con và thắp lên trong con ngọn lửa tình yêu Chúa. Xin soi sáng trí con, để con thấy rõ tội lỗi mình.';

  @override
  String get imReady => 'Con đã sẵn sàng';

  @override
  String get skipPrayer => 'Bỏ qua';

  @override
  String get yesThisApplies => 'Có';

  @override
  String get noThisDoesnt => 'Không';

  @override
  String get skipQuestion => 'Bỏ qua';

  @override
  String questionProgress(int current, int total) {
    return '$current trên $total';
  }

  @override
  String get examinationComplete => 'Đã xét mình xong';

  @override
  String get reviewYourSelections => 'Xem lại các mục bạn đã chọn';

  @override
  String get examinationModeSettingTitle => 'Cách xét mình';

  @override
  String get examinationModeSettingSubtitle => 'Chọn cách bạn muốn xét mình';

  @override
  String get askEveryTime => 'Hỏi mỗi lần';

  @override
  String get reminderNotificationTitle => 'Đã đến lúc xưng tội';

  @override
  String get reminderNotificationBody =>
      'Bạn hãy nhớ xét mình và chuẩn bị xưng tội';

  @override
  String get notificationPermissionDenied =>
      'Thông báo đang bị tắt. Bạn hãy cho phép Metanoia gửi thông báo trong phần cài đặt thiết bị để nhận nhắc nhở xưng tội.';

  @override
  String get openSourceLicenses => 'Giấy phép nguồn mở';

  @override
  String get couldNotOpenLink => 'Không mở được liên kết';

  @override
  String itemsConfessed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã xưng $count mục',
      one: 'Đã xưng 1 mục',
    );
    return '$_temp0';
  }

  @override
  String penancesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count việc đền tội',
      one: '1 việc đền tội',
    );
    return '$_temp0';
  }

  @override
  String pendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count chưa xong',
      one: '1 chưa xong',
    );
    return '$_temp0';
  }

  @override
  String totalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tổng cộng $count',
      one: 'Tổng cộng 1',
    );
    return '$_temp0';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mục',
      one: '1 mục',
    );
    return '$_temp0';
  }

  @override
  String daysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày',
      one: '1 ngày',
    );
    return '$_temp0';
  }

  @override
  String weeksShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuần',
      one: '1 tuần',
    );
    return '$_temp0';
  }

  @override
  String get deleteAllConfessionsTitle => 'Xóa tất cả lần xưng tội?';

  @override
  String get deleteAllConfessionsContent =>
      'Thao tác này sẽ xóa vĩnh viễn toàn bộ lịch sử xưng tội của bạn. Không thể hoàn tác thao tác này.';

  @override
  String get allConfessionsDeleted => 'Đã xóa tất cả lần xưng tội';

  @override
  String get deletePenanceConfirm =>
      'Bạn có chắc muốn xóa việc đền tội này không?';

  @override
  String get completed => 'Đã hoàn tất';

  @override
  String get tapToCollapse => 'Chạm để thu lại';

  @override
  String get dismiss => 'Bỏ qua';

  @override
  String showcaseStep(int current, int total) {
    return 'Bước $current trên $total';
  }

  @override
  String get done => 'Xong';

  @override
  String get navigate => 'Mở';

  @override
  String get encouragement => 'Lời khích lệ';

  @override
  String get biometricPromptReason => 'Xác thực để mở Metanoia';

  @override
  String get tryAgainInLabel => 'Thử lại sau';

  @override
  String get errorLoadingLanguage => 'Lỗi khi tải ngôn ngữ';

  @override
  String get detailsNotSaved => 'Chi tiết không được lưu';

  @override
  String get discardStoredSinsTitle => 'Bỏ các tội đã lưu?';

  @override
  String get discardStoredSinsContent =>
      'Lịch sử xưng tội hiện đang tắt. Những tội đã lưu từ các lần xưng tội trước vẫn còn được giữ lại. Bạn có muốn bỏ chúng đi không? Các ngày xưng tội vẫn được giữ, nên phần thống kê và chuỗi ngày của bạn không bị ảnh hưởng.';

  @override
  String get keepThem => 'Giữ lại';

  @override
  String get discard => 'Bỏ đi';

  @override
  String get storedSinsDiscarded =>
      'Đã bỏ các tội đã lưu. Các ngày xưng tội vẫn được giữ lại.';

  @override
  String get journalTitle => 'Nhật ký';

  @override
  String get journalHomeCardTitle => 'Hồi tâm buổi tối';

  @override
  String get journalHomeCardSubtitle => 'Hôm nay của bạn thế nào?';

  @override
  String journalStreakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày',
      one: '$count ngày',
    );
    return '$_temp0';
  }

  @override
  String get journalStreakLabel => 'Số ngày hồi tâm liên tiếp';

  @override
  String get journalContinueToday => 'Tiếp tục ghi nhật ký hôm nay';

  @override
  String get journalPreviousMonth => 'Tháng trước';

  @override
  String get journalNextMonth => 'Tháng sau';

  @override
  String get journalGratitudeTitle => 'Tạ ơn';

  @override
  String get journalGratitudePrompt => 'Hôm nay tôi đã thấy Chúa ở đâu?';

  @override
  String get journalGratitudeHint => 'Một ơn lành con muốn tạ ơn Chúa…';

  @override
  String get journalPresenceLead =>
      'Thiên Chúa đang ở đây với bạn. Hãy thinh lặng trước mặt Người và tạ ơn.';

  @override
  String get journalPresenceVerse =>
      'Dừng tay lại: Hãy biết Ta đây là Thiên Chúa!';

  @override
  String get journalPresenceRef => 'Tv 46,11';

  @override
  String get journalLightTitle => 'Xin ơn soi sáng';

  @override
  String get journalLightLead =>
      'Hãy xin Chúa Thánh Thần ban ơn soi sáng, để bạn nhìn ngày sống của mình như Thiên Chúa nhìn.';

  @override
  String get journalLightVerse =>
      'Lạy Chúa Thánh Thần, xin xuống tràn ngập tâm hồn các tín hữu Chúa, và xin nhóm lửa tình yêu Chúa trong lòng họ.';

  @override
  String get journalReviewTitle => 'Nhìn lại cùng Chúa';

  @override
  String get journalReviewLead =>
      'Hãy cùng Chúa đi lại suốt ngày sống của bạn: nơi tình yêu đến với bạn, nơi bạn trao ban, và nơi bạn quay lưng.';

  @override
  String get journalReviewVerse =>
      'Lạy Chúa, xin dò xét để biết rõ lòng con, xin thử con cho biết những điều con cảm nghĩ. Xin Ngài xem con có lạc vào đường gian ác thì dẫn con theo chính lộ ngàn đời.';

  @override
  String get journalReviewRef => 'Tv 139,23-24';

  @override
  String get journalReviewHint => 'Hãy thưa với Người về ngày sống của bạn…';

  @override
  String get journalReviewBringSin =>
      'Có điều gì bạn muốn dâng lên Người không?';

  @override
  String get journalContritionTitle => 'Ăn năn tội';

  @override
  String get journalContritionLead =>
      'Hãy đem đến cho Cha điều bạn đã tìm thấy; Người chạy đến đón bạn.';

  @override
  String get journalContritionVerse =>
      'Lạy Thiên Chúa, xin lấy lòng nhân hậu xót thương con, mở lượng hải hà xoá tội con đã phạm.';

  @override
  String get journalContritionRef => 'Tv 51,3';

  @override
  String get journalContritionPray => 'Đọc kinh Ăn Năn Tội';

  @override
  String get journalContritionMercy =>
      'Lòng ăn năn phát sinh từ tình yêu đối với Thiên Chúa, cùng với quyết tâm đi xưng tội, mở lòng con đón nhận lòng thương xót của Người tối nay; và sự viên mãn của ơn ấy đang chờ con nơi bí tích Hòa Giải, trong lời xá giải.';

  @override
  String get journalResolutionLead =>
      'Hãy nghỉ yên trong lòng thương xót của Người. Ngày mai lại bắt đầu trong Người.';

  @override
  String get journalResolutionVerse =>
      'Lượng từ bi ĐỨC CHÚA đâu đã cạn, lòng thương xót của Người mãi không vơi. Sáng nào Người cũng ban ân huệ mới. Lòng trung tín của Người cao cả biết bao!';

  @override
  String get journalResolutionRef => 'Ac 3,22-23';

  @override
  String get journalReflectionTitle => 'Hồi tâm';

  @override
  String get journalReflectionPrompt => 'Hôm nay của bạn thế nào?';

  @override
  String get journalReflectionHint => 'Bạn hãy viết tự do...';

  @override
  String get journalSinsTitle => 'Đánh dấu tội';

  @override
  String get journalSinsPrompt => 'Hôm nay tôi đã lỗi phạm ở điều gì?';

  @override
  String get journalNoSinsMarked => 'Chưa đánh dấu điều gì';

  @override
  String get journalAddSin => 'Đánh dấu một tội';

  @override
  String get journalRemoveSin => 'Gỡ bỏ';

  @override
  String get journalResolutionTitle => 'Hy vọng và quyết tâm';

  @override
  String get journalResolutionPrompt => 'Một ý hướng cho ngày mai';

  @override
  String get journalResolutionHint => 'Nhờ ơn Chúa, ngày mai con sẽ…';

  @override
  String get journalMoodTitle => 'Tâm trạng';

  @override
  String get journalMoodPrompt => 'Tối nay linh hồn bạn thế nào?';

  @override
  String get journalMoodDesolate => 'Sầu khổ';

  @override
  String get journalMoodStruggling => 'Chật vật';

  @override
  String get journalMoodSteady => 'Vững vàng';

  @override
  String get journalMoodGrateful => 'Biết ơn';

  @override
  String get journalMoodConsoled => 'Được an ủi';

  @override
  String get journalSaved => 'Đã lưu';

  @override
  String get journalSaving => 'Đang lưu...';

  @override
  String get journalDeleteEntry => 'Xóa mục nhật ký';

  @override
  String get journalDeleteEntryConfirm =>
      'Xóa mục nhật ký của ngày này? Không thể hoàn tác.';

  @override
  String get journalEntryDeleted => 'Đã xóa mục nhật ký';

  @override
  String get journalPickerQuestions => 'Câu hỏi';

  @override
  String get journalPickerMySins => 'Tội của tôi';

  @override
  String get journalPickerOwnWords => 'Theo lời của tôi';

  @override
  String get journalPickerFreeTextHint => 'Hãy mô tả theo lời của bạn';

  @override
  String get journalSearchSins => 'Tìm tội...';

  @override
  String get journalAbsolved => 'Đã xưng';

  @override
  String get journalSinCleared => 'Một tội bạn đã đem đi xưng';

  @override
  String journalPreloadTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đưa vào $count tội bạn đã đánh dấu trong nhật ký',
      one: 'Đưa vào tội bạn đã đánh dấu trong nhật ký',
    );
    return '$_temp0';
  }

  @override
  String get journalPreloadAction => 'Đưa vào';

  @override
  String journalPreloadAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã thêm $count tội từ nhật ký của bạn',
      one: 'Đã thêm 1 tội từ nhật ký của bạn',
    );
    return '$_temp0';
  }

  @override
  String get journalStruggleAreas => 'Những điểm hay vấp ngã';

  @override
  String get journalStruggleAreasSubtitle =>
      'Được đánh dấu nhiều nhất trong nhật ký của bạn';

  @override
  String journalMarksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lần đánh dấu',
      one: '1 lần đánh dấu',
    );
    return '$_temp0';
  }

  @override
  String get journalReminder => 'Nhắc viết nhật ký';

  @override
  String get journalReminderSubtitle =>
      'Lời nhắc mỗi tối để nhìn lại ngày sống';

  @override
  String get enableJournalReminder => 'Bật nhắc viết nhật ký';

  @override
  String get journalReminderNotificationTitle => 'Hồi tâm buổi tối';

  @override
  String get journalReminderNotificationBody =>
      'Hãy dành một chút thời gian nhìn lại ngày sống của bạn cùng Chúa';

  @override
  String get confessionDayMode => 'Chế độ Xưng tội';

  @override
  String get confessionDayModeDescription =>
      'Chữ lớn, không gây phân tâm, dành cho tòa giải tội';

  @override
  String get exitConfessionMode => 'Thoát chế độ xưng tội';

  @override
  String confessionDayStepOf(int current, int total) {
    return 'Bước $current / $total';
  }

  @override
  String get next => 'Tiếp theo';

  @override
  String get actOfContrition => 'Kinh Ăn Năn Tội';

  @override
  String get actOfContritionUnavailable => 'Hiện không có Kinh Ăn Năn Tội';

  @override
  String get confessionDaySinsTitle => 'Các tội cần xưng';

  @override
  String get confessionDayOpeningTitle => 'Mở đầu';

  @override
  String get confessionDayOpeningIntro => 'Làm dấu Thánh Giá, rồi bắt đầu:';

  @override
  String get confessionDayOpeningFormula =>
      'Thưa cha, xin cha giải tội cho con vì con là kẻ có tội.';

  @override
  String confessionDaySinceLast(String duration) {
    return 'Con đã xưng tội cách đây $duration.';
  }

  @override
  String get confessionDaySinceLastUnknown =>
      'Con đã xưng tội cách đây [mấy ngày/mấy tuần/mấy tháng/mấy năm].';

  @override
  String get confessionDaySinsClosing =>
      'Con thật lòng ăn năn về những tội ấy và mọi tội con đã phạm.';

  @override
  String get confessionDayThanksgivingTitle => 'Hãy về bình an';

  @override
  String get confessionDayThanksgivingVersicle =>
      'Hãy tạ ơn Chúa, vì Chúa nhân từ.';

  @override
  String get confessionDayThanksgivingResponse =>
      'Muôn ngàn đời Chúa vẫn trọn tình thương.';

  @override
  String get confessionDayThanksgivingBody =>
      'Linh hồn bạn đã được rửa sạch. Hãy làm việc đền tội và tiến bước trong bình an của Đức Kitô.';

  @override
  String weeksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuần',
      one: '1 tuần',
    );
    return '$_temp0';
  }

  @override
  String monthsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tháng',
      one: '1 tháng',
    );
    return '$_temp0';
  }

  @override
  String yearsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count năm',
      one: '1 năm',
    );
    return '$_temp0';
  }

  @override
  String get seasonLent => 'Mùa Chay';

  @override
  String get seasonHolyWeek => 'Tuần Thánh';

  @override
  String get seasonAdvent => 'Mùa Vọng';

  @override
  String get seasonChristmas => 'Mùa Giáng Sinh';

  @override
  String get seasonEaster => 'Mùa Phục Sinh';

  @override
  String get seasonOrdinaryTime => 'Mùa Thường Niên';

  @override
  String get feastAshWednesday => 'Thứ Tư Lễ Tro';

  @override
  String get feastPalmSunday => 'Chúa Nhật Lễ Lá';

  @override
  String get feastEaster => 'Lễ Phục Sinh';

  @override
  String get feastPentecost => 'Lễ Chúa Thánh Thần Hiện Xuống';

  @override
  String get feastAssumption => 'Lễ Đức Mẹ Hồn Xác Lên Trời';

  @override
  String get feastAllSaints => 'Lễ Các Thánh';

  @override
  String get feastImmaculateConception => 'Lễ Đức Mẹ Vô Nhiễm Nguyên Tội';

  @override
  String get feastFirstSundayOfAdvent => 'Chúa Nhật thứ nhất Mùa Vọng';

  @override
  String get feastChristmas => 'Lễ Giáng Sinh';

  @override
  String get liturgicalLentTitle => 'Mùa Chay đã bắt đầu';

  @override
  String get liturgicalLentBody =>
      'Mùa trở về cùng Chúa. Nhiều người khởi đầu bằng việc xưng tội.';

  @override
  String get liturgicalHolyWeekTitle => 'Tuần Thánh đã bắt đầu';

  @override
  String get liturgicalHolyWeekBody =>
      'Hội Thánh đang tiến về lễ Phục Sinh. Vẫn còn thời gian để chuẩn bị tâm hồn bạn.';

  @override
  String get liturgicalAdventTitle => 'Mùa Vọng đã bắt đầu';

  @override
  String get liturgicalAdventBody =>
      'Mùa mong đợi. Nhiều người chuẩn bị tâm hồn bằng việc xưng tội.';

  @override
  String liturgicalFeastNearTitle(String feast) {
    return '$feast đã gần kề';
  }

  @override
  String liturgicalFeastNearBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Còn $count ngày nữa — hãy chuẩn bị tâm hồn.',
      one: 'Còn một ngày nữa — hãy chuẩn bị tâm hồn.',
    );
    return '$_temp0';
  }

  @override
  String anniversaryTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã $count tuần kể từ lần xưng tội gần nhất của bạn',
      one: 'Đã một tuần kể từ lần xưng tội gần nhất của bạn',
    );
    return '$_temp0';
  }

  @override
  String get anniversaryBody =>
      'Bất cứ khi nào bạn sẵn sàng, lòng thương xót vẫn đang chờ. Bạn có muốn chuẩn bị không?';

  @override
  String get promptPrepare => 'Chuẩn bị';

  @override
  String get dataUnrecoverableTitle => 'Không thể mở khóa dữ liệu của bạn';

  @override
  String get dataUnrecoverableBody =>
      'Khóa bảo vệ những lời xưng tội của bạn không còn trên thiết bị này. Điều đó có thể xảy ra sau khi khôi phục từ một bản sao lưu, hoặc khi cài đặt bảo mật của thiết bị đã bị đặt lại.\n\nVì dữ liệu của bạn được mã hóa, nên không thể khôi phục nếu không có khóa ấy — ngay cả chúng tôi cũng không thể. Bạn có thể xóa hết và bắt đầu lại.';

  @override
  String get eraseAndStartOver => 'Xóa hết và bắt đầu lại';

  @override
  String get eraseAndStartOverConfirm =>
      'Thao tác này xóa vĩnh viễn mọi thứ được lưu trên thiết bị này và khởi động lại ứng dụng từ đầu. Không thể hoàn tác.';

  @override
  String get penanceSaveFailed =>
      'Không thể lưu việc đền tội. Vui lòng thử lại.';

  @override
  String get confessionReminderChannelName => 'Nhắc xưng tội';

  @override
  String get confessionReminderChannelDescription => 'Lời nhắc đi xưng tội';

  @override
  String get journalReminderChannelName => 'Nhắc viết nhật ký';

  @override
  String get journalReminderChannelDescription =>
      'Lời nhắc mỗi ngày để viết bài hồi tâm buổi tối';

  @override
  String namedSoFar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã nêu $count tội',
      one: 'Đã nêu một tội',
    );
    return '$_temp0';
  }

  @override
  String get invitationCardTitle => 'Trước khi bạn bắt đầu';

  @override
  String get invitationCardAction => 'Khích lệ tôi';

  @override
  String get homeCtaBeginTitle => 'Bắt đầu xét mình';

  @override
  String get homeCtaBeginSubtitle => 'Chuẩn bị tâm hồn trước khi xưng tội';

  @override
  String homeCtaContinueTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tiếp tục xét mình (đã chọn $count)',
      one: 'Tiếp tục xét mình (đã chọn 1)',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaContinueSubtitle => 'Tiếp tục từ chỗ còn dang dở';

  @override
  String get homeCtaReadyTitle => 'Bạn đã sẵn sàng';

  @override
  String homeCtaReadySubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tội đang chờ trong danh sách xưng tội của bạn',
      one: '1 tội đang chờ trong danh sách xưng tội của bạn',
    );
    return '$_temp0';
  }

  @override
  String get homeCtaPenanceTitle => 'Hoàn tất việc đền tội';

  @override
  String homeCtaPenanceSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Còn $count việc đền tội đang chờ',
      one: 'Còn 1 việc đền tội đang chờ',
    );
    return '$_temp0';
  }

  @override
  String get homeGuideCardSubtitle =>
      'Lời khích lệ, hướng dẫn từng bước, kinh nguyện và câu hỏi thường gặp';

  @override
  String get homeQuoteReadMore => 'Xem thêm';

  @override
  String get homeQuoteShowLess => 'Thu gọn';

  @override
  String get tutorialJournalDesc =>
      'Mỗi tối nhìn lại ngày sống: một bài hồi tâm ngắn và chuỗi ngày liên tục của bạn.';
}
