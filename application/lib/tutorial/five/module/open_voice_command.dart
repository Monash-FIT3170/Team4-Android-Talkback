import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';

class OpenVoiceCommand extends StatefulWidget {
  const OpenVoiceCommand({Key? key}) : super(key: key);

  @override
  State<OpenVoiceCommand> createState() => _OpenVoiceCommand();
}

class _OpenVoiceCommand extends State<OpenVoiceCommand>
    with WidgetsBindingObserver {
  String introMessage = """
    Open Voice Commands using gestures.
    Welcome, in this module you will learn to enabel voice commands.
    To do this, you need to perform a swipe right then up gestrue in one motion. 
    When prompted for a voice command, say "HELP". 
    This will take you to the voice command help section.
    Return to the tutorial whenever you want by going back. 
    Good luck!
    """;

  String instructionMessage = """
    Well Done!
    Next we will put some voice commands into action.
    Now that you know some voice commands, we will show you how to increase Talk
    Backs reading speed using voice command.
    """;

  String fasterSpeechTitle = "Swipe right.";

  String fasterSpeechOne = """
    To make me speak faster swipe right then up with one finger to open voice command
    gain. Do this gesture, then say speak faster. And move to the next element when 
    you are done. Good luck!
    """;

  String fasterSpeechTwo = """
    I am now speaking faster. When you have compleated listening to this text go 
    to the next element and select the button to finish the module.
    """;

  bool isIntro = true;
  bool isFasterSpee = false;
  FlutterTts? flutterTts;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initilizing tts engine
    _initTextToSpeech().then((value) {
      flutterTts = value;
      _speakLines(flutterTts!, introMessage);
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
    if (isIntro) {
      setState(() {
        isIntro = false;
        isFasterSpee = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title
      appBar: AppBar(
        title: const Text("Open Voice Commands"),
      ),

      // Body
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          // All the elements of the page
          children: [
            if (isIntro)
              // This speaks the intro
              FutureBuilder<FlutterTts>(
                  future: _initTextToSpeech(),
                  builder: (context, snapshot) {
                    // This reades instructions and checks for successfull
                    // execution of said instructions.
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _speakLines(snapshot.data!, introMessage);
                      }
                      return const SizedBox();
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            if (isIntro)
              // This is the instructions for the above intro
              const Text(
                'Swipe right then up\nTo open voice commands',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            if (isFasterSpee)
              // This speaks the intro
              FutureBuilder<FlutterTts>(
                  future: _initTextToSpeech(),
                  builder: (context, snapshot) {
                    // This reades instructions and checks for successfull
                    // execution of said instructions.
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _speakLines(snapshot.data!, instructionMessage);
                      }
                      return const SizedBox();
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            if (isFasterSpee) Text(fasterSpeechTitle),
            if (isFasterSpee) Text(fasterSpeechOne),
            if (isFasterSpee) Text(fasterSpeechTwo)
          ],
        ),
      ),
    );
  }
}

/*
child: FutureBuilder<FlutterTts>(
                  future: _initTextToSpeech(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        _speakLines(snapshot.data!, introMessage);
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                    return Container(); // Return a placeholder widget here if needed
                  },
                ),
                */


// Intor of module
            /*
              FutureBuilder<FlutterTts>(
                future: _initTextToSpeech(),
                builder: (context, snapshot) {
                  // This reades instructions and checks for successfull
                  // execution of said instructions.
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      _speakLines(snapshot.data!, introMessage);
                    }

                    return Expanded(
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onPanUpdate: (details) {
                              if (details.delta.dx > 5 &&
                                  details.delta.dy < 5) {
                                _openVoiceCmdSuccess();
                              }
                            },
                            child: Container()));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
                  */