import 'package:intl/intl.dart';

extension NumberFormatExt on NumberFormat {
  /// Parses the given [number] string to a number.
  /// Returns null if the number is invalid.
  /// The same as [NumberFormat.tryParse] but works with pre 0.19.0 versions.
  num? parseOrNull(String number) {
    try {
      return parse(number);
    } on FormatException {
      return null;
    }
  }
}
