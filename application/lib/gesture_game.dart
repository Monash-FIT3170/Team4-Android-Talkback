import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:easy_localization/easy_localization.dart';

FlutterTts flutterTts = FlutterTts();

enum GestureType {
  doubleTap,
  longPress,
  verticalSwipe,
  horizontalSwipe,
  singleTap
}

class GestureMiniGame extends StatefulWidget {
  const GestureMiniGame({super.key});

  @override
  State<StatefulWidget> createState() => GestureMiniGameState();
}

class GestureMiniGameState extends State<GestureMiniGame> {
  GestureType currentGesture = GestureType.doubleTap;
  String instructionText = 'game_starting';
  bool isGameInProgress = false;
  int numRounds = 0;
  int highScore = 0;
  List<GestureType> gestureSequence = [];
  int sequenceIdx = 0;
  int sequenceLength = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('gesture_minigame').tr()),
      // body as gesture detector so that it detects gestures on the screen not the child components
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () => checkGesture(GestureType.doubleTap),
        onLongPress: () => checkGesture(GestureType.longPress),
        onVerticalDragEnd: (_) => checkGesture(GestureType.verticalSwipe),
        onHorizontalDragEnd: (_) => checkGesture(GestureType.horizontalSwipe),
        onTap: () => checkGesture(GestureType.singleTap),
        child: Center(
          // check if game in progress
          child: isGameInProgress
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'gesture_minigame_highscore'.tr(args: ['$highScore']),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'gesture_minigame_round'.tr(args: ['$numRounds']),
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: stopGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Change button color
                        ),
                        child: const Text(
                          'gesture_minigame_stop_game',
                          style: TextStyle(fontSize: 24),
                        ).tr()),
                    SizedBox(height: 20),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          instructionText,
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.green, // Change text color
                            fontWeight: FontWeight.bold,
                          ),
                        ).tr(),
                      ),
                    ),
                  ],
                )
              : Column(
                  // if false show start game button
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'gesture_minigame_highscore',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(args: ['$highScore']),
                    ElevatedButton(
                        onPressed: startGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Change button color
                        ),
                        child: const Text(
                          'gesture_minigame_start_game',
                          style: TextStyle(fontSize: 24),
                        ).tr()),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }

  void startGame() async {
    setState(() {
      isGameInProgress = true;
      sequenceIdx = 0;
      sequenceLength = 1;
      getNextGesture();
    });
  }

  Future<void> stopGame() async {
    setState(() {
      isGameInProgress = false;
      numRounds = 0;
      sequenceLength = 1;
    });
  }

  Future<void> getNextGesture() async {
    if (sequenceIdx == 0) {
      setState(() {
        gestureSequence.clear();
        for (int i = 0; i < sequenceLength; i++) {
          gestureSequence.add(getRandomGesture());
        }
        instructionText = 'gesture_minigame_follow_sequence'.tr() +
            gestureSequence
                .map((g) => getGestureInstructionText(g).tr())
                .join(", ");
      });
      await flutterTts.speak(instructionText);
    }
  }

  GestureType getRandomGesture() {
    var random = Random();
    GestureType temp =
        GestureType.values[random.nextInt(GestureType.values.length)];
    while (temp == currentGesture) {
      random = Random();
      temp = GestureType.values[random.nextInt(GestureType.values.length)];
    }
    return temp;
  }

  String getGestureInstructionText(GestureType gesture) {
    switch (gesture) {
      case GestureType.doubleTap:
        return 'double_tap';
      case GestureType.longPress:
        return 'long_press';
      case GestureType.verticalSwipe:
        return 'vertical_swipe';
      case GestureType.horizontalSwipe:
        return 'horizontal_swipe';
      case GestureType.singleTap:
        return 'single_tap';
      default:
        return 'gesture_minigame_get_ready';
    }
  }

  Future<void> checkGesture(GestureType detectedGesture) async {
    if (isGameInProgress && detectedGesture == gestureSequence[sequenceIdx]) {
      sequenceIdx++;
    } else if (detectedGesture != gestureSequence[sequenceIdx]) {
      // Incorrect gesture
      await flutterTts.speak('$detectedGesture' +
          'gesture_minigame_wrong_gesture'.tr() +
          ' ${gestureSequence[sequenceIdx]}');
      sequenceIdx = 0;
    }
    if (sequenceIdx == gestureSequence.length) {
      // Level complete
      numRounds += 1;
      sequenceLength++; // Increase the sequence length
      sequenceIdx = 0;

      if (numRounds > highScore) {
        highScore = numRounds;
      }

      getNextGesture(); // Load the next sequence
    }
  }
}
