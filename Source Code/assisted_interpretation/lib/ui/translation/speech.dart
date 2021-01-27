import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

import 'display/braille.dart';

// ignore: must_be_immutable
class SpeechTranslation extends StatefulWidget {
  final String translateFrom;
  final String translateTo;

  SpeechTranslation({this.translateFrom, this.translateTo});

  _SpeechTranslationState state;

  void onTapSelected(String mode) => state.listen();

  @override
  _SpeechTranslationState createState() {
    state = _SpeechTranslationState();
    return state;
  }
}

class _SpeechTranslationState extends State<SpeechTranslation> {
  Response response;
  bool translating = false;

  SpeechRecognition speech;

  bool available = false;
  bool listening = false;
  String recognized = "";

  void listen() {
    speech
        .listen(locale: "en_US")
        .then((result) => print('_MyAppState.start => result $result'));
  }

  @override
  void initState() {
    super.initState();

    speech = SpeechRecognition();
    speech
        .setAvailabilityHandler((result) => setState(() => available = result));
    speech.setRecognitionStartedHandler(() => setState(() => listening = true));
    speech.setRecognitionResultHandler((String text) => setState(() {
          response = null;
          translating = true;

          recognized = text;

          BrAidApi.getCellsWithRepr(recognized.trim())
              .then((value) => setState(() => response = value))
              .whenComplete(() => setState(() => translating = false));
        }));
    speech
        .setRecognitionCompleteHandler(() => setState(() => listening = false));
    speech.activate().then((res) => setState(() => available = res));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "English",
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(height: 12.getHeight(context)),
        Container(
          height: 75.getHeight(context),
          child: Text(
            recognized != "" ? recognized : "The spoken text will appear here",
            style: Theme.of(context).textTheme.headline3.copyWith(
                fontWeight: FontWeight.w500, fontSize: 22.getHeight(context)),
          ),
        ),
        Divider(height: 48.getHeight(context)),
        Text(
          widget.translateTo,
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(height: 12.getHeight(context)),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: response != null
              ? widget.translateTo == "Braille"
                  ? BrailleDisplay(BrailleData.fromMap(response.response))
                  : Container()
              : Text(
                  translating
                      ? "Translating..."
                      : "Converted Text will appear here",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.getHeight(context)),
                ),
        ),
      ],
    );
  }
}
