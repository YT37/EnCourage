import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignDisplay extends StatelessWidget {
  final List<dynamic> signs;
  final List<dynamic> captions;

  const SignDisplay({
    super.key,
    required this.signs,
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
            signs.length,
            (index) {
              final String sign = signs[index];
              final String caption = captions[index];

              print(sign);

              return Column(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(sign),
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
