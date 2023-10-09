import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Tutorial4ChallengePage extends StatefulWidget {
  const Tutorial4ChallengePage({super.key});

  @override
  State<Tutorial4ChallengePage> createState() => _Tutorial4ChallengePageState();
}

class _Tutorial4ChallengePageState extends State<Tutorial4ChallengePage> {
  bool _hasSpokenIntro = false;
  final bool _hasSpokenPause = false;
  final bool _hasSpokenOutro = false;

  final FlutterTts tts = FlutterTts();

  final videoPlayerController = VideoPlayerController.asset(
    'assets/video_test.mp4',
  );

  late final chewieController = ChewieController(
    videoPlayerController: videoPlayerController,
    autoPlay: true,
    looping: true,
    draggableProgressBar: true,
    allowFullScreen: false,
    allowMuting: false,
    autoInitialize: true,
    hideControlsTimer: const Duration(seconds: 10),
    showOptions: false,
    showControlsOnInitialize: false,
  );
  late final playerWidget = Chewie(
    controller: chewieController,
  );

  tutorial4ChallengePageState() async {
    tts.setLanguage("en-US");
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    await playerWidget.controller.videoPlayerController.initialize();
  }

  Future<void> _speakIntro() async {
    // var content = await rootBundle.load("assets/media_sound.mp3");
    // final directory = await getApplicationDocumentsDirectory();
    // var file = File("${directory.path}/media_sound.mp3");
    // file.writeAsBytesSync(content.buffer.asUint8List());
    // await player.setFilePath(file.path);

    await tts.speak(
        "In this challenge, you'll be presented an article with an embedded video already playing. To complete the challenge, pause the video, then replay it. You may now start.");
  }

  void checkPause() {
    if (!playerWidget.controller.videoPlayerController.value.isPlaying) {
      // _speakOutro();
      Timer(const Duration(seconds: 15), () {
        Navigator.pop(context);
      });
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
        title: const Text("Tutorial 4 Challenge"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text(
                'The Different Memory Storage Areas of the Brain',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Saturday 15th July, 2042',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Author: Billy Eggman',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Within the cerebral cortex, the frontal and temporal lobes are heavily involved in explicit/declarative memory processes. Episodic memories tent to be stored in the frontal lobe (particularly the pre-frontal cortex) and temporal lobe. The same can be assumed with semantic memories. Components of our memories such as visuals and sounds are stored in areas throughout the cerebral cortex. Sound is sotred in the temporal lobe, while visuals in the occipital lobe.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'The hippocampus (in temporal lobe) consolidates memories, turning short term memories into long term declarative memories; semantic and episodic. It also has roles in emotional memory due to its proximity to the amygdala, and spatial memory.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'The amygdala (in temporal lobe) is involved in emotional memory, and links emotions and emotional responses (such as fear and aggression) to declarative memories. This helps us remember experiences by the emotion we felt during its formation. Also involved in the formation of procedural memories.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: playerWidget,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                'The cerebellum is involved in motor learning and the memory of conditioned reflexes. It\'s involved in implicit memory such as procedural memories that require movement. Also has a role in spatial navigation.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Finally, language is stored in Broca's area in the left frontal lobe, and memory for pictures are stored in the occipital lobe.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ]),
        ),
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
