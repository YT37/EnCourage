import 'package:assisted_interpretation/config/extensions.dart';
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
    return Column(
      children: [
        ...List.generate(
          3,
          (int x) => Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              2,
              (int y) => Container(
                margin: const EdgeInsets.all(4),
                height: 12.getHeight(context),
                width: 12,
                decoration: BoxDecoration(
                  color: cell[2 * x + y] == 1 ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.getHeight(context)),
        Text(
          repr,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("BrAid Translation"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  "Braille Translation for\n\"${widget.text}\"",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: List.generate(
                        widget.data.cells.length,
                        (int index) {
                          return drawCell(
                            cell: widget.data.cells[index],
                            repr: widget.data.repr.length > index
                                ? widget.data.repr[index]
                                : "",
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
