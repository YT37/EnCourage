import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    // Color primaryColor = Color(0xff335CEA);
    Color primaryColor = Color(0xff43bfb2);
    // Color accentColor = Color(0xffFBFBFB);
    Color accentColor = Color(0xffF5F9F9);
    Color highlightColor = accentColor.withOpacity(0.3);
    Color disabledColor = Colors.grey[300];
    Color lightText = Color(0xffF5F9F9);
    Color darkText = Colors.grey[900];

    return ThemeData.light().copyWith(
      accentColor: accentColor,
      primaryColor: primaryColor,
      highlightColor: highlightColor,
      disabledColor: disabledColor,
      textTheme: Typography.blackHelsinki.copyWith(
        headline2: TextStyle(
          color: darkText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        headline3: TextStyle(
          color: Colors.grey[700],
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          color: darkText,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(color: darkText),
        bodyText2: TextStyle(
          color: lightText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: 18,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: primaryColor),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey[800],
        contentTextStyle: TextStyle(color: accentColor),
        elevation: 10,
      ),
      dividerTheme: DividerThemeData(color: Colors.grey[400]),
    );
  }
}
