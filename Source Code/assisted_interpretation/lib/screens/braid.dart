import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/components/alert_button.dart';
import 'package:assisted_interpretation/components/rounded_alert_dialog.dart';
import 'package:assisted_interpretation/constant.dart';
import 'package:assisted_interpretation/screens/braille.dart';
import 'package:flutter/material.dart';

class BrAidScreen extends StatelessWidget {
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
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: kUIAccent)),
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
                                await BrAidApi.getCells(sentence);

                            if (response.status == Status.Ok) {
                              Navigator.pop(context);
                              controller.clear();

                              print(response.response);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BrailleScreen(
                                    data:
                                        BrailleData.fromMap(response.response),
                                    word: sentence,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              controller.clear();

                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
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
                          })
                    ]),
              );
            },
            child: Text(
              "Text",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: kUIAccent)),
            onPressed: () {},
            child: Text(
              "Speech",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: kUIAccent)),
            onPressed: () {},
            child: Text(
              "Hand Writting",
              style: TextStyle(fontSize: 24, color: Colors.grey[700]),
            ),
          ),
        ]);
  }
}
