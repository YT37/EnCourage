import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/components/alert_button.dart';
import 'package:assisted_interpretation/components/rounded_alert_dialog.dart';
import 'package:assisted_interpretation/constant.dart';
import 'package:assisted_interpretation/screens/braille.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

class BrAidScreen extends StatefulWidget {
  @override
  _BrAidScreenState createState() => _BrAidScreenState();
}

class _BrAidScreenState extends State<BrAidScreen> {
  SpeechRecognition _speech;

  bool _speechRecognitionAvailable = false;
  bool _isListening = false;

  String transcription = "";

  void start() =>
      _speech.listen(locale: "en_US").then((result) => print(result));

  void cancel() => _speech.cancel().then(
        (result) => setState(() => _isListening = result),
      );

  void stop() => _speech.stop().then(
        (result) => setState(() => _isListening = result),
      );

  void onSpeechAvailability(bool result) =>
      setState(() => _speechRecognitionAvailable = result);

  void onRecognitionStarted() => setState(() => _isListening = true);

  void onRecognitionResult(String text) => setState(() => transcription = text);

  void onRecognitionComplete() => setState(() => _isListening = false);

  @override
  initState() {
    super.initState();

    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler(onSpeechAvailability);
    _speech.setRecognitionStartedHandler(onRecognitionStarted);
    _speech.setRecognitionResultHandler(onRecognitionResult);
    _speech.setRecognitionCompleteHandler(onRecognitionComplete);
    _speech.activate().then(
          (res) => setState(() => _speechRecognitionAvailable = res),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: getHeight(context, 100),
          ),
          Text(
            "Convert To Braille",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: getHeight(context, 24),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: kUIAccent),
            ),
            onPressed: () {
              TextEditingController controller = TextEditingController();

              showDialog(
                context: context,
                builder: (_) => RoundedAlertDialog(
                  titleSize: 22,
                  title: "Type a Sentence or Word",
                  centerTitle: true,
                  isExpanded: false,
                  otherWidgets: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        maxLines: 2,
                        minLines: 1,
                        controller: controller,
                        decoration: kInputDialogDecoration.copyWith(
                            hintText: "Sentence or Word"),
                      ),
                    ),
                  ],
                  buttonsList: [
                    AlertButton(
                      title: "Done",
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        String sentence = controller.text;

                        Response response = await BrAidApi.getCells(sentence);

                        Navigator.pop(context);
                        controller.clear();

                        if (response.status == Status.Ok) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => BrailleScreen(
                                data: BrailleData.fromMap(response.response),
                                word: sentence,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 10,
                              backgroundColor: kUIAccent,
                              content: Text(
                                "Sorry, Could'nt Convert the Text",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            },
            child: Text(
              "Text",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: kUIAccent),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => RoundedAlertDialog(
                  titleSize: 22,
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
                              padding: EdgeInsets.all(8),
                              color: Colors.grey.shade200,
                              child: Text(transcription),
                            ),
                            SizedBox(height: getHeight(context, 10)),
                            AlertButton(
                              onPressed:
                                  _speechRecognitionAvailable && !_isListening
                                      ? () => start()
                                      : null,
                              title: _isListening ? "Listening..." : "Listen",
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AlertButton(
                                    onPressed: _isListening
                                        ? () {
                                            cancel();

                                            Navigator.pop(context);
                                          }
                                        : null,
                                    title: "Cancel",
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: AlertButton(
                                    onPressed: _isListening &&
                                            transcription != ""
                                        ? () async {
                                            stop();

                                            FocusScope.of(context).unfocus();

                                            String sentence = transcription;

                                            Response response =
                                                await BrAidApi.getCells(
                                                    sentence);

                                            Navigator.pop(context);

                                            if (response.status == Status.Ok) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          BrailleScreen(
                                                    data: BrailleData.fromMap(
                                                        response.response),
                                                    word: sentence,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              Scaffold.of(context)
                                                  .removeCurrentSnackBar();
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  elevation: 10,
                                                  backgroundColor: kUIAccent,
                                                  content: Text(
                                                    "Sorry, Could'nt Convert the Text",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                    title: "Done",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            child: Text(
              "Speech",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: kUIAccent),
            ),
            onPressed: () {},
            child: Text(
              "Hand Writting",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
        ]);
  }
}
