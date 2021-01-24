import 'dart:ui' as ui;

import 'package:assisted_interpretation/config/constant.dart';
import 'package:assisted_interpretation/ui/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      AssisstedInterpratation(),
    ),
  );
}

class AssisstedInterpratation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          highlightColor: Colors.blueGrey, fontFamily: "sans-serif-condensed"),
      builder: (BuildContext context, Widget widget) =>
          ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(
          context,
          widget,
        ),
        maxWidth: 1200,
        minWidth: 360,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(360, name: MOBILE),
          ResponsiveBreakpoint.autoScale(500, name: MOBILE),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: kUIColor),
      ),
      title: 'assisted_interpretation',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => SplashScreen(),
        "/home": (BuildContext context) => HomeScreen(),
        "/braid": (BuildContext context) => BrAidScreen(),
        "/signus": (BuildContext context) => SignUsScreen(),
      },
    );
  }
}
