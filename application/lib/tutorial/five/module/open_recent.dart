import 'dart:async';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class OpenRecent extends _OpenRecent {
  const OpenRecent({super.key})
      : super(
      instruction:
      "Welcome. In this module, you will learn how to open the recents menu and open recent apps. The recents menu is a handy way to quickly switch between frequently used apps. This can be done in two different ways. Firstly, perform a swipe left then up gesture in one motion. Once completed, select and double tap the tutorial to return to the lesson. You may now start.",
      nextSubmodule: const OpenRecent2());
}

class OpenRecent2 extends _OpenRecent {
  const OpenRecent2({super.key})
      : super(
      instruction:
      "Try to open the recents menu using the recents button in the bottom right or bottom left corner of your phone. You can double tap this button to open the recent apps menu. If your device does not support a recents button, or you are unsure, perform a swipe left, then up gesture again to open the recents menu. Then return to the tutorial once again. You may now start.",
      nextSubmodule: const OpenRecent3());
}

class OpenRecent3 extends _OpenRecent {
  const OpenRecent3({super.key})
      : super(
      instruction:
      "Well done! You have completed the open recent apps module.",
      nextSubmodule: null);
}



class _OpenRecent extends StatefulWidget {
  final String instruction;
  final _OpenRecent? nextSubmodule;

  const _OpenRecent(
      {super.key,
        required this.instruction,
        required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _OpenRecentSubmoduleState();
  }
}

class _OpenRecentSubmoduleState extends State<_OpenRecent> {
  late AppLifecycleListener listener = AppLifecycleListener(
      onResume: () {
        if (widget.nextSubmodule != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => widget.nextSubmodule!));
        }
      }
  );

  @override
  initState() {
    super.initState();
    listener;
    if (widget.nextSubmodule == null) {
      Timer(const Duration(seconds: 6), () {
        Navigator.popUntil(context, ModalRoute.withName(Routes.tutorialFive));
      });
    }

  }

  @override
  void dispose() {
    super.dispose();
    listener.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Open Recent'),
        ),
        body: Center(
            child: Column(children: [
              InstructionsCard(instruction: widget.instruction),
            ])));
  }
}
