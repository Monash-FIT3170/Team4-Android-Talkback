import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// This SoundBoard currently has 6 identical buttons that all plays the exact same sound
// It uses the audio players package to play a mp3 file when the button is pressed

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SoundBoard(),
//     );
//   }
// }

// SoundBoard StatefulWidget
class SoundBoard extends StatefulWidget {
  const SoundBoard({Key? key}) : super(key: key);

  // Creates an instance of the SoundBoard state
  @override
  _SoundBoardState createState() => _SoundBoardState();
}

// State class for the SoundBoard widget
class _SoundBoardState extends State<SoundBoard> {
  // Declare an AudioPlayer instance to handle audio playback
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    // Initialize the AudioPlayer instance
    audioPlayer = AudioPlayer();
  }

  // Method to play the audio file
  void playSound() async {
    //CHANGE AUDIO HERE IN SOUNDS FOLDER
    //await audioPlayer.play('sounds/test_audio.mp3', isLocal: true);
  }

  // The build method returns a widget tree for the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar top of the screen
      appBar: AppBar(
        title: Text('SoundBoard Minigame'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          // Generates 6 buttons in the grid    - NO of buttons can be changed here
          children: List.generate(6, (index) {
            return ElevatedButton(
              // When pushed play mp3 file
              onPressed: playSound,
              // Can change name of button here right now it is just button 1,2,3...
              child: Text('Button ${index + 1}'),
            );
          }),
        ),
      ),
    );
  }
}
