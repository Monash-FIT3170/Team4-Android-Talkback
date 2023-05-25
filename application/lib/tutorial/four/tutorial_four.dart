import 'package:application/tutorial/four/module/volume_media_control.dart';
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
              onPressed: null,
              child: Text("Start and Stop Media"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MediaVolumeControlPage()),
                );
              },
              child: Text("Media Volume Control"),
            ),
            ElevatedButton(
              onPressed: null,
              child: Text("End of Lesson Challenge"),
            ),
          ],
        ),
      ),
    );
  }
}
