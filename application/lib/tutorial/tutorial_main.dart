import 'package:flutter/material.dart';
import 'package:application/tutorial/two/tutorial_two.dart';

class TutorialMain extends StatelessWidget {
  const TutorialMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // page with title and back button, buttons for each tutorial
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorials"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TutorialTwo()),
                );
              },
              child: const Text("Tutorial 2"),
            ),
          ],
        ),
      ),
    );
  }
}
