import 'package:flutter/material.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/core/database/firestore/data/inbox.dart';
import 'package:line/generic_fonctions.dart';
import 'package:line/pages/main/chat_page.dart';
import 'package:line/widgets/formatted_time.dart';

class InboxWidget extends StatelessWidget {
  final Inbox inbox;
  final AppUser user;

  InboxWidget({super.key, required this.inbox, required this.user});

  final List<Color> _avatarColors = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.grey,
  ];

  Color getColorFromName(String name) {
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = (hash + name.codeUnitAt(i)) % 0x7fffffff; // avoid overflow
    }
    return _avatarColors[hash % _avatarColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateWithFade(ChatPage(inbox: inbox));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        height: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: getColorFromName(user.name),
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(user.isConnected ? 1 : 3),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border:
                        user.isConnected
                            ? Border.all(color: Colors.green, width: 2)
                            : null,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor:
                        user.isConnected ? Colors.green : Colors.grey,
                    radius: 6,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      // inbox.lastMessage,
                      "hey, do you want to hang out later?",
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatedTime(
                      "dd/MM/yyyy hh:mm",
                      inbox.lastUpdated.toDate(),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  // if (unreadCount > 0)
                  //   Container(
                  //     margin: const EdgeInsets.only(top: 8),
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: const BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: Text(
                  //       unreadCount.toString(),
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
