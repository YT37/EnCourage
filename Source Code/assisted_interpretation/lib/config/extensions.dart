extension StringExtension on String {
  String capitalize() {
    return this.isEmpty ? this : this[0].toUpperCase() + this.substring(1);
  }

  int toInt() {
    return int.parse(this);
  }

  bool toBool() {
    return this.toLowerCase() == "true";
  }
}
