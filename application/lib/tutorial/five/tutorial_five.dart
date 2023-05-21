import 'package:application/tutorial/five/module/open_notification.dart';
import 'package:flutter/material.dart';

class TutorialFive extends StatelessWidget {
  const TutorialFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial 5"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ElevatedButton(
              onPressed: null,
              child: Text("Open Recent Apps"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("Go To Home Screen"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OpenNotification()),
                );
              },
              child: const Text("Open Notification"),
            ),

            const ElevatedButton(
              onPressed: null,
              child: Text("Open Talkback Menu"),
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text("Open Voice Command"),
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
