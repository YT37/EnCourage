import 'package:flutter/material.dart';

class Mode {
  final String title;
  final Widget screen;
  final IconData icon;

  const Mode({
    required this.title,
    required this.screen,
    required this.icon,
  });

  @override
  bool operator ==(Object obj) {
    return obj is Mode && obj.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
