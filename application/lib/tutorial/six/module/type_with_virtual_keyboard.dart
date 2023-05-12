import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

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
class _TypeWithKeyBoard extends State<TypeWithKeyboard>{
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  bool isFirstTime = true;
  @override
  void initState() {
    super.initState();
    speakIntro();

    // Add a listener to the text field controller to listen for focus changes
    textController.addListener(() {
      if (textController.text.isEmpty &&
          textController.selection.baseOffset ==
              textController.selection.extentOffset) {
        // The text field has focus and the cursor is not selecting text
        // Call the speakDuringLesson function
        speakDuringLesson("Great job! You opened up the on screen virtual keyboard. Explore by touch to type hello using the keyboard");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }

  void speakIntro() {
    SemanticsService.announce("In this tutorial, you will be learning how to open the on-screen virtual keyboard and type using it.", TextDirection.ltr,);
    speakDuringLesson("To start, double tap on the screen to open the virtual keyboard.");
  }

  void speakDuringLesson(String text) async{
    SemanticsService.announce(text,TextDirection.ltr,);
  }
  void onFinishTyping() {
    String input = textController.text.toLowerCase();
    if (input == "hello") {
      speakDuringLesson("Great job! You have typed the word hello with the on screen keyboard. Congratulations on completing this lesson. In this lesson you have successfully learnt how to type with the on screen keyboard.");
      Future.delayed(Duration(seconds: 5), () {
        endLesson();
      });
    } else {
      speakDuringLesson("Looks like you have not typed the word hello. Double tap on the screen to bring up the keyboard. Tap on the backspace button to delete the previously typed word and try typing the word hello again.");
    }
  }
  void endLesson(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    if (isFirstTime) {
      speakIntro();
      isFirstTime = false;
    }
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   SemanticsService.announce("In this tutorial, you will be learning how to open the on-screen virtual keyboard and type using it. To start, double tap on the screen to open the virtual keyboard.", TextDirection.ltr);
    // });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable back button
        title: const Text("Go Back Module"),
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
