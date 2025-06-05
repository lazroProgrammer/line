import 'package:flutter/material.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';

class FriendsRequestsWidget extends StatelessWidget {
  final FriendRequest friendRequest;
  final AppUser user;

  FriendsRequestsWidget({
    super.key,
    required this.friendRequest,
    required this.user,
  });
  final List<Color> _avatarColors = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.amber,
    Colors.yellow.shade700,
    Colors.lime.shade600,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.grey.shade600,
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
        // navigateWithFade(ChatPage());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        height: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: getColorFromName(user.name),
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(width: 12),
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
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.email,
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
                    friendRequest.createdAt.toDate().toIso8601String(),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
