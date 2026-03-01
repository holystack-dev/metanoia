import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Premium Spiritual Color Palette
  // Light theme: Warm, peaceful, reverent
  // Dark theme: Contemplative, serene, elegant

  // Primary: Deep Royal Purple (from logo background)
  static const _primaryLight = Color(0xFF7558A3); // Richer Royal Purple
  static const _primaryDark = Color(0xFF9D7FCC); // Softer Light Purple

  // Secondary: Warm Gold with Orange tones (from cross & flame)
  static const _secondaryLight = Color(0xFFD4A545); // Rich Warm Gold
  static const _secondaryDark = Color(0xFFF3CB5C); // Balanced Warm Gold

  // Accent: Deep Purple (logo background shadow)
  static const _accentPurple = Color(0xFF2D0055); // Deep Purple
  static const _accentPurpleDark = Color(0xFF5B3A7C); // Lighter for dark mode

  // Tertiary: For special accents
  static const _tertiaryLight = Color(0xFFB76E79); // Muted Rose-Gold
  static const _tertiaryDark = Color(0xFFB794D6); // Soft Lavender (dark mode)

  // Surface colors - carefully chosen for readability and peace
  static const _surfaceLight = Color(0xFFFCFBF9); // Richer warm off-white
  static const _cardLight = Color(0xFFFFFFFF); // Pure white cards
  static const _backgroundLight = Color(0xFFF8F6F3); // Warmer subtle grey

  static const _surfaceDark = Color(
    0xFF1C1626,
  ); // Deep purple-tinted dark (lighter)
  static const _cardDark = Color(0xFF272134); // Purple-tinted cards (lighter)
  static const _backgroundDark = Color(0xFF121019); // Deep purple-black

  // Font family constants for local fonts
  static const String fontFamilyLato = 'Lato';
  static const String fontFamilyEBGaramond = 'EBGaramond';
  static const String fontFamilyNotoSansMalayalam = 'NotoSansMalayalam';

  // Font fallback list for Malayalam support
  static const List<String> fontFamilyFallback = [
    fontFamilyNotoSansMalayalam,
  ];

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
        letterSpacing: 0.25,
        height: 1.6,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontFamily: fontFamilyLato,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: _primaryLight,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE5DBEF), // Richer lavender
      onPrimaryContainer: _accentPurple, // Deep Purple
      secondary: _secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFF8E8C8), // Richer cream-gold
      onSecondaryContainer: Color(0xFF3D2800), // Darker brown
      tertiary: _tertiaryLight,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFF4E0E4), // Soft rose
      onTertiaryContainer: Color(0xFF4A1F29), // Deep rose-brown
      surface: _surfaceLight,
      onSurface: Color(0xFF1C1B1F),
      surfaceContainerHighest: Color(0xFFEBE7E3), // Warmer grey
      surfaceContainer: Color(0xFFF5F2EE), // Mid-tone
      surfaceContainerLow: Color(0xFFF9F7F4), // Subtle
      outline: Color(0xFFC4BEC8), // Purple-tinted
      outlineVariant: Color(0xFFE3DED8), // Warm-tinted
      error: Color(0xFFB3261E), // Material 3 error
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundLight,
      textTheme: _buildTextTheme(ThemeData.light().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryLight,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _primaryLight,
          letterSpacing: 0.15,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        color: _cardLight,
        shadowColor: Colors.black.withValues(alpha: 0.05),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryLight,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: _primaryLight.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamilyLato,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _secondaryLight,
        foregroundColor: Color(0xFF3E2723),
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: fontFamilyLato,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _primaryLight,
            );
          }
          return const TextStyle(
            fontFamily: fontFamilyLato,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F),
          );
        }),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: _cardLight,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: _primaryLight.withValues(alpha: 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1C1B1F),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _accentPurple,
        contentTextStyle: const TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: _surfaceLight,
        hourMinuteColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHighest;
        }),
        hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryLight;
          }
          return colorScheme.onSurface;
        }),
        dialHandColor: _primaryLight,
        dialBackgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
        dialTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return colorScheme.onSurface;
        }),
        entryModeIconColor: _primaryLight,
        dayPeriodColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHighest;
        }),
        dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryLight;
          }
          return colorScheme.onSurfaceVariant;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: _primaryDark,
      onPrimary: Color(0xFF1C1626), // Dark purple text on light purple
      primaryContainer: _accentPurpleDark, // Lighter deep purple
      onPrimaryContainer: Color(0xFFE8DFF5), // Very light lavender
      secondary: _secondaryDark,
      onSecondary: Color(0xFF1C1626), // Dark purple text on gold
      secondaryContainer: Color(0xFF4A3D5F), // Purple-tinted (was gold-brown)
      onSecondaryContainer: Color(0xFFE8DFF5), // Light lavender (was light gold)
      tertiary: _tertiaryDark,
      onTertiary: Color(0xFF1C1626),
      tertiaryContainer: Color(0xFF4A3C5F), // Muted purple
      onTertiaryContainer: Color(0xFFE8DFF5),
      surface: _surfaceDark,
      onSurface: Color(0xFFE8E3EB), // Slightly warmer white
      surfaceContainerHighest: Color(0xFF322B3D), // Lighter purple-tinted
      outline: Color(0xFF9D92A3), // Softer outline
      outlineVariant: Color(0xFF463F4E), // Purple-tinted variant
      error: Color(0xFFFFB4AB), // Softer red
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _backgroundDark,
      textTheme: _buildTextTheme(ThemeData.dark().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: _primaryDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _primaryDark,
          letterSpacing: 0.15,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
        color: _cardDark,
        shadowColor: Colors.black.withValues(alpha: 0.3),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryDark,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: _primaryDark.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamilyLato,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _primaryDark,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontFamily: fontFamilyLato,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _primaryDark,
            );
          }
          return const TextStyle(
            fontFamily: fontFamilyLato,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFFE6E1E5),
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _primaryDark.withValues(alpha: 0.3);
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _primaryDark;
            }
            return const Color(0xFFE6E1E5);
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: Color(0xFF463F4E)),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDark;
          }
          return const Color(0xFF9D92A3);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDark.withValues(alpha: 0.5);
          }
          return const Color(0xFF463F4E);
        }),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: _cardDark,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFE8E3EB),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: _accentPurpleDark,
        contentTextStyle: const TextStyle(
          fontFamily: fontFamilyLato,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: _surfaceDark,
        hourMinuteColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHighest;
        }),
        hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDark;
          }
          return colorScheme.onSurface;
        }),
        dialHandColor: _primaryDark,
        dialBackgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.3),
        dialTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return colorScheme.onSurface;
        }),
        entryModeIconColor: _primaryDark,
        dayPeriodColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHighest;
        }),
        dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _primaryDark;
          }
          return colorScheme.onSurfaceVariant;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
