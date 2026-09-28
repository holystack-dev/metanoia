/// Central configuration file for app constants
///
/// This file contains all configurable values that may need to be updated
/// when publishing or configuring the app.
library;

import 'dart:ui';

/// Bundled content (assets/data) configuration
abstract class ContentConfig {
  /// Bump this whenever the JSON under assets/data changes.
  ///
  /// The database re-syncs content whenever this differs from the version last
  /// synced; it is independent of [AppDatabase.schemaVersion].
  static const int version = 3;
}

/// App Store and Play Store configuration
abstract class StoreConfig {
  /// Apple App Store ID (App Store Connect → App Information → Apple ID).
  /// https://apps.apple.com/us/app/metanoia-catholic-confession/id6759740034
  /// Required by `openStoreListing` on iOS.
  static const String appStoreId = '6759740034';

  /// Google Play Store package name (automatically detected from AndroidManifest.xml)
  /// Only needed if different from the app's package name
  static const String? playStorePackageName = null;
}

/// App Update configuration
abstract class UpdateConfig {
  /// Minimum app version required - versions below this will be forced to update
  static const String minAppVersion = '1.0.0';

  /// Days to wait before showing the update prompt again
  static const int daysUntilAlertAgain = 3;
}

/// In-App Review configuration
abstract class ReviewConfig {
  /// Number of confessions before showing review prompt
  static const int confessionThreshold = 2;

  /// Number of penance completions before showing review prompt
  static const int penanceThreshold = 3;

  /// Minimum days between review prompts
  static const int minDaysBetweenPrompts = 30;
}

/// Home-screen "spread the word" invitation configuration.
///
/// The share/rate card appears only after the app has been used meaningfully,
/// and snoozes for [snoozeDays] whenever it is acted on or dismissed.
abstract class SpreadConfig {
  /// Cold app opens before the share invitation may appear at all (a user who
  /// has completed a confession is considered to have earned it regardless).
  static const int minOpensToInvite = 3;

  /// Completed confessions before the invitation may switch from "share" to the
  /// occasional "rate" ask. Matches [ReviewConfig.confessionThreshold] so the
  /// two rating paths stay in step.
  static const int confessionsToAskRating = 2;

  /// How long the card stays hidden after it is shared, rated or dismissed.
  static const int snoozeDays = 21;
}

/// Supported Languages configuration
abstract class LanguageConfig {
  /// All supported content languages, each named in its own script.
  /// Add new languages here when adding translations.
  ///
  /// Keys are content keys: the suffix of the bundled JSON under `assets/data`
  /// (`questions_pt_BR.json`, `questions_tl.json`) and the `languageCode`
  /// column in the database. They are not always the Flutter locale; see
  /// [contentKeyFromLocale].
  static const Map<String, String> supportedContentLanguages = {
    'en': 'English',
    'es': 'Español',
    'pt_BR': 'Português (Brasil)',
    'fr': 'Français',
    'de': 'Deutsch',
    'it': 'Italiano',
    'pl': 'Polski',
    'tl': 'Filipino',
    'vi': 'Tiếng Việt',
    'id': 'Bahasa Indonesia',
    'ko': '한국어',
    'ml': 'മലയാളം',
    'ta': 'தமிழ்',
    'hi': 'हिन्दी',
  };

  /// Get list of language codes only (for database sync)
  static List<String> get languageCodes =>
      supportedContentLanguages.keys.toList();

  /// Default content language
  static const String defaultContentLanguage = 'en';

  /// The Flutter locale for a content key, and back.
  ///
  /// The two differ in two cases:
  /// - Portuguese content is `pt_BR`; the locale is `Locale('pt', 'BR')`.
  /// - Filipino content is `tl`, but `flutter_localizations` ships Material
  ///   strings for `fil`, so the locale must be `fil`.
  static String contentKeyFromLocale(Locale locale) {
    return switch (locale.languageCode) {
      'pt' => 'pt_BR',
      'fil' => 'tl',
      final code => code,
    };
  }

  /// Converts a content key string back to a [Locale].
  static Locale localeFromContentKey(String key) {
    return switch (key) {
      'pt_BR' => const Locale('pt', 'BR'),
      'tl' => const Locale('fil'),
      final code => Locale(code),
    };
  }
}

/// App URLs and links
abstract class AppUrls {
  /// App website URL
  static const String website = 'https://holystack.dev/metanoia/';

  /// Privacy policy URL
  static const String privacyPolicy = 'https://holystack.dev/metanoia/privacy/';

  /// GitHub repository URL
  static const String githubRepo = 'https://github.com/holystack-dev/metanoia';

  /// App share message
  static const String shareMessage =
      'I\'ve been using Metanoia to prepare for confession - it\'s really helpful! Download it free at https://holystack.dev/metanoia/';

  /// A short film on confession, created by Blazing Youth Wembley
  /// (St Joseph's RC Church). Opens externally on YouTube; the app itself
  /// makes no network call.
  static const String shortFilm =
      'https://www.youtube.com/watch?v=H9vZbP5FSEU';
}
