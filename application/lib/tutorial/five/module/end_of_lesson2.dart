import 'package:application/tutorial/five/module/notification2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Challenge2 extends StatefulWidget {
  const Challenge2({Key? key}) : super(key: key);

  @override
  State<Challenge2> createState() => _Challenge2();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _Challenge2 extends State<Challenge2> with WidgetsBindingObserver {
  String introSpeech = """Congratulatinos on completing the previous challenge. 
      Welcome to challenge two. In this challenge you'll perform a 
      series of task. First go to the home screen and back to this app to recieve
      your next task.
      """;
  String middleSpeech =
      """Welcome back, now a new message will be sent from billy. Open the 
      notification to hear your next task.
      """;
  String billiesMessage =
      """Hello, it's billy. Complete this challenge by interacting with this 
      message in the notification pannel.
      """;
  String endSpeech =
      """Congatulations you have completed tutorial 5. Click the button to return to the modules.
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

    LocalNotification2.initialize(context, flutterLocalNotificationsPlugin);

    WidgetsBinding.instance.addObserver(this);

    // Initilizing tts engine
    _initTextToSpeech().then((value) {
      flutterTts = value;
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
                  }
                  return const Column(
                    children: [
                      SizedBox() //,
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
                    _speakLines(snapshot.data!, middleSpeech);
                    LocalNotification2.challengeOneNotification(
                        title: "Billy's message",
                        body:
                            "Hello it's Billy. Complete this challenge by clicking on this notification.",
                        flutterLocalNotificationsPlugin:
                            flutterLocalNotificationsPlugin);
                  }
                  return const Column(
                    children: [
                      SizedBox(),
                      // Text(middleSpeech), // Display the speech content
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })
      ],
    )));
  }
}
