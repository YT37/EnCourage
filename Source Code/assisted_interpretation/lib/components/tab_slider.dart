import 'package:assisted_interpretation/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabSlider extends StatefulWidget {
  final parent;
  final List<String> tabNames;
  final List<Function> screens;
  final double width;
  final double height;
  final Duration animDuration;
  final Color textColor;
  final bool isDynamic;
  final EdgeInsets margin;
  final Function onChanged;
  ValueNotifier<int> currentIndex;

  TabSlider(
      {@required this.parent,
      @required this.tabNames,
      @required this.screens,
      this.width = 200,
      this.height = 30,
      this.animDuration = const Duration(milliseconds: 300),
      this.textColor = kUIColor,
      this.isDynamic = false,
      this.currentIndex,
      this.margin = const EdgeInsets.only(top: 12, bottom: 24),
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
        margin: widget.margin,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: widget.height,
            width: sliderWidth,
            decoration: BoxDecoration(
              color: kUIAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(children: [
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
                        child: Text(
                          widget.tabNames[index],
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: getHeight(context, 16),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: widget.animDuration,
                curve: Curves.easeInOut,
                left: widget.currentIndex.value *
                    (sliderWidth / widget.tabNames.length),
                child: Container(
                  width: sliderWidth / widget.tabNames.length,
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kUIColor.withOpacity(0.3),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
