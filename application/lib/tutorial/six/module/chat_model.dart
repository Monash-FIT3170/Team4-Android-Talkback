class ChatModel {
  int id;
  String message;
  bool isMe;

  ChatModel({required this.id, required this.message, required this.isMe});

  void insert(int i, ChatModel message) {}
}