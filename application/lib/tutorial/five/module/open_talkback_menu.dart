import 'dart:async';
import 'dart:developer';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class OpenTalkback extends _OpenTalkback {
  const OpenTalkback({super.key})
      : super(
      instruction:
      "Welcome. In this module, you will learn how to open the Talkback Menu. The Talkback menu allows you use commands to read, edit text, control speech output, change Talkback settings, and more. To open the menu, perform a swipe up, then right gesture in one motion. Or a swipe down, then right gesture. You may now start.",
      nextSubmodule: const OpenTalkback2());
}

class OpenTalkback2 extends _OpenTalkback {
  const OpenTalkback2({super.key})
      : super(
      instruction:
      "Well done! You now know how to open and close the Talkback Menu. Once again, to do this you have to swipe up, or a swipe down gesture then swipe right immediately. You have completed the lesson.",
      nextSubmodule: null);
}

class _OpenTalkback extends StatefulWidget {
  final String instruction;
  final _OpenTalkback? nextSubmodule;

  const _OpenTalkback(
      {super.key,
        required this.instruction,
        required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _OpenTalkbackSubmoduleState();
  }
}

class _OpenTalkbackSubmoduleState extends State<_OpenTalkback> {
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
      Timer(Duration(seconds: 15), () {
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
          title: const Text('Open Talkback Menu'),
        ),
        body: Center(
            child: Column(children: [
              InstructionsCard(instruction: widget.instruction),
            ])));
  }
}
