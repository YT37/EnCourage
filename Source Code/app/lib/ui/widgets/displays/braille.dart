import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrailleDisplay extends StatelessWidget {
  final List<dynamic> cells;
  final List<dynamic> captions;

  const BrailleDisplay({
    super.key,
    required this.cells,
    required this.captions,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            cells.length,
            (index) {
              final dynamic cell = cells[index];
              final String caption = captions[index];

              return Column(
                children: [
                  ...List.generate(
                    3,
                    (x) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        2,
                        (y) => Container(
                          margin: const EdgeInsets.all(5),
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: cell![2 * x + y] == 1
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    caption,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
