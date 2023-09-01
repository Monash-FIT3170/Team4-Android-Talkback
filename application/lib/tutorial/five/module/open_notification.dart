import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OpenNotification extends StatefulWidget {
  const OpenNotification({Key? key}) : super(key: key);
  State<OpenNotification> createState() => _OpenNotification();
}

class _OpenNotification extends State<OpenNotification>
    with WidgetsBindingObserver {
      String intro= "Welcome to this module to to open notifications you will have to swipe down with two fingers";
      String intro2= "Swipe right and then down";

      bool openNot1 = true; // Change Var name acc to tut
      bool openNot2 = false; // Change Var name acc to tut
      FlutterTts? flutterTts;

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initilizing tts engine
    _initTextToSpeech().then((value) {
      flutterTts = value;
      _speakLines(flutterTts!, intro);
    });
  }
Future<FlutterTts> _initTextToSpeech() async {
    String lang = 'en-US';
    double narrationSpeed = 0.45;

    FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage(lang);
    flutterTts.setSpeechRate(narrationSpeed);
    return flutterTts;
  }

  void _speakLines(FlutterTts flutterTts, String message) async {
    String line =
        message.replaceAll('\n', ' '); // Multi line str into str array

    flutterTts.speak(line);
  }

  void _resetTts() async {
    await flutterTts!.stop();
    flutterTts = null;
  }

  @override
  void dispose() {
    flutterTts!.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state != AppLifecycleState.resumed) {
      return;
    }

    changeStage();
  }

  void changeStage() {
    if (openNot1) {
      setState(() {
        openNot1 = false;
        openNot2 = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("OpenNotification"),
      ),
      // Body
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          // All the elements of the page
          children: [
            if (openNot1)
              // This speaks the intro
              FutureBuilder<FlutterTts>(
                  future: _initTextToSpeech(),
                  builder: (context, snapshot) {
                    // This reades instructions and checks for successfull
                    // execution of said instructions.
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _speakLines(snapshot.data!, intro);
                      }
                      return const SizedBox();
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            if (openNot2)
             FutureBuilder<FlutterTts>(
                  future: _initTextToSpeech(),
                  builder: (context, snapshot) {
                    // This reades instructions and checks for successfull
                    // execution of said instructions.
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _speakLines(snapshot.data!, intro2);
                      }
                      return const SizedBox();
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ]
    )));
  }
}
