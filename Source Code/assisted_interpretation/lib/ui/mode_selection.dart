import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModeSelectionWheel extends StatefulWidget {
  Function onChangeMode;

  ModeSelectionWheel(this.onChangeMode);

  @override
  _ModeSelectionWheelState createState() => _ModeSelectionWheelState();
}

class _ModeSelectionWheelState extends State<ModeSelectionWheel> {
  final List<List<double>> path = [
    [50.0, 0.0],
    [10.0, 60.0],
    [50.0, 130.0],
  ];

  final Map<String, IconData> data = {
    "image": Icons.camera_alt,
    "text": Icons.edit,
    "speech": Icons.mic,
  };

  List<WheelBubble> bubbles;
  String selected;

  @override
  void initState() {
    super.initState();

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

  void select(WheelBubble bubble) {
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

    widget.onChangeMode(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 180,
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
      duration: Duration(milliseconds: 150),
      child: GestureDetector(
        onTap: () => widget.parent.select(this.widget),
        child: CircleAvatar(
          radius: widget.isSelected ? 30 : 25,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.75),
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
