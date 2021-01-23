import 'package:assisted_interpretation/config/constant.dart';
import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color backgroundColor;
  final Color titleColor;
  final double titleSize;

  AlertButton(
      {@required this.title,
      @required this.onPressed,
      this.backgroundColor = kUIAccent,
      this.titleColor = kUIColor,
      this.titleSize = 17});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      disabledColor: kUIAccent,
      padding: EdgeInsets.only(top: 12, bottom: 12),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: titleColor,
            fontSize: titleSize,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }
}
