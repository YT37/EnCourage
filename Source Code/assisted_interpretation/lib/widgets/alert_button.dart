import 'package:assisted_interpretation/config/extensions.dart';
import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  AlertButton({
    @required this.title,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(top: 12, bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.getHeight(context),
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
