import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/config/constant.dart';
import 'package:assisted_interpretation/ui/braid/components/speech_dialog.dart';
import 'package:assisted_interpretation/widgets/alert_button.dart';
import 'package:assisted_interpretation/widgets/rounded_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import './display.dart';

class BrAidScreen extends StatefulWidget {
  @override
  _BrAidScreenState createState() => _BrAidScreenState();
}

class _BrAidScreenState extends State<BrAidScreen> {
  bool available = false;

  stt.SpeechToText speech;

  @override
  initState() {
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
        MaterialButton(
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

                      Response response =
                          await BrAidApi.getCellsWithRepr(sentence);

                      Navigator.pop(context);
                      controller.clear();

                      if (response.status == Status.Ok) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => BrailleScreen(
                              data: BrailleData.fromMap(response.response),
                              text: sentence,
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
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: kUIAccent),
          ),
          onPressed: () => showDialog(
              context: context,
              builder: (_) => SpeechDialog(
                    speech: speech,
                    available: available,
                  )),
          child: Text(
            "Speech",
            style: TextStyle(fontSize: 24, color: Colors.grey[700]),
          ),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: kUIAccent),
          ),
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            final PickedFile image =
                await picker.getImage(source: ImageSource.camera);

            if (image != null) {
              final String text =
                  "I am trying Handwriting to Braille Conversion by AI";

              final Response response = await BrAidApi.getCellsWithRepr(text);

              if (response.status == Status.Ok) {
                print(response.response);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BrailleScreen(
                      data: BrailleData.fromMap(response.response),
                      text: text,
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
            }
          },
          child: Text(
            "Hand Writting",
            style: TextStyle(fontSize: 24, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
