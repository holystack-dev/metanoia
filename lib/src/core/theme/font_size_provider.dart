import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'font_size_provider.g.dart';

/// Font size scale options
enum FontSizeScale {
  small(0.85, 'Small'),
  medium(1.0, 'Medium'),
  large(1.15, 'Large'),
  extraLarge(1.3, 'Extra Large');

  const FontSizeScale(this.scale, this.label);
  final double scale;
  final String label;
}

@riverpod
class FontSizeController extends _$FontSizeController {
  static const _key = 'font_size_scale';

  /// Resolved synchronously from the preferences preloaded in `main`, so text
  /// is not laid out at the default scale for a frame and then re-laid out.
  @override
  FontSizeScale build() {
    final scaleName = ref.watch(sharedPreferencesProvider).getString(_key);
    if (scaleName == null) return FontSizeScale.medium;

    return FontSizeScale.values.firstWhere(
      (e) => e.name == scaleName,
      orElse: () => FontSizeScale.medium,
    );
  }

  Future<void> setFontSize(FontSizeScale scale) async {
    state = scale;
    await ref.read(sharedPreferencesProvider).setString(_key, scale.name);
  }
}
