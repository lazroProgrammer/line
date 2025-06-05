import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/connectivity.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/widgets/frequent_toasts.dart';

class UserSearchWidget extends StatefulWidget {
  final AppUser user;

  const UserSearchWidget({super.key, required this.user});

  @override
  State<UserSearchWidget> createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
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

  bool isSent = false;
  @override
  Widget build(BuildContext context) {
    final SentFriendRequestsController requestController = Get.put(
      SentFriendRequestsController(),
    );
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
              backgroundColor: getColorFromName(widget.user.name),
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
                      widget.user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.user.email,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => IconButton(
                onPressed:
                    //TODO: see if user have been sent a request before and see if the user have already an inbox with the user
                    (isSent ||
                            requestController.users.value.containsKey(widget.user.id))
                        ? null
                        : () {
                          Connection.internetConnection().then((connection) {
                            if (connection) {
                              try {
                                requestController.add(widget.user).then((_) {
                                  setState(() {
                                    isSent = true;
                                  });
                                });
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              checkConnectionMsg();
                            }
                          });
                        },
                icon: Icon(Icons.add, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
