import 'package:assisted_interpretation/ui/mode_selection.dart';
import 'package:assisted_interpretation/ui/translation.dart';
import 'package:assisted_interpretation/widgets/alert_button.dart';
import 'package:assisted_interpretation/widgets/rounded_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String mode = "text";

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 6),
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
                SizedBox(height: 24),
                Expanded(child: TranslationScreen()),
                Center(
                  child: ModeSelectionWheel(
                    (String _mode) => setState(() => mode = _mode),
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
