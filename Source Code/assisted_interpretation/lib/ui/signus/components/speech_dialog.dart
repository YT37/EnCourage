import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/api/signus.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/signus/display.dart';
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
  String transcription = "";
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
                      transcription.isEmpty
                          ? listening
                              ? "Listening..."
                              : "Recognized text will appear here"
                          : transcription,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(height: 10.getHeight(context)),
                  AlertButton(
                    onPressed: widget.available && !listening
                        ? () {
                            widget.speech.listen(
                              onResult: (result) => setState(
                                () {
                                  transcription = result.recognizedWords;
                                  listening = false;

                                  if (transcription != "") {
                                    widget.speech.stop();
                                    widget.speech.cancel();

                                    listening = false;

                                    FocusScope.of(context).unfocus();

                                    String sentence = transcription;

                                    SignUsApi.getSigns(sentence).then(
                                      (value) {
                                        Response response = value;

                                        Navigator.pop(context);

                                        if (response.status == Status.Ok) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SignScreen(
                                                url: response.response["url"],
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

                            setState(() => listening = true);
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
