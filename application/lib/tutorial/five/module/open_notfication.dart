import 'dart:async';
import 'dart:developer';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class OpenNotification extends _OpenNotification {
  const OpenNotification({super.key})
      : super(
      instruction:
      "Welcome. In this module, you will learn how to open your notification panel. Notifications are a way of letting you know that something new has happened. This is useful so you do not miss anything that might be worth your immediate attention. Notifications will appear on your device whether you are using an application or not. There are two ways to do this. First, open the notification panel by swiping down with two fingers from the top of your screen. Then swipe back up from the bottom of your screen to close the panel",
      nextSubmodule: const OpenNotification2());
}

class OpenNotification2 extends _OpenNotification {
  const OpenNotification2({super.key})
      : super(
      instruction:
      "Well done. The notification panel has been closed. Let's try to open it one more time. This time, open it by swiping right, then down in a single motion with one finger. Once done, you can close it again by swiping up from the bottom of the notification tray with two fingers",
      nextSubmodule: const OpenNotification3());
}

class OpenNotification3 extends _OpenNotification {
  const OpenNotification3({super.key})
      : super(
      instruction:
      "Well done! You now know how to open and close your notification panel. The notification panel can also be used to perform many shortcuts. For example, connecting to wifi and bluetooth. You have completed the lesson.",
      nextSubmodule: null);
}



class _OpenNotification extends StatefulWidget {
  final String instruction;
  final _OpenNotification? nextSubmodule;

  const _OpenNotification(
      {super.key,
        required this.instruction,
        required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _OpenNotificationSubmoduleState();
  }
}

class _OpenNotificationSubmoduleState extends State<_OpenNotification> {
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
      Timer(Duration(seconds: 20), () {
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
          title: const Text('Open Notification'),
        ),
        body: Center(
            child: Column(children: [
              InstructionsCard(instruction: widget.instruction),
            ])));
  }
}