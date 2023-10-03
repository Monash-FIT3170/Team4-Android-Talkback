import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/semantics.dart';

class TypeWithKeyboard extends StatefulWidget {
  const TypeWithKeyboard({Key? key}) : super(key: key);
//TODO
//announce: tap and get keyboard
//set up keyboard listener
//announce: enter hello
//check the word
//announce
  _TypeWithKeyBoard createState() => _TypeWithKeyBoard();
}

class _TypeWithKeyBoard extends State<TypeWithKeyboard> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  bool isFirstTime = true;
  @override
  void initState() {
    super.initState();

    // Add a listener to the text field controller to listen for focus changes
    textController.addListener(() {
      if (textController.text.isEmpty &&
          textController.selection.baseOffset ==
              textController.selection.extentOffset) {
        // The text field has focus and the cursor is not selecting text
        // Call the speakDuringLesson function
        speakDuringLesson(
            "tutorial6_virtual_keyboard_part1_on_show_keyboard".tr());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  void speakDuringLesson(String text) async {
    SemanticsService.announce( text.tr(), TextDirection.ltr);
  }

  void onFinishTyping() {
    String input = textController.text.toLowerCase();
    if (input == "tutorial6_virtual_keyboard_hello".tr()) {
      speakDuringLesson(
          "tutorial6_virtual_keyboard_part1_on_finish_typing".tr());
      Future.delayed(Duration(seconds: 5), () {
        endLesson();
      });
    } else {
      speakDuringLesson(
          "tutorial6_virtual_keyboard_part1_on_finish_typing_fail".tr());
    }
  }

  void endLesson() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      isFirstTime = false;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Disable back button
        title: Focus(
          child: Semantics(
            focused: true, // Indicate that this widget is focused
            child: Text("tutorial6_lesson_title".tr(),  semanticsLabel: "tutorial6_virtual_keyboard_part1_intro".tr())
          ),
          ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textController,
              autofocus: false,
              keyboardType: TextInputType.text,
              onSubmitted: (value) {
                onFinishTyping();
              },
            ),
          ],
        ),
      ),
    );
  }
}
