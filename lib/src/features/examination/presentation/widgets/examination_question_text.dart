import 'package:flutter/widgets.dart';

/// Splits a composite examination question into its constituent questions for
/// display only.
///
/// Some content records bundle several questions into one entry
/// ("Have I …? Have I …?"). This splits on "?" so each prompt gets its own
/// line; the record stays a single selectable item. Every content language
/// ends a question with "?".
///
/// A single question (one "?", or none) is returned unchanged in a one-element
/// list, so callers can treat the result uniformly.
List<String> splitExaminationQuestion(String text) {
  final trimmed = text.trim();
  if (!trimmed.contains('?')) return [trimmed];

  final parts = <String>[];
  final buffer = StringBuffer();
  for (final rune in trimmed.runes) {
    final ch = String.fromCharCode(rune);
    buffer.write(ch);
    if (ch == '?') {
      final part = buffer.toString().trim();
      if (part.isNotEmpty) parts.add(part);
      buffer.clear();
    }
  }
  final tail = buffer.toString().trim();
  if (tail.isNotEmpty) parts.add(tail);

  // Only treat it as multi-part when the split actually yielded more than one
  // prompt; otherwise render the original text untouched.
  return parts.length > 1 ? parts : [trimmed];
}

/// Renders an examination question as one or more lines: a single prompt is a
/// plain paragraph, a composite one becomes a short stack of prompts under the
/// same (single) selection — never separate checkboxes.
class ExaminationQuestionText extends StatelessWidget {
  const ExaminationQuestionText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final lines = splitExaminationQuestion(text);
    if (lines.length == 1) {
      return Text(lines.first, style: style, textAlign: textAlign);
    }

    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < lines.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Text(lines[i], style: style, textAlign: textAlign),
        ],
      ],
    );
  }
}
