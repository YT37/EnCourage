import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class EnCouargeTheme {
  static ThemeData of(BuildContext context) {
    final TextTheme _font = GoogleFonts.poppinsTextTheme();
    final TextTheme _textTheme = _font.copyWith(
      displayLarge: _font.displayLarge!.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: _font.displayMedium!.copyWith(
        fontSize: 26,
        fontWeight: FontWeight.normal,
      ),
      displaySmall: _font.displaySmall!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: _font.titleLarge!.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
      titleMedium: _font.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );

    final ColorScheme _colorScheme = const ColorScheme.light().copyWith(
      primary: const Color(0xFFFFFFFF),
      onPrimary: const Color(0xff000000),
      secondary: const Color(0xff315cf5),
      onSecondary: const Color(0xFFFFFFFF),
      tertiary: const Color(0xff43bfb2),
      onTertiary: const Color(0xFFFFFFFF),
    );

    return ThemeData(
      useMaterial3: true,
      hoverColor: Colors.grey.shade100,
      colorScheme: _colorScheme,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: _colorScheme.primary,
        surfaceTintColor: _colorScheme.primary,
        shadowColor: _colorScheme.primary,
        centerTitle: true,
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 5,
        color: _colorScheme.primary,
        surfaceTintColor: _colorScheme.primary,
        iconColor: _colorScheme.onPrimary,
      ),
      tooltipTheme: const TooltipThemeData(
        margin: EdgeInsets.all(5),
      ),
      cardTheme: CardTheme(
        elevation: 5,
        shadowColor: _colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1.25,
        space: 15,
        color: _colorScheme.onPrimary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            _textTheme.titleLarge!.copyWith(color: _colorScheme.secondary),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          overlayColor: MaterialStateProperty.all<Color>(
            _colorScheme.secondary.withAlpha(50),
          ),
          foregroundColor:
              MaterialStateProperty.all<Color>(_colorScheme.secondary),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: _colorScheme.secondary, width: 0.75),
            ),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            _textTheme.titleLarge!.copyWith(color: _colorScheme.onPrimary),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
          backgroundColor:
              MaterialStateProperty.all<Color>(_colorScheme.primary),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: _colorScheme.primary, width: 0.75),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const StadiumBorder(),
          backgroundColor: _colorScheme.primary,
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey.shade700,
        selectionColor: Colors.grey.shade500,
        selectionHandleColor: Colors.grey.shade700,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            _textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
        fillColor: Colors.transparent,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(12),
      ),
      scrollbarTheme: ScrollbarThemeData(
        interactive: true,
        thumbColor: MaterialStateProperty.all(Colors.grey.shade700),
        thickness: MaterialStateProperty.all(7),
        radius: const Radius.circular(20),
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 10,
        backgroundColor: _colorScheme.secondary,
        contentTextStyle: TextStyle(color: _colorScheme.primary),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 10,
        foregroundColor: _colorScheme.primary,
        backgroundColor: _colorScheme.secondary,
      ),
    );
  }
}



// class EnCouargeTheme {
//   static ThemeData light(context) {

//     const Color primaryColor = const Color(0xff315cf5);
//     const Color accentColor = const Color(0xffFBFBFB);
//     final Color highlightColor = accentColor.withOpacity(0.3);
//     final Color? disabledColor = Colors.grey[300];
//     const Color lightText = const Color(0xffF5F9F9);
//     final Color? darkText = Colors.grey[900];

//     return ThemeData.light().copyWith(
//       scaffoldBackgroundColor: accentColor,
//       colorScheme: const ColorScheme.light().copyWith(
//         primary: primaryColor,
//         onPrimary: lightText,
//         secondary: accentColor,
//         onSecondary: darkText,
//       ),
//       highlightColor: highlightColor,
//       disabledColor: disabledColor,
//       textTheme: Typography.blackHelsinki.copyWith(
//         headline2: TextStyle(
//           color: darkText,
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//         ),
//         headline3: TextStyle(
//           color: Colors.grey[700],
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//         headline6: TextStyle(
//           color: darkText,
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//         ),
//         caption: TextStyle(color: darkText),
//         bodyText2: TextStyle(
//           color: lightText,
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 0.2,
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(8),
//           ),
//           borderSide: BorderSide(color: primaryColor, width: 1.5),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: ButtonStyle(
//           padding: MaterialStateProperty.all(
//             EdgeInsets.symmetric(
//               horizontal: 18,
//             ),
//           ),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//               side: BorderSide(color: primaryColor),
//             ),
//           ),
//         ),
//       ),
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: Colors.grey[800],
//         contentTextStyle: TextStyle(color: accentColor),
//         elevation: 10,
//       ),
//       dividerTheme: DividerThemeData(color: Colors.grey[400]),
//     );
//   }
// }
