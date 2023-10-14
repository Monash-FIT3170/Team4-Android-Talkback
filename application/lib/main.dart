import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:app_settings/app_settings.dart';

import 'package:application/routes.dart';
import 'package:application/tutorial/two/tutorial_two.dart';
import 'package:application/tutorial/three/tutorial_three.dart';
import 'package:application/tutorial/four/tutorial_four.dart';
import 'package:application/tutorial/five/tutorial_five.dart';
import 'package:application/tutorial/six/tutorial_six.dart';
import 'package:application/tutorial/seven/tutorial_seven.dart';
import 'package:application/tutorial/eight/tutorial_eight.dart';
import 'package:application/progression_tracker.dart';
import 'package:application/sandbox_mode.dart';
import 'package:application/gesture_game.dart';
import 'package:application/soundboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
          Locale('ar'), // Arabic
          Locale('zh', 'CN'), // Simplified Chinese
          Locale('ru'), // Russian
          Locale('hi'), // Hindi
          Locale('pt'), // Portuguese
          Locale('bn'), // Bengali
          Locale('ja'), // Japanese
          Locale('vi'), // Vietnamese
          Locale('tr'), // Turkish
          Locale('arz'), // Egyptian Arabic
          Locale('de'), // German
          Locale('id'), // Indonesian
          Locale('mr'), // Marathi
          Locale('pcm'), // Nigerian Pidgin
          Locale('te'), // Telugu
          Locale('ur'), // Urdu
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
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
          Routes.tutorialFive: (context) => const TutorialFive(),
          Routes.tutorialSix: (context) => tutorialSix,
          Routes.tutorialSeven: (context) => tutorialSeven,
          Routes.tutorialEight: (context) => tutorialEight,
          Routes.sandBox: (context) => const SandBox(),
          Routes.gestures: (context) => const GestureMiniGame(),
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
    bool screenReaderIsEnabled = MediaQuery.of(context).accessibleNavigation;

    return Scaffold(
      appBar: AppBar(
        title: Text(title).tr(),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!screenReaderIsEnabled)
            if (Platform.isAndroid)
              ElevatedButton(
                  onPressed: () => AppSettings.openAppSettings(
                      type: AppSettingsType.accessibility),
                  child: const Text('Enable Talkback'))
            else if (Platform.isIOS)
              const Text(
                  'You should enable VoiceOver in your settings to best use this app'),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["2"]), routeName: Routes.tutorialTwo),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["3"]),
              routeName: Routes.tutorialThree),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["4"]),
              routeName: Routes.tutorialFour),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["5"]),
              routeName: Routes.tutorialFive),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["6"]), routeName: Routes.tutorialSix),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["7"]),
              routeName: Routes.tutorialSeven),
          MainMenuTutorialButton(
              title: 'tutorial'.tr(args: ["8"]),
              routeName: Routes.tutorialEight),
          MainMenuTutorialButton(
              title: "sandbox".tr(), routeName: Routes.sandBox),
          MainMenuTutorialButton(
              title: "gesture_minigame".tr(), routeName: Routes.gestures),
          MainMenuTutorialButton(
              title: "soundboard".tr(), routeName: Routes.soundBoard)
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tutorials',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Progression',
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: ((index) {
          switch (index) {
            case 0:
              // Main tutorials page, already here!
              break;
            case 1:
              // Progression tracker
              Navigator.pushNamed(context, Routes.progression);
          }
        }),
      ),
    );
  }
}
