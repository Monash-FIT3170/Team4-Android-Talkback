import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class GoHome extends StatelessWidget {
  const GoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SemanticsService.announce(
        "To return to home screen from an application, swipe up then left gesture in one motion",
        TextDirection.ltr);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Return to home screen"),
      ),
    );
  }
}
