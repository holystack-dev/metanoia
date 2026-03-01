/// Central configuration file for app constants
///
/// This file contains all configurable values that may need to be updated
/// when publishing or configuring the app.
library;

import 'dart:ui';

/// App Store and Play Store configuration
abstract class StoreConfig {
  /// Apple App Store ID (found in App Store Connect → App Information → Apple ID)
  /// Update this when the app is published to the App Store
  static const String appStoreId = ''; // TODO: Add App Store ID when available

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

/// Supported Languages configuration
abstract class LanguageConfig {
  /// All supported content languages with their display names
  /// Add new languages here when adding translations
  /// Format: {'code': 'Display Name'}
  static const Map<String, String> supportedContentLanguages = {
    'en': 'English',
    'ml': 'മലയാളം',
    'es': 'Español',
    'pt_BR': 'Português (Brasil)',
    'fr': 'Français',
  };

  /// Get list of language codes only (for database sync)
  static List<String> get languageCodes =>
      supportedContentLanguages.keys.toList();

  /// Default content language
  static const String defaultContentLanguage = 'en';

  /// Converts a [Locale] to the content key string used for asset paths and DB.
  /// Flutter's `Locale('pt', 'BR').languageCode` returns just `'pt'`,
  /// so we need this bridge to get `'pt_BR'` for Brazilian Portuguese.
  static String contentKeyFromLocale(Locale locale) {
    if (locale.languageCode == 'pt') return 'pt_BR';
    return locale.languageCode;
  }

  /// Converts a content key string back to a [Locale].
  /// Turns `'pt_BR'` into `Locale('pt', 'BR')`.
  static Locale localeFromContentKey(String key) {
    if (key == 'pt_BR') return const Locale('pt', 'BR');
    return Locale(key);
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
}
