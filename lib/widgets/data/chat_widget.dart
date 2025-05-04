import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/UI/chat_controller.dart';

class ChatWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ChatController chatController = Get.put(ChatController());

  ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(14.0),
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                final alignment =
                    message.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft;
                final color =
                    message.isUser ? Colors.blueAccent : Colors.grey[300];
                final textColor =
                    message.isUser ? Colors.white : Colors.black87;
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
                      message.text,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
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
    chatController.sendMessage(_controller.text);
    _controller.clear();
  }
}
