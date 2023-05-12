import 'package:flutter/material.dart';

import 'chatModel.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>{
  final TextEditingController textEditor = TextEditingController();
  List<ChatModel> messages = [];

  @override
  void dispose(){
    textEditor.dispose();
    super.dispose();
  }
  Widget _buildTextField(){
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
            onPressed: () => _handleSubmit(textEditor.text, messages.length+1),
          ),
        ],
      ),
    );
  }
  void _handleSubmit(String text, int id) {
    textEditor.clear();
    ChatModel message = ChatModel(
      message: text,
      isMe: true,
      id: id,
    );
    setState(() {
      messages.add(message);
      debugPrint("added message");
    });
  }
  Widget chatMessage(ChatModel message){
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
                    bottomLeft: Radius.circular(20.0) ,
                    bottomRight: Radius.zero
                    ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Message"),
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemBuilder: (BuildContext context, int index){
                if (messages.isNotEmpty && index<messages.length) {
                  return chatMessage(messages[index]);
                  //return Text(messages[index].message);
                }
                else {
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
            child: _buildTextField()
          )
        ],
      ),
    );
  }
}