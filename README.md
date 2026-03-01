# Metanoia

A beautiful, privacy-focused Catholic confession preparation app built with Flutter.

> **Metanoia** (Greek: μετάνοια) - A profound change of mind and heart; a spiritual awakening that transforms one's entire being and redirects their life toward God.

## Features

- **Examination of Conscience** - Guided examination based on the Ten Commandments
- **Confession Tracker** - Keep track of sins during confession
- **Prayer Collection** - Prayers for before and after confession
- **Penance Tracker** - Track assigned penances
- **Confession History** - View your confession journey over time
- **Insights & Statistics** - Track your spiritual growth with confession streaks and frequency
- **Custom Sins** - Add personalized examination questions
- **Reminders** - Set regular confession reminders
- **Multi-language Support** - Available in English, Spanish, French, Portuguese, and Malayalam
- **Dark & Light Themes** - Beautiful UI that adapts to your preference
- **PIN & Biometric Lock** - Protect your private data
- **Fully Offline** - No internet required, your data stays on your device

## Screenshots

*Coming soon*

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) 3.x
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (SQLite)
- **Notifications**: [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **Security**: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage), [local_auth](https://pub.dev/packages/local_auth)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Localization**: Flutter's built-in l10n with ARB files

## Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/holystack-dev/metanoia.git
   cd metanoia
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate localization files:
   ```bash
   flutter gen-l10n
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Building for Release

**Android:**
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── src/
│   ├── core/
│   │   ├── constants/      # App constants and URLs
│   │   ├── database/       # Drift database setup
│   │   ├── localization/   # L10n ARB files
│   │   ├── providers/      # Core Riverpod providers
│   │   ├── routing/        # Go Router configuration
│   │   ├── services/       # App services (reminders, etc.)
│   │   └── theme/          # App theming
│   └── features/
│       ├── confess/        # Confession tracking
│       ├── examination/    # Examination of conscience
│       ├── guide/          # Confession guide & FAQs
│       ├── home/           # Home screen
│       ├── onboarding/     # First-time user experience
│       ├── prayers/        # Prayer collection
│       └── settings/       # App settings
├── main.dart
└── app.dart
assets/
├── data/                   # Examination questions, prayers, guides (JSON)
├── fonts/                  # Custom fonts
└── images/                 # App images and icons
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Translation

Want to add support for your language? See the [Translation Guide](CONTRIBUTING.md#adding-translations) in our contributing guidelines.

## License

This project uses a dual license:

- **Code** (everything except `assets/data/`): [MIT License](LICENSE)
- **Content** (`assets/data/` - examination questions, prayers, guides): [CC BY-NC-ND 4.0](assets/data/LICENSE)

The content license ensures that spiritual content remains accurate and unchanged in derivative works.

## Privacy

Metanoia is designed with privacy as a core principle:

- All data is stored locally on your device
- No accounts, no cloud sync, no tracking
- Optional PIN/biometric protection
- See our [Privacy Policy](https://holystack.dev/metanoia/privacy/)

## Support

- **Website**: [holystack.dev/metanoia](https://holystack.dev/metanoia/)
- **Issues**: [GitHub Issues](https://github.com/holystack-dev/metanoia/issues)

## Acknowledgments

- Icons from [Material Design Icons](https://materialdesignicons.com/)
- Built with love for the Catholic community

---

Made with love by [holystack.dev](https://holystack.dev)
