extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }

  int toInt() {
    return int.parse(this);
  }
}
