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


