import 'dart:ui' as ui;

import 'package:encourage/config/theme.dart';
import 'package:encourage/ui/export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);

  Firebase.initializeApp().whenComplete(() {
    FirebasePerformance.instance
        .setPerformanceCollectionEnabled(false)
        .whenComplete(() {
      FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(false)
          .whenComplete(() {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .whenComplete(
          () => runApp(
            EnCourage(),
          ),
        );
      });
    });
  });
}

class EnCourage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget widget) => Theme(
        data: AppTheme.light(context),
        child: ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
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
          background: Container(color: Theme.of(context).accentColor),
        ),
      ),
      title: "EnCourage",
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => SplashScreen(),
        "/home": (BuildContext context) => HomeScreen(),
      },
    );
  }
}
