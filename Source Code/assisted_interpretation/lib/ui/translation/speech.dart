import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/braid/display.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  stt.SpeechToText speech;

  bool available = false;
  bool listening = false;
  String recognized = "";

  void listen() {
    setState(() => listening = true);

    speech.listen(
      onResult: (result) => setState(() {
        response = null;
        recognized = result.recognizedWords;
        listening = false;

        BrAidApi.getCellsWithRepr(recognized.trim())
            .then((value) => setState(() => response = value))
            .whenComplete(() => setState(() => translating = false));
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    speech = stt.SpeechToText();

    speech
        .initialize(
          onStatus: (status) => print("Status: $status"),
          onError: (error) => print("Error: $error"),
        )
        .then((value) => available = value);
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
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontWeight: FontWeight.w500, fontSize: 22),
          ),
        ),
        Divider(height: 48.getHeight(context)),
        Text(
          widget.translateTo,
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(height: 12.getHeight(context)),
        Container(
          height: MediaQuery.of(context).size.height / 3.1,
          child: response != null
              ? widget.translateTo == "Braille"
                  ? BrailleDisplay(BrailleData.fromMap(response.response))
                  : Container()
              : Text(
                  translating
                      ? "Translating..."
                      : "Converted Text will appear here",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 22),
                ),
        ),
      ],
    );
  }
}
