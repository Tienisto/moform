extension StringExt on String {
  String? digestNullable() {
    final s = trim();
    if (s.isEmpty) {
      return null;
    }
    return s;
  }

  String digestNonNullable() {
    return trim();
  }
}
