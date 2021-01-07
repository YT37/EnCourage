import 'package:assisted_interpretation/constant.dart';
import 'package:flutter/material.dart';

class BrailleScreen extends StatefulWidget {
  final List dots;
  final String word;

  BrailleScreen({@required this.dots, @required this.word});
  @override
  _BrailleScreenState createState() => _BrailleScreenState();
}

class _BrailleScreenState extends State<BrailleScreen> {
  @override
  Widget build(BuildContext context) {
    Widget drawCell(List dots) {
      return Column(
        children: List.generate(
          3,
          (int x) => Row(
            children: List.generate(
              2,
              (int y) {
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                      backgroundColor:
                          dots[2 * x + y] == 1 ? Colors.black : Colors.white,
                      radius: 4),
                );
              },
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kUIAccent,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("Braille For ${widget.word.capitalize()}"),
          centerTitle: true,
        ),
        body: Container(
          child: Wrap(
            children: widget.dots
                .map<Widget>(
                  (cell) => drawCell(cell),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
