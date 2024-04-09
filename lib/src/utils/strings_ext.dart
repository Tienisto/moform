extension StringExt on String {
  String? digestNullable() {
    if (trim().isEmpty) {
      return null;
    }
    return this;
  }
}
