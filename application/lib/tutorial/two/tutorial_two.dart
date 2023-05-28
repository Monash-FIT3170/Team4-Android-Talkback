import 'package:application/tutorial/two/module/go_back.dart';
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
            const ElevatedButton(
              onPressed: null,
              child: Text("Scrolling Module"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("Explore Menu Module"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("Adjust Slide Module"),
            ),
          ],
        ),
      ),
    );
  }
}
