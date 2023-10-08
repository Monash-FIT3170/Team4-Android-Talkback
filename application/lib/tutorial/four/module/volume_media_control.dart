import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

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
    var content = await rootBundle.load("assets/media_sound.mp3");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/media_sound.mp3");
    file.writeAsBytesSync(content.buffer.asUint8List());

    await player.setFilePath(file.path);
    await tts.speak('tutorial4_intro'.tr());
  }

  void _speakIncreaseVolume() {
    tts.stop();
    tts.speak('tutorial4_increase_volume'.tr());
  }

  void _speakDecreaseVolume() {
    tts.stop();
    tts.speak('tutorial4_decrease_volume'.tr());
  }

  Future<void> _speakOutro() async {
    tts.stop();
    tts.speak('tutorial4_outro'.tr());
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
          title: const Text('tutorial4_media_volume_control_module').tr(),
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
                child: Icon(Icons.play_arrow,
                    semanticLabel: 'tutorial4_play_music'.tr()),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () {
                  player.pause();
                },
                child: Icon(
                  Icons.pause,
                  semanticLabel: 'tutorial4_pause'.tr(),
                ),
              ),
            ]),
          ]),
        ));
  }
}
