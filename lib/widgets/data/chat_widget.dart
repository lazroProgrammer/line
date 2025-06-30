import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/messages_controller.dart';
import 'package:line/core/database/firestore/data/inbox.dart';
import 'package:line/widgets/data/message_widget.dart';

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
            final groupedMessages = messagesController.groupMessagesByDate();
            final dates = groupedMessages.keys.toList();

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final messagesForDate = groupedMessages[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          date,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    ...messagesForDate.map(
                      (msg) => MessageWidget(message: msg),
                    ),
                  ],
                );
              },
            );
          }),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) async {
                    await _sendMessage(messagesController);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () async {
                  await _sendMessage(messagesController);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Future<void> _sendMessage(MessagesController mController) async {
    final text = _controller.text;
    if (text.trim().isNotEmpty) {
      await mController.add(text.trim());
      _controller.clear();
    }
  }
}
