import 'package:flutter/material.dart';

double getHeight(BuildContext context, double desiredHeight) =>
    MediaQuery.of(context).size.height * desiredHeight / 816;
