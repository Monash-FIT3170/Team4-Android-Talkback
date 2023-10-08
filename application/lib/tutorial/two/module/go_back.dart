import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  const GoBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Go Back Module"),
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            ListTile(
              title: Focus(
                autofocus: true,
                child: Text(
                    'To go back, swipe down then left with one finger in a continuous action. If multi-gestures are enabled, swipe with two fingers from the left or right side of the screen.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
