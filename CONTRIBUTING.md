# Contributing to Metanoia

Thank you for your interest in contributing to Metanoia! This guide will help you get started.

## Code of Conduct

Please be respectful and considerate in all interactions. This is a spiritual app meant to help Catholics grow in their faith.

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](https://github.com/holystack-dev/metanoia/issues)
2. If not, create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - Device/OS information
   - Screenshots if applicable

### Suggesting Features

1. Open an issue with the `enhancement` label
2. Describe the feature and its benefit to users
3. Be open to discussion about implementation

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Test thoroughly on both iOS and Android
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

#### PR Guidelines

- Keep changes focused and atomic
- Follow existing code style
- Support both dark and light themes for UI changes
- Test on both platforms when possible
- Update documentation if needed

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/metanoia.git
cd metanoia

# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Run the app
flutter run
```

## Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

## Adding Translations

We welcome translations to make Metanoia accessible to more Catholics worldwide!

### Steps to Add a New Language

1. **Create the ARB file**

   Copy `lib/src/core/localization/l10n/arb/app_en.arb` to `app_XX.arb` where `XX` is the [ISO 639-1 language code](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).

2. **Translate the strings**

   Translate all values (not keys) in the ARB file. Keep placeholders like `{count}` intact.

3. **Add content translations**

   Create translated versions of the JSON files in `assets/data/`:
   - `examination_XX.json` - Examination questions
   - `prayers_XX.json` - Prayers
   - `guide_XX.json` - Confession guide
   - `faq_XX.json` - FAQs
   - `invitation_XX.json` - Invitation content

4. **Update the supported locales**

   Add your locale to `lib/src/core/localization/l10n/l10n.yaml`

5. **Test your translations**

   ```bash
   flutter gen-l10n
   flutter run
   ```

   Switch to your language in Settings to verify.

6. **Submit a PR**

   Include all translated files in a single PR.

### Translation Guidelines

- Maintain the spiritual tone and accuracy of the content
- Use formal language appropriate for prayer and religious context
- Keep technical terms consistent with Catholic tradition in your language
- Test that pluralization works correctly for your language

## Content Licensing

**Important:** The content in `assets/data/` (examination questions, prayers, guides) is licensed under **CC BY-NC-ND 4.0**, which means:

- You may **not** modify the spiritual content
- Translations are considered derivative works and must maintain accuracy
- Commercial use requires permission

If you're contributing translations, you're agreeing to have your translations licensed under the same terms.

## Questions?

Feel free to open an issue or reach out at [holystack.dev](https://holystack.dev).

---

Thank you for helping make Metanoia better for the Catholic community!
