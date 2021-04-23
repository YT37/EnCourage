import 'package:encourage/api/braid.dart';
import 'package:encourage/api/response.dart';
import 'package:encourage/api/signus.dart';
import 'package:encourage/config/extensions.dart';
import 'package:encourage/screens/translation/display/sign.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'display/braille.dart';

bool doClear = false;
bool doListen = false;

// ignore: must_be_immutable
class SpeechTranslation extends StatefulWidget {
  final String? translateFrom;
  final String? translateTo;

  SpeechTranslation({this.translateFrom, this.translateTo});

  void onTapSelected(String mode) => doListen = true;

  void clearResponse() => doClear = true;

  @override
  _SpeechTranslationState createState() => _SpeechTranslationState();
}

class _SpeechTranslationState extends State<SpeechTranslation> {
  Response? response;
  bool translating = false;

  SpeechToText speech = SpeechToText();

  bool available = false;
  bool listening = false;
  String recognized = "";

  void clear() => setState(() {
        recognized = "";
        response = null;
      });

  void listen() async {
    clear();

    available = await speech.initialize(
      onStatus: (_) {},
      onError: (SpeechRecognitionError e) =>
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.errorMsg, textAlign: TextAlign.center),
        ),
      ),
    );

    if (available)
      speech.listen(onResult: (SpeechRecognitionResult result) {
        String text = result.recognizedWords;

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
      });
    else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please allow microphone access from settings",
              textAlign: TextAlign.center),
        ),
      );

    speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (doClear) {
      clear();
      doClear = false;
    }

    if (doListen) {
      listen();
      doListen = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.translateFrom!,
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
                : "Click the Mic Icon below to start listening",
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.getHeight(context),
                ),
          ),
        ),
        Divider(height: 48.getHeight(context)),
        Text(
          widget.translateTo!,
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(height: 12.getHeight(context)),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: response != null
              ? widget.translateTo == "Braille"
                  ? BrailleDisplay(
                      BrailleData.fromMap(response!.response!),
                    )
                  : SignDisplay(
                      SignData.fromMap(response!.response!),
                    )
              : Text(
                  translating
                      ? "Translating..."
                      : "Converted Text will appear here",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.getHeight(context),
                      ),
                ),
        ),
      ],
    );
  }
}
