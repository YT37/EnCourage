import 'package:assisted_interpretation/config/extensions.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModeSelectionWheel extends StatefulWidget {
  Function onChangeMode;
  Function onTapSelected;

  ModeSelectionWheel({this.onChangeMode, this.onTapSelected});

  @override
  _ModeSelectionWheelState createState() => _ModeSelectionWheelState();
}

class _ModeSelectionWheelState extends State<ModeSelectionWheel> {
  List<List<double>> path;

  final Map<String, IconData> data = {
    "image": Icons.camera_alt,
    "text": Icons.edit,
    "speech": Icons.mic,
  };

  List<WheelBubble> bubbles;
  String selected;

  void select(WheelBubble bubble) {
    if (selected != bubble.label) {
      int movement;

      for (int i = 0; i < path.length; i++) {
        if (path[i][0] == bubble.top && path[i][1] == bubble.left)
          movement = 1 - i;
      }

      for (WheelBubble bubble in bubbles)
        for (int i = 0; i < path.length; i++) {
          if (path[i][0] == bubble.top && path[i][1] == bubble.left) {
            int newIndex = i + movement;

            if (movement == 1 && newIndex > path.length - 1)
              newIndex = 0;
            else if (movement == -1 && newIndex < 0) newIndex = path.length - 1;

            if (newIndex == 1) selected = bubble.label;

            bubble.isSelected = newIndex == 1;
            bubble.animateTo(path[newIndex][0], path[newIndex][1]);

            break;
          }
        }

      if (widget.onChangeMode != null) widget.onChangeMode(selected);
    } else {
      if (widget.onTapSelected != null) widget.onTapSelected(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      path = [
        [50.getHeight(context), 0],
        [10.getHeight(context), 60.getHeight(context)],
        [50.getHeight(context), 130.getHeight(context)],
      ];

      bubbles = List.generate(
        path.length,
        (int index) => WheelBubble(
          top: path[index][0],
          left: path[index][1],
          parent: this,
          isSelected: index == 1,
          label: data.keys.toList()[index],
          icon: data.values.toList()[index],
        ),
      );

      selected = bubbles[1].label;
    }

    return Container(
      height: 100.getHeight(context),
      width: 202,
      child: Stack(
        children: bubbles,
      ),
    );
  }
}

// ignore: must_be_immutable
class WheelBubble extends StatefulWidget {
  double top;
  double left;
  final _ModeSelectionWheelState parent;
  bool isSelected;
  final String label;
  final IconData icon;

  final GlobalKey key = GlobalKey();

  WheelBubble(
      {this.top,
      this.left,
      this.parent,
      this.isSelected,
      this.label,
      this.icon});

  void animateTo(double nTop, double nLeft) {
    top = nTop;
    left = nLeft;
    // ignore: invalid_use_of_protected_member
    key.currentState.setState(() {});
  }

  @override
  _WheelBubbleState createState() => _WheelBubbleState(key);
}

class _WheelBubbleState extends State<WheelBubble> {
  _WheelBubbleState(Key key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: widget.top,
      left: widget.left,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () => widget.parent.select(this.widget),
        child: Container(
          height: (widget.isSelected ? 60 : 50).getHeight(context),
          width: (widget.isSelected ? 60 : 50).getHeight(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.9)
                    : Theme.of(context).primaryColor.withOpacity(0.7),
                widget.isSelected
                    ? Color(0xff43bfb2).withOpacity(0.85)
                    : Color(0xff43bfb2).withOpacity(0.55),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.35, widget.isSelected ? 0.825 : 0.925],
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.icon,
            size: widget.isSelected ? 28 : 24,
            color: Theme.of(context).accentColor.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
