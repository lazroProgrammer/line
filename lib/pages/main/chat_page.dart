import 'package:flutter/material.dart';
import 'package:line/core/database/firestore/data/inbox.dart';
import 'package:line/widgets/data/chat_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.inbox});
  final Inbox inbox;

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
