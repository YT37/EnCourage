import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/braid/display.dart';
import 'package:assisted_interpretation/widgets/alert_button.dart';
import 'package:assisted_interpretation/widgets/rounded_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

// ignore: must_be_immutable
class SpeechDialog extends StatefulWidget {
  bool available;
  stt.SpeechToText speech;

  SpeechDialog({@required this.speech, @required this.available});

  @override
  _SpeechDialogState createState() => _SpeechDialogState();
}

class _SpeechDialogState extends State<SpeechDialog> {
  String translation = "";
  bool listening = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (listening) {
          widget.speech.stop();
          widget.speech.cancel();

          listening = false;
        } else {
          Navigator.pop(context);
        }

        return true;
      },
      child: RoundedAlertDialog(
        title: "Press to Speak",
        centerTitle: true,
        isExpanded: false,
        otherWidgets: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.grey.shade200,
                    child: Text(
                      translation.isEmpty
                          ? listening
                              ? "Listening..."
                              : "Recognized text will appear here"
                          : translation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: 10.getHeight(context),
                  ),
                  AlertButton(
                    onPressed: widget.available && !listening
                        ? () {
                            setState(() => listening = true);

                            widget.speech.listen(
                              onResult: (result) => setState(
                                () {
                                  translation = result.recognizedWords;
                                  listening = false;

                                  if (translation != "") {
                                    widget.speech.stop();
                                    widget.speech.cancel();

                                    listening = false;

                                    FocusScope.of(context).unfocus();

                                    String sentence = translation;

                                    BrAidApi.getCellsWithRepr(sentence).then(
                                      (value) {
                                        Response response = value;

                                        Navigator.pop(context);

                                        if (response.status == Status.Ok) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  BrailleScreen(
                                                data: BrailleData.fromMap(
                                                    response.response),
                                                text: sentence,
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Sorry, Could'nt Convert the Text",
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            );
                          }
                        : null,
                    title: listening ? "Listening..." : "Listen",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
