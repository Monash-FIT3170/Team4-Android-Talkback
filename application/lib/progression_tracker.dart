import 'package:application/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressionTracker extends StatefulWidget {
  const ProgressionTracker({Key? key}) : super(key: key);

  @override
  ProgressionTrackerState createState() => ProgressionTrackerState();
}

class ProgressionTrackerState extends State<ProgressionTracker> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  bool exploreMenuByTouchModule = false;
  bool scrollingModule = false;
  bool goBackModule = false;
  bool adjustSliderModule = false;
  bool tutorialTwoChallenge = false;
  bool adjustReadingControlsModule = false;
  bool jumpTextModule = false;
  bool jumpControlsModule = false;
  bool jumpHeadersModule = false;
  bool jumpLinksModule = false;
  bool tutorialThreeChallenge = false;
  bool startStopMediaModule = false;
  bool mediaVolumeControlModule = false;
  bool tutorialFourChallenge = false;
  bool openRecentAppsModule = false;
  bool goToHomeScreenModule = false;
  bool openNotificationsModule = false;
  bool openTalkbackMenuModule = false;
  bool openVoiceCommandModule = false;
  bool tutorialFiveChallenge = false;
  bool virtualKeyboardModule = false;
  bool tutorialSixChallenge = false;
  bool calculatorAppModule = false;
  bool voiceRecorderAppModule = false;

  @override
  void initState() {
    super.initState();
    loadActivityStatus();
  }

  Future<void> loadActivityStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      exploreMenuByTouchModule =
          prefs.getBool('exploreMenuByTouchModule') ?? false;
      scrollingModule = prefs.getBool('scrollingModule') ?? false;
      goBackModule = prefs.getBool('goBackModule') ?? false;
      adjustSliderModule = prefs.getBool('adjustSliderModule') ?? false;
      tutorialTwoChallenge = prefs.getBool('tutorialTwoChallenge') ?? false;
      adjustReadingControlsModule =
          prefs.getBool('adjustReadingControlsModule') ?? false;
      jumpTextModule = prefs.getBool('jumpTextModule') ?? false;
      jumpControlsModule = prefs.getBool('jumpControlsModule') ?? false;
      jumpHeadersModule = prefs.getBool('ExploreMenuByTouchModule') ?? false;
      jumpLinksModule = prefs.getBool('jumpLinksModule') ?? false;
      tutorialThreeChallenge = prefs.getBool('tutorialThreeChallenge') ?? false;
      startStopMediaModule = prefs.getBool('startStopMediaModule') ?? false;
      mediaVolumeControlModule =
          prefs.getBool('mediaVolumeControlModule') ?? false;
      tutorialFourChallenge = prefs.getBool('tutorialFourChallenge') ?? false;
      openRecentAppsModule = prefs.getBool('openRecentAppsModule') ?? false;
      goToHomeScreenModule = prefs.getBool('goToHomeScreenModule') ?? false;
      openNotificationsModule =
          prefs.getBool('openNotificationsModule') ?? false;
      openTalkbackMenuModule = prefs.getBool('openTalkbackMenuModule') ?? false;
      openVoiceCommandModule = prefs.getBool('openVoiceCommandModule') ?? false;
      tutorialFiveChallenge = prefs.getBool('tutorialFiveChallenge') ?? false;
      virtualKeyboardModule = prefs.getBool('virtualKeyboardModule') ?? false;
      tutorialSixChallenge = prefs.getBool('tutorialSixChallenge') ?? false;
      calculatorAppModule = prefs.getBool('calculatorAppModule') ?? false;
      voiceRecorderAppModule = prefs.getBool('voiceRecorderAppModule') ?? false;
    });
  }

  double progress(modules) {
    double total = modules.length.toDouble();
    double completed = 0;
    for (var module in modules) {
      if (module) {
        completed += 1;
      }
    }
    return completed / total;
  }

  Future<void> resetProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracker'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //     'Tutorial Two Module 1: ${exploreMenuByTouchModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Two Module 2: ${scrollingModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Two Module 3: ${goBackModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Two Module 4: ${adjustSliderModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Two Challenge: ${tutorialTwoChallenge ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Module 1: ${adjustReadingControlsModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Module 2: ${jumpTextModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Module 3: ${jumpControlsModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Module 4: ${jumpHeadersModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Module 5: ${jumpLinksModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Three Challenge: ${tutorialThreeChallenge ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Four Module 1: ${startStopMediaModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Four Module 2: ${mediaVolumeControlModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Four Challenge: ${tutorialFourChallenge ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Module 1: ${openRecentAppsModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Module 2: ${goToHomeScreenModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Module 3: ${openNotificationsModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Module 4: ${openTalkbackMenuModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Module 5: ${openVoiceCommandModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Five Challenge: ${tutorialFiveChallenge ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Six Module 1: ${virtualKeyboardModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Six Challenge: ${tutorialSixChallenge ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Seven Module 1: ${calculatorAppModule ? 'Completed' : 'Not Completed'}'),
              // Text(
              //     'Tutorial Seven Module 2: ${voiceRecorderAppModule ? 'Completed' : 'Not Completed'}'),
              //
              //
              // // PROGRESS BARS TEST
              // SizedBox(height: 20),

              Container(
                margin: EdgeInsets.all(20),
                child: CircularPercentIndicator(
                  radius: 125.0,
                  lineWidth: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    exploreMenuByTouchModule,
                    scrollingModule,
                    goBackModule,
                    adjustSliderModule,
                    tutorialTwoChallenge,
                    adjustReadingControlsModule,
                    jumpTextModule,
                    jumpControlsModule,
                    jumpHeadersModule,
                    jumpLinksModule,
                    tutorialThreeChallenge,
                    startStopMediaModule,
                    mediaVolumeControlModule,
                    tutorialFourChallenge,
                    openRecentAppsModule,
                    goToHomeScreenModule,
                    openNotificationsModule,
                    openTalkbackMenuModule,
                    openVoiceCommandModule,
                    tutorialFiveChallenge,
                    virtualKeyboardModule,
                    tutorialSixChallenge,
                    calculatorAppModule,
                    voiceRecorderAppModule,
                  ]),
                  center: Text(
                    "Total Progress:\n${(progress([
                      exploreMenuByTouchModule,
                      scrollingModule,
                      goBackModule,
                      adjustSliderModule,
                      tutorialTwoChallenge,
                      adjustReadingControlsModule,
                      jumpTextModule,
                      jumpControlsModule,
                      jumpHeadersModule,
                      jumpLinksModule,
                      tutorialThreeChallenge,
                      startStopMediaModule,
                      mediaVolumeControlModule,
                      tutorialFourChallenge,
                      openRecentAppsModule,
                      goToHomeScreenModule,
                      openNotificationsModule,
                      openTalkbackMenuModule,
                      openVoiceCommandModule,
                      tutorialFiveChallenge,
                      virtualKeyboardModule,
                      tutorialSixChallenge,
                      calculatorAppModule,
                      voiceRecorderAppModule,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 30),

              Text(
                'Tutorial 1',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    tutorialTwoChallenge, // placeholder since we havent added tut 1
                  ]),
                  center: Text(
                    "${(progress([
                      tutorialTwoChallenge, // placeholder since we havent added tut 1
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 2',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    exploreMenuByTouchModule,
                    scrollingModule,
                    goBackModule,
                    adjustSliderModule,
                    tutorialTwoChallenge,
                  ]),
                  center: Text(
                    "${(progress([
                      exploreMenuByTouchModule,
                      scrollingModule,
                      goBackModule,
                      adjustSliderModule,
                      tutorialTwoChallenge,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 3',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    adjustReadingControlsModule,
                    jumpTextModule,
                    jumpControlsModule,
                    jumpHeadersModule,
                    jumpLinksModule,
                    tutorialThreeChallenge,
                  ]),
                  center: Text(
                    "${(progress([
                      adjustReadingControlsModule,
                      jumpTextModule,
                      jumpControlsModule,
                      jumpHeadersModule,
                      jumpLinksModule,
                      tutorialThreeChallenge,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 4',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    startStopMediaModule,
                    mediaVolumeControlModule,
                    tutorialFourChallenge,
                  ]),
                  center: Text(
                    "${(progress([
                      startStopMediaModule,
                      mediaVolumeControlModule,
                      tutorialFourChallenge,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  barRadius: const Radius.circular(16),
                  progressColor: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 5',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    openRecentAppsModule,
                    goToHomeScreenModule,
                    openNotificationsModule,
                    openTalkbackMenuModule,
                    openVoiceCommandModule,
                    tutorialFiveChallenge,
                  ]),
                  center: Text(
                    "${(progress([
                      openRecentAppsModule,
                      goToHomeScreenModule,
                      openNotificationsModule,
                      openTalkbackMenuModule,
                      openVoiceCommandModule,
                      tutorialFiveChallenge,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(16),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 6',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    virtualKeyboardModule,
                    tutorialSixChallenge,
                  ]),
                  center: Text(
                    "${(progress([
                      virtualKeyboardModule,
                      tutorialSixChallenge,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(16),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Tutorial 7',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 20.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: progress([
                    calculatorAppModule,
                    voiceRecorderAppModule,
                  ]),
                  center: Text(
                    "${(progress([
                      calculatorAppModule,
                      voiceRecorderAppModule,
                    ]) * 100).toStringAsFixed(0)}%",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(16),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: () => {
                resetProgress(),
                Navigator.pushNamed(context, Routes.progression)
                },
                  child: const Text('Reset Progress'))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gesture),
            label: 'Gesture',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Progression',
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: ((index) {
          String path = Routes.home;
          switch (index) {
            case 0:
            //home
              break;
            case 1:
            // business
              break;
            case 2:
            // Progression Tracker
              path = Routes.progression;
              break;
          }
          Navigator.pushNamed(context, path);
        }),
      ),
    );
  }
}
