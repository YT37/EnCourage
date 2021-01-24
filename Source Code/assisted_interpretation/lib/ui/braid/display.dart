import 'package:assisted_interpretation/config/constant.dart';
import 'package:flutter/material.dart';

class BrailleData {
  final List cells;
  final List repr;

  BrailleData({this.cells, this.repr = const []});

  static BrailleData fromMap(Map map) {
    return BrailleData(
      cells: map["cells"],
      repr: map["repr"] != null ? map["repr"] : [],
    );
  }
}

class BrailleScreen extends StatefulWidget {
  final BrailleData data;
  final String text;

  BrailleScreen({@required this.data, @required this.text});

  @override
  _BrailleScreenState createState() => _BrailleScreenState();
}

class _BrailleScreenState extends State<BrailleScreen> {
  Widget drawCell({List cell, String repr = ""}) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          ...List.generate(
            3,
            (int x) => Row(
              children: List.generate(
                2,
                (int y) => Container(
                  margin: EdgeInsets.all(4),
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: cell[2 * x + y] == 1 ? Colors.black : Colors.white,
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Text(
            repr,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kUIAccent,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("BrAid Text Translation"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Braille Translation for \"${widget.text}\"",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                direction: Axis.vertical,
                children: List.generate(
                  widget.data.cells.length,
                  (int index) => drawCell(
                    cell: widget.data.cells[index],
                    repr: widget.data.repr.length > index
                        ? widget.data.repr[index][1]
                        : "",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
