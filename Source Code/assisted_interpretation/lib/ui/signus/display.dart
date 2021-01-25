import 'package:assisted_interpretation/config/constant.dart';
// import 'package:chewie/chewie.dart';
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
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
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
          title: Text("Sign For ${widget.word}"),
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

// class SignScreen extends StatefulWidget {
//   final String url;
//   final String word;

//   SignScreen({@required this.word, @required this.url});

//   @override
//   _SignScreenState createState() => _SignScreenState();
// }

// class _SignScreenState extends State<SignScreen> {
//   // ignore: unused_field
//   TargetPlatform _platform;

//   VideoPlayerController _videoPlayerController1;
//   VideoPlayerController _videoPlayerController2;

//   ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _videoPlayerController2.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   Future<void> initializePlayer() async {
//     _videoPlayerController1 = VideoPlayerController.network(
//         'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
//     await _videoPlayerController1.initialize();
//     _videoPlayerController2 = VideoPlayerController.network(
//         'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
//     await _videoPlayerController2.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       autoPlay: true,
//       looping: true,
//       // Try playing around with some of these other options:

//       showControls: false,
//       materialProgressColors: ChewieProgressColors(
//         playedColor: Colors.red,
//         handleColor: Colors.blue,
//         backgroundColor: Colors.grey,
//         bufferedColor: Colors.lightGreen,
//       ),
//       placeholder: Container(
//         color: Colors.grey,
//       ),
//       autoInitialize: true,
//     );
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.word),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: _chewieController != null &&
//                       _chewieController.videoPlayerController.value.initialized
//                   ? Chewie(
//                       controller: _chewieController,
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 20),
//                         Text('Loading'),
//                       ],
//                     ),
//             ),
//           ),
//           MaterialButton(
//             onPressed: () {
//               _chewieController.enterFullScreen();
//             },
//             child: const Text('Fullscreen'),
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: MaterialButton(
//                   onPressed: () {
//                     setState(() {
//                       _chewieController.dispose();
//                       _videoPlayerController1.pause();
//                       _videoPlayerController1.seekTo(
//                         const Duration(),
//                       );
//                       _chewieController = ChewieController(
//                         videoPlayerController: _videoPlayerController1,
//                         autoPlay: true,
//                         looping: true,
//                       );
//                     });
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text("Landscape Video"),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: MaterialButton(
//                   onPressed: () {
//                     setState(() {
//                       _chewieController.dispose();
//                       _videoPlayerController2.pause();
//                       _videoPlayerController2.seekTo(
//                         const Duration(),
//                       );
//                       _chewieController = ChewieController(
//                         videoPlayerController: _videoPlayerController2,
//                         autoPlay: true,
//                         looping: true,
//                       );
//                     });
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text("Portrait Video"),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: MaterialButton(
//                   onPressed: () {
//                     setState(() {
//                       _platform = TargetPlatform.android;
//                     });
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text("Android controls"),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: MaterialButton(
//                   onPressed: () {
//                     setState(() {
//                       _platform = TargetPlatform.iOS;
//                     });
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Text("iOS controls"),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
