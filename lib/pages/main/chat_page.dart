import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line/widgets/data/chat_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.inbox});
  final DocumentReference inbox;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Chat')),
        body: ChatWidget(inbox: inbox),
      ),
    );
  }
}
