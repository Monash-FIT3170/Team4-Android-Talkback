import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OpenNotification extends StatefulWidget {
  const OpenNotification({Key? key}) : super(key: key);

  @override
  State<OpenNotification> createState() => _OpenNotification();
}

class _OpenNotification extends State<OpenNotification> with WidgetsBindingObserver {
  String introSpeech =
  """
      Welcome. In this module, you will learn how to open your notification panel. Notifications are a way of letting you know that something new has happened. This is useful so you do not miss anything that might be worth your immediate attention. Notifications will appear on your device whether you are using an application or not. There are two ways to do this. First, open the notification panel by swiping down with two fingers from the top of your screen. Once you opened the notification panel, Talkback will start talking for a few seconds. Please wait until Talkback is done then follow the next instruction. You may now start.
      """;
  String feedbackSpeech1 =
  """
  Good job. You have opened the notification panel. Now try to close it by doing the same gesture but this time, start from the bottom of the notification tray and swipe up with two fingers.
      """;
  String feedbackSpeech2 =
  """
  Well done. The notification panel has been closed. Let's try to open it one more time. This time, open it by swiping right, then down in a single motion with one finger. Once again, please wait until Talkback is done, then follow the next instruction.
      """;
  String feedbackSpeech3 =
  """
  Excellent. Now close it again by swiping up from the bottom of the notification tray with two fingers
      """;
  String endSpeech =
  """
  Well done! You now know how to open and close your notification panel. The notification panel can also be used to perform many shortcuts. For example, connecting to wifi and bluetooth. You have completed the lesson. Double tap to return to the lesson page.
      """;
  bool isIntro = true;
  bool isFeedbackSpeech1 = false;
  bool isFeedbackSpeech2 = false;
  bool isFeedbackSpeech3 = false;
  bool isEnd = false;

  FlutterTts? flutterTts;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initilizing tts engine
    _initTextToSpeech().then((value) {
      flutterTts = value;
      _speakLines(flutterTts!, introSpeech);
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

  @override
  void dispose() {
    flutterTts!.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      changeStage();
    }
  }

  void changeStage() {
    if (isIntro) {
      setState(() {
        isIntro = false;
        isFeedbackSpeech1 = true;
      });
    }
    else if (isFeedbackSpeech1) {
      setState(() {
        isFeedbackSpeech1 = false;
        isFeedbackSpeech2 = true;
      });
    }
    else if (isFeedbackSpeech2) {
      setState(() {
        isFeedbackSpeech2 = false;
        isFeedbackSpeech3 = true;
      });
    }
    else if (isFeedbackSpeech3) {
      setState(() {
        isFeedbackSpeech3 = false;
        isEnd = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // This reads instructions and checks for successful
                        // execution of said instructions.
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            _speakLines(snapshot.data!, introSpeech);
                          }
                          return Column(
                            children: const [
                              SizedBox()//,
                              //Text(introSpeech), // Display the speech content
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                if (isFeedbackSpeech1)
                  FutureBuilder<FlutterTts>(
                      future: _initTextToSpeech(),
                      builder: (context, snapshot) {
                        // This reads instructions and checks for successful
                        // execution of said instructions.
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            _speakLines(snapshot.data!, feedbackSpeech1);
                          }
                          return Column(
                            children: const [
                              SizedBox(),
                              //Text(feedbackSpeech1), // Display the speech content
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
                else if (isFeedbackSpeech2)
                  FutureBuilder<FlutterTts>(
                      future: _initTextToSpeech(),
                      builder: (context, snapshot) {
                        // This reads instructions and checks for successful
                        // execution of said instructions.
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            _speakLines(snapshot.data!, feedbackSpeech2);
                          }
                          return Column(
                            children: [
                              const SizedBox(),
                              Text(feedbackSpeech2), // Display the speech content
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
                else if (isFeedbackSpeech3)
                  FutureBuilder<FlutterTts>(
                      future: _initTextToSpeech(),
                      builder: (context, snapshot) {
                        // This reads instructions and checks for successful
                        // execution of said instructions.
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            _speakLines(snapshot.data!, feedbackSpeech3);
                          }
                          return Column(
                            children: [
                              const SizedBox(),
                              Text(feedbackSpeech3), // Display the speech content
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })
                else if (isEnd)
                  FutureBuilder<FlutterTts>(
                      future: _initTextToSpeech(),
                      builder: (context, snapshot) {
                        // This reads instructions and checks for successful
                        // execution of said instructions.
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            _speakLines(snapshot.data!, endSpeech);
                          }
                          return Column(
                            children: [
                              const SizedBox(),
                              Text(endSpeech), // Display the speech content
                            ],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
              ],
            )));
  }
}
