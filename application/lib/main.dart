import 'package:application/routes.dart';
import 'package:application/tutorial/six/tutorial_six.dart';
import 'package:flutter/material.dart';
import 'package:application/tutorial/two/tutorial_two.dart';
import 'package:application/tutorial/three/tutorial_three.dart';
import 'package:application/tutorial/four/tutorial_four.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teach Me Talkback',
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
  final String title = 'Tutorials';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MainMenuTutorialButton(title: 'Tutorial 1', routeName: null),
            MainMenuTutorialButton(
                title: 'Tutorial 2', routeName: Routes.tutorialTwo),
            MainMenuTutorialButton(
                title: 'Tutorial 3', routeName: Routes.tutorialThree),
            MainMenuTutorialButton(
                title: 'Tutorial 4', routeName: Routes.tutorialFour),
            // MainMenuTutorialButton(
            //     title: 'Tutorial 5', routeName: Routes.tutorialFive),
            MainMenuTutorialButton(
                title: 'Tutorial 6', routeName: Routes.tutorialSix),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tutorials',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gesture),
            label: 'Gesture',
            backgroundColor: Colors.blue,
          )
        ],
        onTap: ((index) {
          String path = Routes.home;
          switch (index) {
            case 0:
              // home
              break;
            case 1:
              // gestures
              break;
          }
          Navigator.pushNamed(context, path);
        }),
      ),
    );
  }
}
