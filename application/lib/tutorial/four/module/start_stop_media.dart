import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StartStopMediaPage extends StatefulWidget {
  const StartStopMediaPage({super.key});

  @override
  State<StartStopMediaPage> createState() => _StartStopMediaPageState();
}

class _StartStopMediaPageState extends State<StartStopMediaPage> {
  bool _hasSpokenIntro = false;
  bool _hasSpokenPause = false;
  bool _hasSpokenOutro = false;

  final FlutterTts tts = FlutterTts();

  final videoPlayerController = VideoPlayerController.asset(
    'assets/video_test.mp4',
  );

  late final chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: false,
    looping: true,
    draggableProgressBar: true,
    allowFullScreen: false,
    allowMuting: false,
    autoInitialize: true,
    hideControlsTimer: Duration(seconds: 10),
    showOptions: false,
    showControlsOnInitialize: false,
  );
  late final playerWidget = Chewie(
    controller: chewieController,
  );

  StartStopMediaPageState() async {
    tts.setLanguage("en-US");
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
  }

  Future<void> _speakIntro() async {
    // var content = await rootBundle.load("assets/media_sound.mp3");
    // final directory = await getApplicationDocumentsDirectory();
    // var file = File("${directory.path}/media_sound.mp3");
    // file.writeAsBytesSync(content.buffer.asUint8List());
    // await player.setFilePath(file.path);

    await tts.speak(
        "In this tutorial, you will be learning how to start and stop a video. To start, double tap your screen to bring up the media controller and find the play button. Double tap to start playing the video.");
  }

  void _speakPauseVideo() {
    tts.stop();
    tts.speak(
        "Great job! You have played the video. Now, we will try to pause the video. To pause the video, bring up the media controller and find the pause button. Double tap on the button to pause the video.");
  }

  Future<void> _speakOutro() async {
    tts.stop();
    tts.speak(
        "Great job! You have paused the video. Congratulations on completing this lesson on how to start and stop a video. Sending you back to the lesson page.");
    Timer(Duration(seconds: 15), () {
      Navigator.pop(context);
    });
    await tts.awaitSpeakCompletion(true);
  }

  void checkPause() {
    if (playerWidget.controller.videoPlayerController.value.isPlaying &&
        !_hasSpokenPause &&
        _hasSpokenIntro) {
      _speakPauseVideo();
      _hasSpokenPause = true;
    } else if (!playerWidget.controller.videoPlayerController.value.isPlaying &&
        _hasSpokenPause &&
        !_hasSpokenOutro) {
      _speakOutro();
      _hasSpokenOutro = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Speak intro if first time opening this page.
    if (!_hasSpokenIntro) {
      _speakIntro();
      _hasSpokenIntro = true;
    }
    playerWidget.controller.videoPlayerController.addListener(checkPause);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Start Stop Media Module"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 640,
            width: 360,
            child: playerWidget,
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    playerWidget.controller.videoPlayerController.dispose();
    playerWidget.controller.dispose();
    tts.stop();
  }
}
