import 'package:application/tutorial/two/module/adjust_slider.dart';
import 'package:application/tutorial/two/module/go_back.dart';
import 'package:application/tutorial/two/module/scroll.dart';
<<<<<<< HEAD
import 'package:application/tutorial/two/module/explore_menu.dart';
=======
import 'package:application/tutorial/two/practical/homepage.dart';
>>>>>>> b4e74ae... Add tutorial 2 practical page with slider
import 'package:flutter/material.dart';

class TutorialTwo extends StatelessWidget {
  const TutorialTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // scaffold page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GoBack()),
                );
              },
              child: const Text("Go Back Module"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScrollPage()),
                );
              },
              child: const Text("Scrolling Module"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExploreMenuPage()),
                );
              },
              child: const Text("Explore Menu Module"),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdjustSlider()),
                );
              },
              child: const Text("Adjust slide module"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text("Practical Application"),
            ),
          ],
        ),
      ),
    );
  }
}
