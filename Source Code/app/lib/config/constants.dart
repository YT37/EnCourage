// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '/models/mode.dart';
import '/models/response.dart';
import '/ui/pages/home/modes/speech.dart';
import '/ui/pages/home/modes/text.dart';

const String SERVER = "encourage-i0s72dya.b4a.run";

const List<String> FROM_LANGS = ["English"];
const List<String> TO_LANGS = ["Braille", "ASL"];

const List<Mode> MODES = [
  Mode(title: "Text", screen: TextTranslation(), icon: Icons.edit),
  Mode(title: "Speech", screen: SpeechTranslation(), icon: Icons.mic),
];

final RxString FROM = FROM_LANGS[0].obs;
final RxString TO = TO_LANGS[0].obs;
final Rx<Mode> MODE = MODES[0].obs;

final Rx<TextEditingController> CONTROLLER = TextEditingController().obs;
final Rx<Response> RESPONSE = Response(response: {}, status: Status.EMPTY).obs;
