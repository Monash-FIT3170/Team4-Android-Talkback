import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class OpenRecent extends StatelessWidget {
  const OpenRecent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SemanticsService.announce(
        "To open recent apps, swipe left then up gesture in one motion",
        TextDirection.ltr);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Open Recent Module"),
      ),
    );
  }
}
