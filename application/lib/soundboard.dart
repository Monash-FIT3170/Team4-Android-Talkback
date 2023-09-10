import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Soundboard(),
    );
  }
}

class Soundboard extends StatefulWidget {
  @override
  _SoundboardState createState() => _SoundboardState();
}

class _SoundboardState extends State<Soundboard> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  void playSound() async {
    
    await audioPlayer.play('assets/your_audio_file.mp3', isLocal: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soundboard Minigame'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return ElevatedButton(
              onPressed: playSound,
              child: Text('Button ${index + 1}'),
            );
          }),
        ),
      ),
    );
  }
}
