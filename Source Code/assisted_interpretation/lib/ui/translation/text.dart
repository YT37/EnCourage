import 'package:assisted_interpretation/api/braid.dart';
import 'package:assisted_interpretation/api/response.dart';
import 'package:assisted_interpretation/api/signus.dart';
import 'package:assisted_interpretation/config/extensions.dart';
import 'package:assisted_interpretation/ui/translation/display/sign.dart';
import 'package:flutter/material.dart';

import 'display/braille.dart';

// ignore: must_be_immutable
class TextTranslation extends StatefulWidget {
  final String translateFrom;
  final String translateTo;

  TextTranslation({this.translateFrom, this.translateTo});

  _TextTranslationState state;

  void onTapSelected(String mode) {}

  // TODO FIXME: The method 'clear' was called on null.
  void clearResponse() => state.clear();

  @override
  _TextTranslationState createState() {
    state = _TextTranslationState();
    return state;
  }
}

class _TextTranslationState extends State<TextTranslation> {
  final TextEditingController _controller = TextEditingController();

  Response response;
  bool translating = false;

  void clear() {
    setState(() {
      _controller.clear();
      response = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            if (_controller.text != "")
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
        TextField(
          controller: _controller,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontWeight: FontWeight.w500),
          cursorColor: Colors.grey[400],
          cursorHeight: 30.getHeight(context),
          maxLines: 3,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Type the text to translate",
            hintStyle: Theme.of(context).textTheme.headline3.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.getHeight(context),
                ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onSubmitted: (String text) {
            response = null;

            if (text != "") {
              translating = true;

              widget.translateTo == "Braille"
                  ? BrAidApi.getCellsWithRepr(_controller.text)
                      .then(
                        (value) => setState(() => response = value),
                      )
                      .whenComplete(
                        () => setState(() => translating = false),
                      )
                  : SignUsApi.getSigns(_controller.text)
                      .then(
                        (value) => setState(() => response = value),
                      )
                      .whenComplete(
                        () => setState(() => translating = false),
                      );
            }

            setState(() {});
          },
        ),
        Divider(
          height: 18.getHeight(context),
        ),
        SizedBox(
          height: 15.getHeight(context),
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
