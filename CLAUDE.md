# CLAUDE.md

## Project Overview
**Metanoia** - A privacy-focused, offline-first Catholic confession preparation app built with Flutter. All data stored locally with encryption. Supports examination of conscience, confession tracking, penance management, and spiritual insights.

## Development Commands

```bash
# Required before running app
flutter pub get
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs

# Analysis & Testing
flutter analyze --no-fatal-infos
flutter test
```

## Tech Stack
- **Flutter 3.x** - Cross-platform UI framework
- **Riverpod** - State management with code generation
- **Drift** - Type-safe SQLite ORM with reactive queries
- **GoRouter** - Declarative routing
- **Material 3** - Design system with dark/light themes
- **i18n** - 5 languages (EN, ES, FR, PT, ML)

## Architecture

### Feature Structure
```
feature_name/
├── data/           # Repositories, database access
├── domain/         # Business models and entities
└── presentation/   # Screens, widgets, controllers
```

### Provider Patterns
- Use `@riverpod` annotation for code generation
- Controllers extend `_$ControllerName`
- Async providers for database operations
- Use `keepAlive: true` for persistent state

### Database
- Drift tables in `core/database/tables.dart`
- Repositories abstract database access
- SQLite encrypted with `flutter_secure_storage`
- Multi-language content loaded from JSON assets

## UI/UX Standards

### Theme System
**Colors** (`core/theme/app_theme.dart`):
- Light: Deep Royal Purple (#7558A3), Warm Gold (#D4A545)
- Dark: Soft Purple (#9D7FCC), Balanced Gold (#F3CB5C)
- Always use `Theme.of(context).colorScheme.*` - NEVER hardcode colors

**Fonts**:
- **Lato**: Primary UI text (`AppTheme.fontFamilyLato`)
- **EBGaramond**: Spiritual content (`AppTheme.fontFamilyEBGaramond`)
- **Noto Sans Malayalam**: Malayalam support

**Font Sizes**:
- Use theme text styles: `Theme.of(context).textTheme.*`
- Respect user's font size preference (Small, Medium, Large, XL)

### Component Patterns
- Cards: 16px radius, elevation 0, subtle borders
- Buttons: Use theme colors, consistent padding
- BottomSheets: `isScrollControlled: true`, `backgroundColor: Colors.transparent`
- AppBars: Themed colors, centered titles
- Use `flutter_animate` for animations
- Use `HapticUtils` for tactile feedback

### Dark/Light Theme
**CRITICAL**: Every UI change must work in BOTH themes. Always test dark mode.
- Use `colorScheme.surface`, `colorScheme.onSurface`, etc.
- Use `colorScheme.primary`, `colorScheme.secondary` for brand colors
- Never use absolute colors like `Colors.white` or `Colors.black`

## Localization
- Use `AppLocalizations.of(context)!` for all user-facing text
- ARB files in `lib/src/core/localization/l10n/arb/`
- Run `flutter gen-l10n` after ARB changes
- Content language separate from UI language

## Code Conventions

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/methods: `camelCase`
- Private: `_leadingUnderscore`
- Generated files: `.g.dart` suffix

### Imports Order
1. Dart imports
2. Flutter imports
3. Package imports
4. Relative imports
5. Part directives

### Best Practices
- Use `const` constructors where possible
- Avoid `mounted` checks before async calls - use `if (context.mounted)` after
- Use `ref.read()` in event handlers, `ref.watch()` in build
- Clean up controllers in `dispose()`
- Use `HapticUtils.lightImpact()` for user interactions

## Development Workflow

1. **Use Context7 MCP server** for documentation lookups
2. **Test dark mode** for every UI change
3. **Run code generation** after provider/database changes
4. **Commit after feature completion** with clear messages
5. **Run tests** before committing major changes

## Security & Privacy
- All data local-only (no cloud sync)
- Database encrypted with secure storage
- PIN/biometric authentication with progressive lockout
- Background timeout protection

## Testing
- Unit tests for repositories and business logic
- Widget tests for static screens
- Skip tests with `flutter_animate` (timer conflicts)
- Mock database in tests with test helpers
