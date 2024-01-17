import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _hole;
  late Timer _timer;

  Size size = Size.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() => size = MediaQuery.of(context).size);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() => setState(() {}));

    _hole = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _timer = Timer(
      const Duration(seconds: 2),
      () {
        _controller.forward();
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: context.theme.colorScheme.primary,
        ),
        if (_hole.value < 1.5)
          Center(
            child: Hero(
              tag: "logo",
              child: Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Image.asset(
                    "assets/images/Logo.png",
                    height: 300,
                    width: 300,
                  ),
                ),
              ),
            ),
          ),
        Opacity(
          opacity: pow(_hole.value / 2, 2) as double,
          child: const HomeScreen(),
        ),
        if (_hole.value < 1.5)
          SizedBox.expand(
            child: CustomPaint(
              painter: AnimatedCircle(
                circleSize: _hole.value * size.height,
                accentColor: context.theme.colorScheme.secondary,
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
    final double radius = circleSize / 2;
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Rect rCircle = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    final Path circle = Path.combine(
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
