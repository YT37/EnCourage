import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> buttonsList;
  final List<Widget> otherWidgets;
  final bool isExpanded;
  final bool centerTitle;

  RoundedAlertDialog({
    @required this.title,
    this.description = "",
    this.buttonsList = const [],
    this.otherWidgets = const [],
    this.isExpanded = true,
    this.centerTitle = true,
  });

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
              style: Theme.of(context).textTheme.headline2,
            )
          : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (description != "")
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
                        child: buttonsList[index],
                      ),
              ),
            )
        ],
      ),
    );
  }
}
