import 'package:assisted_interpretation/constant.dart';
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
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kUIAccent,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.popAndPushNamed(context, "/home"),
          ),
          title: Text("Sign For ${widget.word.capitalize()}"),
          centerTitle: true,
        ),
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}
