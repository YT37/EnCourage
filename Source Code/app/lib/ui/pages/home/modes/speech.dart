import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '/config/constants.dart';
import '/models/response.dart';
import '/services/api.dart';
import '/tools/functions.dart';

class SpeechTranslation extends StatefulWidget {
  const SpeechTranslation({super.key});

  @override
  State<SpeechTranslation> createState() => _SpeechTranslationState();
}

class _SpeechTranslationState extends State<SpeechTranslation> {
  final SpeechToText stt = SpeechToText();
  final RxBool translating = false.obs;
  final RxBool error = false.obs;

  Future<void> _initSTT() async {
    error.value = false;

    final Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.bluetooth,
      Permission.bluetoothConnect,
    ].request();

    if (statuses.values.any((status) => status != PermissionStatus.granted)) {
      error.value = true;
    } else {
      error.value = false;
    }

    await stt.initialize();
  }

  @override
  void initState() {
    super.initState();

    _initSTT();
  }

  @override
  Widget build(BuildContext context) {
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
          () {
            return TextField(
              maxLines: 3,
              controller: CONTROLLER.value,
              style: context.textTheme.titleLarge,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Tap the mic icon below to start listening.",
              ),
              onSubmitted: (_) async {
                if (CONTROLLER.value.text != "") {
                  translating.value = true;
                  RESPONSE.value = await API.translate(CONTROLLER.value.text);
                  translating.value = false;
                }
              },
            );
          },
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
              if (RESPONSE.value.status == Status.OK && !error.value) {
                return display(RESPONSE.value.response);
              } else if (RESPONSE.value.status == Status.EMPTY &&
                  !error.value) {
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
                    error.value
                        ? "Please allow microphone permission from the settings app."
                        : "An Error Occured, Please Try Again...",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: GestureDetector(
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: context.theme.colorScheme.secondary,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    color: Colors.grey,
                  ),
                ],
              ),
              child: Icon(
                Icons.mic,
                size: 50,
                color: context.theme.colorScheme.onSecondary,
              ),
            ),
            onTap: () async {
              await stt.listen(
                onResult: (result) async {
                  CONTROLLER.value.text = result.recognizedWords;

                  if (CONTROLLER.value.text != "") {
                    translating.value = true;
                    RESPONSE.value = await API.translate(CONTROLLER.value.text);
                    translating.value = false;
                  }

                  await stt.stop();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
