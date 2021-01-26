import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignScreen extends StatefulWidget {
  final String url;
  final String text;

  SignScreen({@required this.text, @required this.url});

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("SignUs Translation"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 36),
                child: Text(
                  "ASL Translation for\n\"${widget.text}\"",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  child: playerController != null
                      ? VideoPlayer(
                          playerController,
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
