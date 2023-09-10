import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'chat_model.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isFirstTime = true;
  final TextEditingController textEditor = TextEditingController();
  List<ChatModel> messages = [];

  @override
  void dispose() {
    textEditor.dispose();
    super.dispose();
  }

  Widget _buildTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: textEditor,
              //onSubmitted: _handleSubmit,
              decoration: InputDecoration.collapsed(
                hintText: "Send a message",
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () =>
                _handleSubmit(textEditor.text, messages.length + 1),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(String text, int id) {
    textEditor.clear();
    bool containMessage = text.contains("tutorial6_challenge_text_message".tr());
    ChatModel message = ChatModel(
      message: text,
      isMe: true,
      id: id,
    );
    speakDuringLesson(message.message);
    setState(() {
      messages.add(message);
      debugPrint("added message");
    });
    if (containMessage) {
      speakDuringLesson(
          "tutorial6_challenge_completion_message".tr());
      Future.delayed(Duration(seconds: 8), () {
        Navigator.pop(context);
      });
    }
  }

  void speakIntro() {
    SemanticsService.announce(
      "tutorial6_challenge_intro".tr(),
      TextDirection.ltr,
    );
    speakDuringLesson(
        "tutorial6_challenge_fragment1_intro".tr());
  }

  void speakDuringLesson(String text) async {
    SemanticsService.announce(
      text,
      TextDirection.ltr,
    );
  }

  Widget chatMessage(ChatModel message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.zero),
                ),
                child: Text(
                  message.message,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (isFirstTime) {
    //   speakIntro();
    //   isFirstTime = false;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Focus(
          child: Semantics(
              focused: true, // Indicate that this widget is focused
              child: Text("tutorial6_challenge_title".tr(),  semanticsLabel: "tutorial6_challenge_intro".tr())
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (messages.isNotEmpty && index < messages.length) {
                  return chatMessage(messages[index]);
                  //return Text(messages[index].message);
                } else {
                  debugPrint("unable to print");
                }
              },
            ),
          ),
          Divider(height: 1),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextField())
        ],
      ),
    );
  }
}
