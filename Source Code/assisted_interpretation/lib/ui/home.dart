import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/mode_selection.dart';
import 'package:assisted_interpretation/ui/translation/speech.dart';
import 'package:assisted_interpretation/ui/translation/text.dart';
import 'package:assisted_interpretation/widgets/alert_button.dart';
import 'package:assisted_interpretation/widgets/rounded_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<String> translateFromOptions = ["English"];
  final List<String> translateToOptions = ["Braille", "ASL"];

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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 6.getHeight(context)),
                Stack(
                  children: [
                    Icon(Icons.menu),
                    Center(
                      child: Text(
                        "Assisted Interpretation",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.getHeight(context)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                  .copyWith(fontSize: 18.getHeight(context)),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.getHeight(context),
                                  horizontal: 20.getHeight(context)),
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
                                if (translateTo != option)
                                  setState(() => translateTo = option);
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
                                                  fontSize:
                                                      18.getHeight(context)),
                                        ),
                                        value: option),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        Divider(height: 40.getHeight(context)),
                        translationScreen,
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ModeSelectionWheel(
                    onChangeMode: (String _mode) =>
                        setState(() => mode = _mode),
                    onTapSelected: (String mode) =>
                        translationScreen.onTapSelected(mode),
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
