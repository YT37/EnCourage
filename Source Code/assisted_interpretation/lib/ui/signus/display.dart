import 'package:assisted_interpretation/config/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignScreen extends StatefulWidget {
  final String url;
  final String word;

  SignScreen({@required this.word, @required this.url});

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();

    listener = () {
      setState(() {});
    };

    createVideo();
    playerController.play();
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);

    super.deactivate();
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network("${widget.url}.webm")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: kUIAccent,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("Sign For ${widget.word}"),
          centerTitle: true,
        ),
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: (playerController != null
                  ? VideoPlayer(
                      playerController,
                    )
                  : Container()),
            ),
          ),
        ),
      ),
    );
  }
}
