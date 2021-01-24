import 'package:flutter/material.dart';

const kUIAccent = Color(0xff43bfb2);
const kUIColor = Color(0xffF5F9F9);
const kUILightText = Color(0xffF1F9F8);
const kUIDarkText = Color(0xff031715);

double getHeight(BuildContext context, double desiredHeight) =>
    MediaQuery.of(context).size.height * desiredHeight / 816;

const LinearGradient kUIGradient = LinearGradient(
    colors: [kUIAccent, Color(0xff84d1c9)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    stops: [0.55, 0.95]);

const InputDecoration kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF63C1A8), width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
);

const InputDecoration kInputDialogDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8),
    ),
    borderSide: BorderSide(color: kUIAccent, width: 1.5),
  ),
);
