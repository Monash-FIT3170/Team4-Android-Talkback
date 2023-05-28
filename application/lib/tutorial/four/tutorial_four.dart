import 'package:application/tutorial/four/module/start_stop_media.dart';
import 'package:flutter/material.dart';

class TutorialFour extends StatelessWidget {
  const TutorialFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial 4"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StartStopMedia()),
                );
              },
              child: const Text("Start and Stop Media"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("Media Volume Control"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("End of Lesson Challenge"),
            ),
          ],
        ),
      ),
    );
  }
}
