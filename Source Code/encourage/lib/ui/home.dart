import 'package:encourage/config/extensions.dart';
import 'package:encourage/ui/mode_selection.dart';
import 'package:encourage/ui/translation/image.dart';
import 'package:encourage/ui/translation/speech.dart';
import 'package:encourage/ui/translation/text.dart';
import 'package:encourage/widgets/alert_button.dart';
import 'package:encourage/widgets/rounded_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<String> translateFromOptions = ["English"];
  final List<String> translateToOptions = ["Braille", "BSL"];

  String translateFrom = "English";
  String translateTo = "Braille";

  String mode = "text";

  @override
  Widget build(BuildContext context) {
    dynamic translationScreen;

    if (mode == "text")
      translationScreen = TextTranslation(
        translateFrom: translateFrom,
        translateTo: translateTo,
      );
    else if (mode == "speech")
      translationScreen = SpeechTranslation(
        translateFrom: translateFrom,
        translateTo: translateTo,
      );
    else if (mode == "image")
      translationScreen = ImageTranslation(
        translateFrom: translateFrom,
        translateTo: translateTo,
      );

    return WillPopScope(
      onWillPop: () async {
        return showDialog(
          context: context,
          builder: (_) => RoundedAlertDialog(
            title: "Do you want to quit the app?",
            buttonsList: [
              AlertButton(
                onPressed: () => Navigator.pop(context),
                title: "No",
              ),
              AlertButton(
                onPressed: () => SystemNavigator.pop(),
                title: "Yes",
              )
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "EnCourage",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              translateFrom,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 18.getHeight(context),
                                  ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 1.getHeight(context),
                                horizontal: 20.getHeight(context),
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Color(0xff43bfb2).withOpacity(0.85),
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  stops: [0.35, 0.95],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.swap_horiz,
                                size: 26.getHeight(context),
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.9),
                              ),
                            ),
                            DropdownButton<String>(
                              value: translateTo,
                              underline: Container(),
                              elevation: 1,
                              dropdownColor: Theme.of(context).accentColor,
                              icon: Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20.getHeight(context),
                                  color: Colors.grey[800],
                                ),
                              ),
                              onChanged: (String option) {
                                if (translateTo != option) {
                                  translationScreen.clearResponse();
                                  setState(() {
                                    translateTo = option;
                                  });
                                }
                              },
                              items: translateToOptions
                                  .map<DropdownMenuItem<String>>(
                                    (String option) => DropdownMenuItem(
                                        child: Text(
                                          option,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 18.getHeight(context),
                                              ),
                                        ),
                                        value: option),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        Divider(
                          height: 40.getHeight(context),
                        ),
                        translationScreen,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ModeSelectionWheel(
                    onChangeMode: (String _mode) =>
                        setState(() => mode = _mode),
                    onTapSelected: (String mode) => setState(
                      () => translationScreen.onTapSelected(mode),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
