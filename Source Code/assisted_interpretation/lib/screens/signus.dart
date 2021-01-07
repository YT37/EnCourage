import 'package:assisted_interpretation/components/alert_button.dart';
import 'package:assisted_interpretation/components/rounded_alert_dialog.dart';
import 'package:assisted_interpretation/constant.dart';
import 'package:assisted_interpretation/screens/sign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUsScreen extends StatelessWidget {
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
            "Convert To Sign",
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

                            http.Response token = await http.get(
                                "https://api.txttosl.com/api/v1/translate?hoster=self&lang=ASL&text=${sentence.toLowerCase().trim()}&redirect=false");

                            if (token.statusCode == 200) {
                              String url = token.body;

                              Navigator.pop(context);
                              controller.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignScreen(
                                            url: url,
                                            word: sentence.capitalize())),
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
                                    "Sorry, Could'nt COnvert the Text",
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
          )
        ]);
  }
}
