import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/inboxes_controller.dart';
import 'package:line/core/controllers/data/received_friend_requests_controller.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';
import 'package:line/widgets/formatted_time.dart';

//TODO: make sure that if inbox fails to build, the application does it from the receiver side
class FriendsRequestsWidget extends StatelessWidget {
  final FriendRequest friendRequest;
  final AppUser user;
  final bool isReceived;

  FriendsRequestsWidget({
    super.key,
    required this.friendRequest,
    required this.user,
    required this.isReceived,
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
    final SentFriendRequestsController sentFriendRequestsController = Get.find(
      tag: "sentRequests",
    );
    final ReceivedFriendRequestsController receivedFriendRequestsController =
        Get.find(tag: "receivedRequests");
    final InboxesController inboxController = Get.find(tag: "inboxes");
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
                    formatedTime(
                      "dd/MM/yyyy HH:mm",
                      friendRequest.createdAt.toDate(),
                    ),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  (isReceived)
                      ? Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await receivedFriendRequestsController
                                  .updateStatus(friendRequest.id, false);
                            },
                            icon: Icon(Icons.cancel_outlined),
                          ),
                          IconButton(
                            onPressed: () async {
                              await receivedFriendRequestsController
                                  .updateStatus(friendRequest.id, true);
                              await inboxController.add(user);
                            },
                            icon: Icon(Icons.check),
                          ),
                        ],
                      )
                      : IconButton(
                        onPressed: () async {
                          await sentFriendRequestsController.deleteByID(
                            friendRequest.id,
                          );
                        },
                        icon: Icon(Icons.cancel_outlined),
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
