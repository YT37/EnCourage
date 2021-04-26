import 'package:encourage/config/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignData {
  final String url;

  SignData({required this.url});

  static SignData fromMap(Map map) => SignData(url: map["url"]);
}

// ignore: must_be_immutable
class SignDisplay extends StatefulWidget {
  final SignData data;

  SignDisplay(this.data);

  @override
  _SignDisplayState createState() => _SignDisplayState();
}

class _SignDisplayState extends State<SignDisplay> {
  VideoPlayerController? controller;
  dynamic listener;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      "${widget.data.url}.webm",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize()
      ..play();
  }

  @override
  void dispose() {
    if (widget.data.url != "") controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: controller != null
          ? VideoPlayer(controller!)
          : Text(
              "An Error occurred. Please Try Again",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 22.getHeight(context),
                  ),
            ),
    );
  }
}
