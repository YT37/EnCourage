import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/braid/display.dart';
import 'package:flutter/material.dart';

class BrailleDisplay extends StatelessWidget {
  final BrailleData data;

  BrailleDisplay(this.data);

  Widget drawCell({BuildContext context, List cell, String repr = ""}) {
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
                height: 12.getHeight(context),
                width: 12.getHeight(context),
                decoration: BoxDecoration(
                  color: cell[2 * x + y] == 1 ? Colors.black : Colors.white,
                  border: Border.all(color: Colors.black),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3.getHeight(context)),
        Text(
          repr,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            data.cells.length,
            (int index) => drawCell(
              context: context,
              cell: data.cells[index],
              repr: index < data.repr.length ? data.repr[index] : "",
            ),
          ),
        ),
      ),
    );
  }
}
