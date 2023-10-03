import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';

FlutterTts flutterTts = FlutterTts();

enum GestureType {
  DoubleTap,
  LongPress,
  VerticalSwipe,
  HorizontalSwipe,
  SingleTap
}

class GestureMiniGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GestureMiniGameState();
}

class GestureMiniGameState extends State<GestureMiniGame> {
  GestureType currentGesture = GestureType.DoubleTap;
  String instructionText = 'Game Starting...';
  bool isGameInProgress = false;
  int numRounds = 0;
  int highScore = 0;
  List<GestureType> gestureSequence = [];
  int sequenceIdx = 0;
  int sequenceLength = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Mini-Game")),
      // body as gesture detector so that it detects gestures on the screen not the child components
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () => checkGesture(GestureType.DoubleTap),
        onLongPress: () => checkGesture(GestureType.LongPress),
        onVerticalDragEnd: (_) => checkGesture(GestureType.VerticalSwipe),
        onHorizontalDragEnd: (_) => checkGesture(GestureType.HorizontalSwipe),
        onTap: () => checkGesture(GestureType.SingleTap),
        child: Center(
          // check if game in progress
          child: isGameInProgress
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Highscore: $highScore',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Round: $numRounds',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: stopGame,
                child: Text(
                  "Stop Game",
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Change button color
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    instructionText,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.green, // Change text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
              : Column(
            // if false show start game button
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Highscore: $highScore',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,),),
              ElevatedButton(
                onPressed: startGame,
                child: Text(
                  "Start Game",
                  style: TextStyle(fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Change button color
                ),
              ),
              SizedBox(height: 20),                  ],
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
        instructionText = "Follow the sequence: " +
            gestureSequence.map((g) => getGestureInstructionText(g)).join(", ");
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
      case GestureType.DoubleTap:
        return "Double Tap";
      case GestureType.LongPress:
        return "Long Press";
      case GestureType.VerticalSwipe:
        return "Vertical Swipe";
      case GestureType.HorizontalSwipe:
        return "Horizontal Swipe";
      case GestureType.SingleTap:
        return "Single Tap";
      default:
        return "Get Ready!";
    }
  }

  Future<void> checkGesture(GestureType detectedGesture) async {
    if (isGameInProgress && detectedGesture == gestureSequence[sequenceIdx]) {
      sequenceIdx++;
    } else if (detectedGesture != gestureSequence[sequenceIdx]) {
      // Incorrect gesture
      await flutterTts.speak(
          "$detectedGesture Wrong Gesture. Try again. expecting ${gestureSequence[sequenceIdx]}");
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

void main() {
  runApp(MaterialApp(
    home: GestureMiniGame(),
  ));
}