import 'package:flutter/material.dart';

import '/config/constants.dart';
import '/ui/pages/home/displays/braille.dart';
import '/ui/pages/home/displays/sign.dart';

Widget display(Map<String, dynamic> response) {
  if (TO.value == TO_LANGS[0]) {
    return BrailleDisplay(
      cells: response["output"],
      captions: response["captions"],
    );
  } else {
    return SignDisplay(
      signs: response["output"],
      captions: response["captions"],
    );
  }
}
