import 'dart:async';

import 'package:encourage/api/braid.dart';
import 'package:encourage/api/response.dart';
import 'package:encourage/api/signus.dart';
import 'package:encourage/config/extensions.dart';
import 'package:encourage/ui/translation/display/sign.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'display/braille.dart';

bool doClear = false;
bool doRecognize = false;

// ignore: must_be_immutable
class ImageTranslation extends StatefulWidget {
  final String translateFrom;
  final String translateTo;

  ImageTranslation({this.translateFrom, this.translateTo});

  @override
  _ImageTranslationState createState() => _ImageTranslationState();

  void onTapSelected(String mode) => doRecognize = true;

  void clearResponse() => doClear = true;
}

class _ImageTranslationState extends State<ImageTranslation> {
  Response response;
  bool translating = false;

  String recognized = "";

  void clear() {
    setState(() {
      recognized = "";
      response = null;
    });
  }

  void recognize() {
    clear();

    final ImagePicker picker = ImagePicker();

    picker.getImage(source: ImageSource.camera).then((value) {
      PickedFile image = value;

      if (image != null) {
        setState(() => translating = true);

        Timer(Duration(seconds: 2), () {
          String text = "How are you doing";

          setState(() {
            response = null;

            recognized = text;

            widget.translateTo == "Braille"
                ? BrAidApi.getCellsWithRepr(recognized)
                    .then(
                      (value) => setState(() => response = value),
                    )
                    .whenComplete(
                      () => setState(() => translating = false),
                    )
                : SignUsApi.getSigns(recognized)
                    .then(
                      (value) => setState(() => response = value),
                    )
                    .whenComplete(
                      () => setState(() => translating = false),
                    );
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (doClear) {
      clear();
      doClear = false;
    }

    if (doRecognize) {
      recognize();
      doRecognize = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.translateFrom,
              style: TextStyle(color: Colors.grey[400]),
            ),
            if (recognized != "")
              GestureDetector(
                onTap: () => clear(),
                child: Icon(
                  Icons.clear,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
          ],
        ),
        SizedBox(
          height: 12.getHeight(context),
        ),
        Container(
          height: 75.getHeight(context),
          child: Text(
            recognized != ""
                ? recognized
                : translating
                    ? "Recognizing Text..."
                    : "Click the Camera Icon below to take a picture",
            style: Theme.of(context).textTheme.headline3.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.getHeight(context),
                ),
          ),
        ),
        Divider(
          height: 48.getHeight(context),
        ),
        Text(
          widget.translateTo,
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(
          height: 12.getHeight(context),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          child: response != null
              ? widget.translateTo == "Braille"
                  ? BrailleDisplay(
                      BrailleData.fromMap(response.response),
                    )
                  : SignDisplay(
                      SignData.fromMap(response.response),
                    )
              : Text(
                  translating
                      ? "Translating..."
                      : "Converted Text will appear here",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.getHeight(context),
                      ),
                ),
        ),
      ],
    );
  }
}
