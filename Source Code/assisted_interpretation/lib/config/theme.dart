import 'package:flutter/material.dart';

enum AppTheme { Light }

final Map<AppTheme, ThemeData> appThemes = <AppTheme, ThemeData>{
  AppTheme.Light: ThemeData.light().copyWith(
    accentColor: Color(0xff43bfb2),
    primaryColor: Color(0xffF5F9F9),
    textTheme: Typography.blackHelsinki,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF63C1A8), width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  ),
};
