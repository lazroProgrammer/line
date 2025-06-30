import 'package:flutter/material.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/data/message.dart';
import 'package:line/widgets/formatted_time.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == SettingsData().userID;
    final color = isUser ? Colors.blueAccent : Colors.grey[300];
    final textColor = isUser ? Colors.white : Colors.black87;
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isUser
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                formatedTime("HH:mm", message.lastUpdate.toDate()),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            )
            : SizedBox(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        !isUser
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                formatedTime("HH:mm", message.lastUpdate.toDate()),
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            )
            : SizedBox(),
      ],
    );
  }
}
