import 'package:application/tutorial/six/module/type_with_virtual_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:application/tutorial/six/module/chatView.dart';

class TutorialSix extends StatelessWidget {
  const TutorialSix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // scaffold page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial 6"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TypeWithKeyboard()),
                );
              },
              child: const Text("typing with a virtual keyboard"),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatView()),
                );
              },
              child: Text("End of Lesson challenges"),
            ),
          ],
        ),
      ),
    );
  }
}