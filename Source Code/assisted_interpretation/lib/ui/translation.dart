import 'package:flutter/material.dart';

class TranslationScreen extends StatefulWidget {
  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  List translation = [
    [
      [0, 0, 0, 0, 0, 1],
      'Capital'
    ],
    [
      [1, 1, 0, 0, 1, 0],
      'h'
    ],
    [
      [1, 0, 0, 0, 1, 0],
      'e'
    ],
    [
      [1, 1, 1, 0, 0, 0],
      'l'
    ],
    [
      [1, 1, 1, 0, 0, 0],
      'l'
    ],
    [
      [1, 0, 1, 0, 1, 0],
      'o'
    ],
    [
      [0, 0, 0, 0, 0, 0],
      'Space'
    ],
    [
      [0, 0, 0, 0, 0, 1],
      'Capital'
    ],
    [
      [0, 1, 0, 1, 1, 1],
      'w'
    ],
    [
      [1, 0, 1, 0, 1, 0],
      'o'
    ],
    [
      [1, 1, 1, 0, 1, 0],
      'r'
    ],
    [
      [1, 1, 1, 0, 0, 0],
      'l'
    ],
    [
      [1, 0, 0, 1, 1, 0],
      'd'
    ],
    [
      [0, 1, 1, 0, 1, 0],
      '!'
    ]
  ];

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
                margin: const EdgeInsets.all(2),
                height: 9.5,
                width: 9.5,
                decoration: BoxDecoration(
                  color: cell[2 * x + y] == 1 ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3),
        Text(
          repr,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "English",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.swap_horiz,
                  size: 26,
                  color: Theme.of(context).accentColor.withOpacity(0.9),
                ),
              ),
              Text(
                "Braille",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              )
            ],
          ),
          Divider(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "English",
                style: TextStyle(color: Colors.grey[400]),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.clear, color: Colors.grey[400]),
              ),
            ],
          ),
          TextField(
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(fontWeight: FontWeight.w500),
            cursorColor: Colors.grey[400],
            cursorHeight: 30,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Type the text to translate",
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 22),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          Divider(),
          SizedBox(height: 24),
          Text(
            "Braille",
            style: TextStyle(color: Colors.grey[400]),
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 9.5,
                  runSpacing: 10,
                  children: List.generate(
                    translation.length,
                    (int index) => drawCell(
                        cell: translation[index][0],
                        repr: translation[index][1]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
