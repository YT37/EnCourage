import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/api/signus.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/translation/display/sign.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'display/braille.dart';

// ignore: must_be_immutable
class ImageTranslation extends StatefulWidget {
  final String translateFrom;
  final String translateTo;

  ImageTranslation({this.translateFrom, this.translateTo});

  _ImageTranslationState state;

  @override
  _ImageTranslationState createState() {
    state = _ImageTranslationState();
    return state;
  }

  // TODO FIXME: The method 'recognize' was called on null.
  void onTapSelected(String mode) => state.recognize();

  /// TODO FIXME: The method 'clear' was called on null.
  void clearResponse() => state.clear();
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
        String text = "How are you doing";

        setState(() {
          response = null;
          translating = true;

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
      }
    });
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
                : "Click the Camera icon below to Take a Picture",
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
