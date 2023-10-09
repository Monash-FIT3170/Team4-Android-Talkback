import 'package:application/tutorial/five/module/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Challenge extends StatefulWidget {
  const Challenge({Key? key}) : super(key: key);

  @override
  State<Challenge> createState() => _Challenge();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _Challenge extends State<Challenge> with WidgetsBindingObserver {
  String introSpeech =
      """Welcome to the first challenge of lesson five. You will recieve a 
      notification from Ricky. 
      You will have to do the following:

      Navigate to the notification drawer by draging both fingers from the 
      top to the bottom of the screen.
      Then swipe right till you hear Ricky's notification.
      Return to the challenge and select the number from her notification.
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

    LocalNotification.initialize(context, flutterLocalNotificationsPlugin);

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
    } else if (isFeedbackSpeech1) {
      setState(() {
        isFeedbackSpeech1 = false;
        isFeedbackSpeech2 = true;
      });
    } else if (isFeedbackSpeech2) {
      setState(() {
        isFeedbackSpeech2 = false;
        isFeedbackSpeech3 = true;
      });
    } else if (isFeedbackSpeech3) {
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
                      LocalNotification.challengeOneNotification(
                          title: "Hi, its Ricky",
                          body: "My secret number is 3170!",
                          flutterLocalNotificationsPlugin:
                              flutterLocalNotificationsPlugin);
                    }
                    return Column(
                      children: [
                        const SizedBox(), //,
                        //Text(introSpeech), // Display the speech content
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
        ])));
  }
}
