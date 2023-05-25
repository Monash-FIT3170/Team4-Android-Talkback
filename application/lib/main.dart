import 'package:application/routes.dart';
import 'package:flutter/material.dart';
import 'package:application/tutorial/tutorial_main.dart';
import 'package:application/tutorial/two/tutorial_two.dart';
import 'package:application/tutorial/four/tutorial_four.dart';
import 'package:application/tutorial/five/tutorial_five.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Teach Me Talkback',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const MyHomePage(title: 'Home Page'),
          Routes.tutorials: (context) => const TutorialMain(),
          Routes.tutorialTwo: (context) => const TutorialTwo(),
          Routes.tutorialFour: (context) => const TutorialFour(),
          Routes.tutorialFive: (context) => const TutorialFive(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text('Tutorial 1'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () =>
                  {Navigator.pushNamed(context, Routes.tutorialTwo)},
              child: const Text('Tutorial 2'),
            ),
            ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text('Tutorial 3'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () =>
                  {Navigator.pushNamed(context, Routes.tutorialFour)},
              child: const Text('Tutorial 4'),
            ),
            ElevatedButton(
              style: style,
              onPressed: () =>
              {Navigator.pushNamed(context, Routes.tutorialFive)},
              child: const Text('Tutorial 5'),
            ),
            ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text('Tutorial 6'),
            ),
            ElevatedButton(
              style: style,
              onPressed: null,
              child: const Text('Tutorial 7'),
            ),
          ],
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
            label: 'Tutorials',
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
              // tutorials
              path = Routes.tutorialTwo;
              break;
          }
          Navigator.pushNamed(context, path);
        }),
      ),
    );
  }
}
