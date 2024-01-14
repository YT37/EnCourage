import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '/config/constants.dart';
import '/models/response.dart';
import '/services/api.dart';
import '/tools/functions.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    final RxBool translating = false.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FROM.value,
              style: context.textTheme.titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                CONTROLLER.value.clear();
                RESPONSE.value = Response(response: {}, status: Status.EMPTY);
              },
              child: Icon(
                Icons.clear,
                color: Colors.grey[400],
                size: 20,
              ),
            ),
          ],
        ),
        Obx(
          () => TextField(
            maxLines: 3,
            controller: CONTROLLER.value,
            style: context.textTheme.titleLarge,
            keyboardType: TextInputType.text,
            decoration:
                const InputDecoration(hintText: "Type the text to translate"),
            onSubmitted: (_) async {
              if (CONTROLLER.value.text != "") {
                translating.value = true;
                RESPONSE.value = await API.translate(CONTROLLER.value.text);
                translating.value = false;
              }
            },
          ),
        ),
        const Divider(height: 15),
        const SizedBox(height: 15),
        Obx(
          () => Text(
            TO.value,
            style: context.textTheme.titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          child: Obx(
            () {
              if (RESPONSE.value.status == Status.OK) {
                return display(RESPONSE.value.response);
              } else if (RESPONSE.value.status == Status.EMPTY) {
                return Center(
                  child: Text(
                    translating.value
                        ? "Translating..."
                        : "Converted Text will appear here",
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "An Error Occured, Please Try Again...",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
