import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/config/theme.dart';
import '/ui/pages/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  runApp(const EnCourage());
}

class EnCourage extends StatelessWidget {
  const EnCourage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EnCouargeTheme.of(context),
      title: "EnCourage",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
