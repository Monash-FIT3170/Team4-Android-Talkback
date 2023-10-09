import 'dart:async';

import 'package:application/common/instruction_card.dart';
import 'package:application/routes.dart';
import 'package:flutter/material.dart';

class OpenVoiceCommand extends _OpenVoiceCommand {
  const OpenVoiceCommand({super.key})
      : super(
      instruction:
      "Welcome. In this module, you will learn how to enable voice commands. To do this, you need to perform a swipe right, then up gesture in one motion. When prompted for a voice command, say help. This will take you to the voice command help section. Explore the voice command help section, then return the tutorial by using a go back gesture or a back button if supported on your device. You may now start.",
      nextSubmodule: const OpenVoiceCommand2());
}

class OpenVoiceCommand2 extends _OpenVoiceCommand {
  const OpenVoiceCommand2({super.key})
      : super(
      instruction:
      "Well done! Now that you know some voice commands, you will learn how to increase talkback's reading speed by using the voice command.",
      nextSubmodule: const OpenVoiceCommand3());
}

class OpenVoiceCommand3 extends _OpenVoiceCommand {
  const OpenVoiceCommand3({super.key})
      : super(
      instruction:
      "Swipe right then up with one finger to open voice command again. Do this gesture, then say speak faster to make me speak faster. Move to the next element when you are done. You may now start.",
      nextSubmodule: const OpenVoiceCommand4());
}

class OpenVoiceCommand4 extends _OpenVoiceCommand {
  const OpenVoiceCommand4({super.key})
      : super(
      instruction:
      "I am now speaking faster. When you have completed listening to this text, go to the next element and select the finish button to finish the module.",
      nextSubmodule: null);
}



class _OpenVoiceCommand extends StatefulWidget {
  final String instruction;
  final _OpenVoiceCommand? nextSubmodule;

  const _OpenVoiceCommand(
      {super.key,
        required this.instruction,
        required this.nextSubmodule});

  @override
  State<StatefulWidget> createState() {
    return _OpenVoiceCommandSubmoduleState();
  }
}

class _OpenVoiceCommandSubmoduleState extends State<_OpenVoiceCommand> {
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
      Timer(const Duration(seconds: 15), () {
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
          title: const Text('Open Voice Command'),
        ),
        body: Center(
            child: Column(children: [
              InstructionsCard(instruction: widget.instruction),
            ])));
  }
}
