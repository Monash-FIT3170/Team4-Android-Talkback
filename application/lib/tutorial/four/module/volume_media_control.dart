import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

class MediaVolumeControlPage extends StatefulWidget {
  const MediaVolumeControlPage({super.key});

  @override
  State<MediaVolumeControlPage> createState() => _MediaVolumeControlPageState();
}

class _MediaVolumeControlPageState extends State<MediaVolumeControlPage> {
  bool _hasSpokenIntro = false; // Whether the intro has been spoken yet
  bool _hasSpokenIncreaseVolume = false;
  bool _hasSpokenDecreaseVolume = false;
  double _volume = 50; // Current volume
  final FlutterTts tts = FlutterTts();
  final AudioPlayer player = AudioPlayer();

  mediaVolumeControlPageState() async {
    tts.setLanguage("en-US");
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
  }

  Future<void> _speakIntro() async {
    // SemanticsService.announce(
    //   "In this tutorial, you will be learning how to control media volume sliders to adjust volume. To start, find the play button then double tap to play the music.",
    //   TextDirection.ltr,
    // );
    // await player.setUrl("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    var content = await rootBundle.load("assets/media_sound.mp3");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/media_sound.mp3");
    file.writeAsBytesSync(content.buffer.asUint8List());

    await player.setFilePath(file.path);
    await tts.speak(
        "In this tutorial, you will be learning how to control media volume sliders to adjust volume. To start, find the play button then double tap to play the music.");
  }

  void _speakIncreaseVolume() {
    // SemanticsService.announce(
    //   "Great job! Now, go back to the slider and increase the media's volume above 75 by swiping up.",
    //   TextDirection.ltr,
    // );
    tts.stop();
    tts.speak(
        "Great job! Now, go back to the slider and increase the media's volume above 75 by swiping up.");
  }

  void _speakDecreaseVolume() {
    // SemanticsService.announce(
    //   "Current volume is set above 75. Now that you've learned how to increase the volume, we will try decreasing the volume below 25. To decrease the volume, swipe down.",
    //   TextDirection.ltr,
    // );
    tts.stop();
    tts.speak(
        "Current volume is set above 75. Now that you've learned how to increase the volume, we will try decreasing the volume below 25. To decrease the volume, swipe down.");
  }

  Future<void> _speakOutro() async {
    // SemanticsService.announce(
    //   "Current volume is set below 25. Congratulations on completing this lesson. Sending you back to the lesson page.",
    //   TextDirection.ltr,
    // );
    tts.stop();
    tts.speak(
        "Current volume is set below 25. Congratulations on completing this lesson. Sending you back to the lesson page.");
    await tts.awaitSpeakCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    // Speak intro if first time opening this page.
    if (!_hasSpokenIntro) {
      _speakIntro();
      _hasSpokenIntro = true;
    }

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable back button
          title: const Text("Media Volume Control Module"),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.all(25),
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/media_music_bg.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 20,
              label: _volume.round().toString(),
              onChanged: (double value) async {
                double vol = value / 100;
                await player.setVolume(vol);
                if (value >= 75 && _hasSpokenIncreaseVolume) {
                  _speakDecreaseVolume();
                  _hasSpokenDecreaseVolume = true;
                }
                if (value <= 25 && _hasSpokenDecreaseVolume) {
                  await _speakOutro();
                  await player.pause();
                  Navigator.pop(context);
                }

                setState(() {
                  _volume = value;
                });
              },
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  player.play();
                  if (_hasSpokenIntro && !_hasSpokenIncreaseVolume) {
                    _speakIncreaseVolume();
                    _hasSpokenIncreaseVolume = true;
                  }
                },
                child: const Icon(Icons.play_arrow, semanticLabel: 'Play'),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () {
                  player.pause();
                },
                child: const Icon(
                  Icons.pause,
                  semanticLabel: 'Pause',
                ),
              ),
            ]),
          ]),
        ));
  }
}
