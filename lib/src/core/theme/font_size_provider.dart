import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  FontSizeScale build() {
    _loadFontSize();
    return FontSizeScale.medium;
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final scaleName = prefs.getString(_key);
    if (scaleName != null) {
      state = FontSizeScale.values.firstWhere(
        (e) => e.name == scaleName,
        orElse: () => FontSizeScale.medium,
      );
    }
  }

  Future<void> setFontSize(FontSizeScale scale) async {
    state = scale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, scale.name);
  }
}
