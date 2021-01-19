import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> buttonsList;
  final List<Widget> otherWidgets;
  final bool isExpanded;
  final bool centerTitle;
  final double titleSize;
  final double descriptionSize;

  RoundedAlertDialog(
      {@required this.title,
      this.description = "",
      this.buttonsList = const [],
      this.otherWidgets,
      this.isExpanded = true,
      this.centerTitle = true,
      this.titleSize = 24,
      this.descriptionSize = 14});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: title != ""
          ? Text(
              title,
              textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              style:
                  TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold),
            )
          : null,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        if (description != "")
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: descriptionSize),
          ),
        if (otherWidgets != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: otherWidgets,
          ),
        if (buttonsList.length > 0)
          Row(
            mainAxisAlignment: isExpanded
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.end,
            children: List.generate(
              buttonsList.length,
              (index) => isExpanded
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: buttonsList[index],
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: buttonsList[index]),
            ),
          )
      ]),
    );
  }
}
