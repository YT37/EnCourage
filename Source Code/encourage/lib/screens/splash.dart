import 'dart:async';
import 'dart:math';

import 'package:encourage/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  late AnimationController _controller;
  late Animation<double> holeSize;

  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() => size = MediaQuery.of(context).size);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addListener(() => setState(() {}));

    holeSize = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    Timer(Duration(seconds: 2), () => setState(() => _controller.forward()));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).accentColor,
        ),
        if (holeSize.value < 1.5)
          Center(
            child: Hero(
              tag: "logo",
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
            ),
          ),
        Opacity(
          opacity: pow(holeSize.value / 2, 2) as double,
          child: HomeScreen(),
        ),
        if (holeSize.value < 1.5)
          Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomPaint(
              painter: AnimatedCircle(
                circleSize: holeSize.value * size.height,
                accentColor: Theme.of(context).accentColor,
              ),
            ),
          ),
      ],
    );
  }
}

class AnimatedCircle extends CustomPainter {
  AnimatedCircle({
    required this.circleSize,
    required this.accentColor,
  });

  double circleSize;
  Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    double radius = circleSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect rCircle = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    Path circle = Path.combine(
      PathOperation.intersect,
      Path()..addRect(rect),
      Path()
        ..addOval(rCircle)
        ..close(),
    );

    canvas.drawPath(circle, Paint()..color = accentColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
