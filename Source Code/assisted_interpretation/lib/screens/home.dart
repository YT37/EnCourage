import 'package:assisted_interpretation/components/alert_button.dart';
import 'package:assisted_interpretation/components/rounded_alert_dialog.dart';
import 'package:assisted_interpretation/components/tab_slider.dart';
import 'package:assisted_interpretation/constant.dart';
import 'package:assisted_interpretation/screens/braid.dart';
import 'package:assisted_interpretation/screens/signus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var slider;

  final List screens = [BrAidScreen(), SignUsScreen()];
  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;
  int toPage;

  @override
  void initState() {
    super.initState();

    slider = TabSlider(
        parent: this,
        isDynamic: true,
        currentIndex: ValueNotifier(1),
        tabNames: ["BrAid", "SignUs"],
        screens: screens.map((e) => () => e).toList(),
        onChanged: (int index) {
          setState(() {
            toPage = index;

            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          });
        },
        width: 300);
  }

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
                onPressed: () {
                  Navigator.pop(context);
                },
                title: "No",
              ),
              AlertButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                title: "Yes",
              )
            ],
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kUIColor,
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                slider,
                Expanded(
                  child: PageView(
                      onPageChanged: (int page) {
                        if (toPage != null) if (toPage != page) {
                          page = null;
                        } else {
                          toPage = null;
                        }

                        if (page != null) {
                          slider.currentIndex.value = page;
                          setState(() {
                            currentPage = page;
                          });
                        }
                      },
                      controller: _pageController,
                      children: screens.map<Widget>((e) => e).toList()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
