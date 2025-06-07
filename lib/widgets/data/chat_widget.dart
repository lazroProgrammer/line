import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/data/messages_controller.dart';
import 'package:line/core/database/firestore/data/inbox.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({super.key, required this.inbox});

  final Inbox inbox;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MessagesController messagesController = Get.put(
      MessagesController(inbox),
    );
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            final messages = messagesController.messages;
            return ListView.builder(
              padding: const EdgeInsets.all(14.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message.sender == SettingsData().userID;
                final alignment =
                    isUser ? Alignment.centerRight : Alignment.centerLeft;
                final color = isUser ? Colors.blueAccent : Colors.grey[300];
                final textColor = isUser ? Colors.white : Colors.black87;
                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      //TODO: to be changed later
                      message.content["data"] as String,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                );
              },
            );
          }),
        ),
        Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  void _sendMessage() {
    _controller.clear();
  }
}
