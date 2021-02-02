import 'package:encourage/config/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabSlider extends StatefulWidget {
  final parent;
  final List<String> tabNames;
  final List<Function> screens;
  final double width;
  final bool isDynamic;
  final Function onChanged;
  ValueNotifier<int> currentIndex;

  TabSlider(
      {@required this.parent,
      @required this.tabNames,
      @required this.screens,
      this.width = 200,
      this.isDynamic = false,
      this.currentIndex,
      this.onChanged});

  final _TabSliderState state = _TabSliderState();

  int getCurrentIndex() {
    return currentIndex.value;
  }

  @override
  _TabSliderState createState() => state;
}

class _TabSliderState extends State<TabSlider> {
  @override
  Widget build(BuildContext context) {
    double sliderWidth;
    if (widget.isDynamic)
      sliderWidth = MediaQuery.of(context).size.width * (widget.width / 411);
    else
      sliderWidth = widget.width;

    return ValueListenableBuilder<int>(
      valueListenable: widget.currentIndex,
      builder: (BuildContext context, value, child) => Container(
        margin: EdgeInsets.only(top: 12, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35.getHeight(context),
              width: sliderWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        widget.tabNames.length,
                        (index) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  widget.currentIndex.value = index;
                                  widget.onChanged == null
                                      ? widget.parent.setState(() {
                                          widget.parent.screen =
                                              widget.screens[index]();
                                        })
                                      : widget.onChanged(index);
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                widget.tabNames[index],
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: widget.currentIndex.value *
                        (sliderWidth / widget.tabNames.length),
                    child: Container(
                      width: sliderWidth / widget.tabNames.length,
                      height: 35.getHeight(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).highlightColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
