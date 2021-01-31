import 'package:assisted_interpretation/config/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignData {
  final String url;

  SignData({this.url});

  static SignData fromMap(Map map) {
    return SignData(
      url: map["url"],
    );
  }
}

// ignore: must_be_immutable
class SignDisplay extends StatefulWidget {
  final SignData data;

  SignDisplay(this.data);

  @override
  _SignDisplayState createState() => _SignDisplayState();
}

class _SignDisplayState extends State<SignDisplay> {
  VideoPlayerController controller;
  dynamic listener;

  @override
  void initState() {
    super.initState();
    if (mounted) listener = () => setState(() {});

    if (widget.data.url != "") {
      print("${widget.data.url}.webm");
      if (controller == null) {
        controller = VideoPlayerController.network("${widget.data.url}.webm")
          ..addListener(listener)
          ..setLooping(true)
          ..initialize()
          ..play();
      } else {
        if (controller.value.isPlaying) {
          controller.pause();
        } else {
          controller.initialize();
          controller.play();
        }
      }

      controller.play();
    }
  }

  @override
  void deactivate() {
    if (widget.data.url != "") {
      controller.setVolume(0.0);
      controller.removeListener(listener);
    }

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.url);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: controller != null
          ? VideoPlayer(controller)
          : Text(
              "An Error occurred. Please Try Again",
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.getHeight(context),
                  ),
            ),
    );
  }
}
