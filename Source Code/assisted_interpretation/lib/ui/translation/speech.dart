import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/api/signus.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/translation/display/sign.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

import 'display/braille.dart';

// ignore: must_be_immutable
class SpeechTranslation extends StatefulWidget {
  final String translateFrom;
  final String translateTo;

  SpeechTranslation({this.translateFrom, this.translateTo});

  _SpeechTranslationState state;

  // TODO FIXME: The method 'listen' was called on null.
  void onTapSelected(String mode) => state.listen();

  // TODO FIXME: The method 'clear' was called on null.
  void clearResponse() => state.clear();

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

  void clear() {
    setState(() {
      recognized = "";
      response = null;
    });
  }

  void listen() {
    clear();
    speech.listen(locale: "en_US");
  }

  @override
  void initState() {
    super.initState();

    speech = SpeechRecognition();

    speech.setAvailabilityHandler(
      (bool result) => setState(() => available = result),
    );
    speech.setRecognitionStartedHandler(
      () => setState(() => listening = true),
    );
    speech.setRecognitionResultHandler(
      (String text) => setState(() {
        if (text != "") {
          response = null;
          translating = true;

          recognized = text;

          widget.translateTo == "Braille"
              ? BrAidApi.getCellsWithRepr(recognized)
                  .then(
                    (value) => setState(() => response = value),
                  )
                  .whenComplete(
                    () => setState(() => translating = false),
                  )
              : SignUsApi.getSigns(recognized)
                  .then(
                    (value) => setState(() => response = value),
                  )
                  .whenComplete(
                    () => setState(() => translating = false),
                  );
        }
      }),
    );
    speech.setRecognitionCompleteHandler(
      () => setState(() => listening = false),
    );

    speech.activate().then(
          (res) => setState(() => available = res),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.translateFrom,
              style: TextStyle(color: Colors.grey[400]),
            ),
            if (recognized != "")
              GestureDetector(
                onTap: () => clear(),
                child: Icon(
                  Icons.clear,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
          ],
        ),
        SizedBox(
          height: 12.getHeight(context),
        ),
        Container(
          height: 75.getHeight(context),
          child: Text(
            recognized != ""
                ? recognized
                : "Click the Mic icon below to Start Listening",
            style: Theme.of(context).textTheme.headline3.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.getHeight(context),
                ),
          ),
        ),
        Divider(
          height: 48.getHeight(context),
        ),
        Text(
          widget.translateTo,
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(
          height: 12.getHeight(context),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: response != null
              ? widget.translateTo == "Braille"
                  ? BrailleDisplay(
                      BrailleData.fromMap(response.response),
                    )
                  : SignDisplay(
                      SignData.fromMap(response.response),
                    )
              : Text(
                  translating
                      ? "Translating..."
                      : "Converted Text will appear here",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.getHeight(context),
                      ),
                ),
        ),
      ],
    );
  }
}
