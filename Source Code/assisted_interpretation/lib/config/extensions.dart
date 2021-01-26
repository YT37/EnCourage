import 'package:flutter/cupertino.dart';

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

extension IntExtension on int {
  double getHeight(BuildContext context, double desiredHeight) =>
      MediaQuery.of(context).size.height * desiredHeight / 816;
}
