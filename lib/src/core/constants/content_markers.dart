/// Markers the bundled JSON content uses to tag lines that need special
/// presentation.
///
/// The content says what a line is; never infer it from the text, which only
/// works for languages whose patterns are known.
library;

/// A prayer, set apart and centred.
const kPrayerMarker = '[PRAYER]';

/// A quotation from scripture.
const kScriptureMarker = '[SCRIPTURE]';

/// A quotation from a saint or a pope.
const kSaintMarker = '[SAINT]';

/// The closing Amen of a prayer, set apart. Tagged because its spelling varies
/// by language ("Amén.", "Amém.", "Amin.", ...).
const kAmenMarker = '[AMEN]';

/// Every marker, for stripping them out of text before it is displayed.
const kContentMarkers = [
  kPrayerMarker,
  kScriptureMarker,
  kSaintMarker,
  kAmenMarker,
];

/// [text] with every content marker removed.
String stripContentMarkers(String text) {
  var result = text;
  for (final marker in kContentMarkers) {
    result = result.replaceAll(marker, '');
    result = result.replaceAll('[/${marker.substring(1)}', '');
  }
  return result.trim();
}
