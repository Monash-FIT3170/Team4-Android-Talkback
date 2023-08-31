import 'dart:async';
import 'dart:developer';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class GoHome extends _GoHome {
  const GoHome({super.key})
      : super(
      instruction:
      "Welcome. In this module, you will learn how to return to the home screen from inside an application. To perform do this, perform a swipe up then left gesture. Once complete, open the recents menu by swiping left then up. From the recents menu, return to the tutorial by double tapping the app. You may now start.",
      nextSubmodule: const GoHome2());
}

class GoHome2 extends _GoHome {
  const GoHome2({super.key})
      : super(
      instruction:
      "Good job! This gesture is useful as it allows you to return to the home screen at anytime, no matter where you are. Now do it again, remember: the gesture is swipe up then left. Return to the tutorial through the recents menu just like before. You may now start.",
      nextSubmodule: const GoHome3());
}

class GoHome3 extends _GoHome {
  const GoHome3({super.key})
      : super(
      instruction:
      "Nice work! You have navigated back to the tutorial. You have now learnt how to use the go to home screen gesture.",
      nextSubmodule: null);
}



class _GoHome extends StatefulWidget {
  final String instruction;
  final _GoHome? nextSubmodule;

  const _GoHome(
      {super.key,
        required this.instruction,
        required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _GoHomeSubmoduleState();
  }
}

class _GoHomeSubmoduleState extends State<_GoHome> {
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
      Timer(Duration(seconds: 10), () {
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
          title: const Text('Go Home'),
        ),
        body: Center(
            child: Column(children: [
              InstructionsCard(instruction: widget.instruction),
            ])));
  }
}
