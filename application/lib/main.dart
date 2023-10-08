import 'package:application/routes.dart';
import 'package:application/soundboard.dart';
import 'package:application/tutorial/six/tutorial_six.dart';
import 'package:flutter/material.dart';
import 'package:application/tutorial/two/tutorial_two.dart';
import 'package:application/tutorial/three/tutorial_three.dart';
import 'package:application/tutorial/four/tutorial_four.dart';
import 'package:application/progression_tracker.dart';
import 'package:application/sandbox_mode.dart';
import 'package:application/gesture_game.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('ar'),
          Locale('zh', 'CN'),
          Locale('ru'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teach Me Talkback',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.tutorialTwo: (context) => tutorialTwo,
          Routes.tutorialThree: (context) => tutorialThree,
          Routes.tutorialFour: (context) => tutorialFour,
          Routes.tutorialSix: (context) => tutorialSix,
          Routes.sandBox: (context) => const SandBox(),
          Routes.gestures: (context) => GestureMiniGame(),
          Routes.soundBoard: (context) => const SoundBoard(),
          Routes.progression: (context) => const ProgressionTracker(),
        });
  }
}

class MainMenuTutorialButton extends StatelessWidget {
  final String title;
  final String routeName;
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  MainMenuTutorialButton(
      {required this.title, required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: () => {Navigator.pushNamed(context, routeName)},
      child: Text(title),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title = 'tutorials';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title).tr(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainMenuTutorialButton(
                  title: 'tutorial'.tr(args: ["2"]),
                  routeName: Routes.tutorialTwo),
              MainMenuTutorialButton(
                  title: 'tutorial'.tr(args: ["3"]),
                  routeName: Routes.tutorialThree),
              MainMenuTutorialButton(
                  title: 'tutorial'.tr(args: ["4"]),
                  routeName: Routes.tutorialFour),
              // MainMenuTutorialButton(
              //     title: 'Tutorial 5', routeName: Routes.tutorialFive),
              MainMenuTutorialButton(
                  title: 'tutorial'.tr(args: ["6"]),
                  routeName: Routes.tutorialSix),
              MainMenuTutorialButton(
                  title: "sandbox".tr(), routeName: Routes.sandBox),
              MainMenuTutorialButton(
                  title: "gesture_minigame".tr(), routeName: Routes.gestures),
              MainMenuTutorialButton(
                  title: "soundboard".tr(), routeName: Routes.soundBoard)
            ],
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
