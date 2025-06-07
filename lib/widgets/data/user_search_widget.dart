import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/connectivity.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/core/controllers/generic/object_controller.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/widgets/frequent_toasts.dart';

class UserSearchWidget extends StatelessWidget {
  final AppUser user;

  const UserSearchWidget({super.key, required this.user});

  Color getColorFromName(String name) {
    final List<Color> avatarColors = [
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
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = (hash + name.codeUnitAt(i)) % 0x7fffffff;
    }
    return avatarColors[hash % avatarColors.length];
  }

  @override
  Widget build(BuildContext context) {
    // Local per-widget state
    final ObjectController<bool> isSentController = ObjectController(false);

    final SentFriendRequestsController requestController = Get.find(
      tag: "sentRequests",
    );

    return InkWell(
      onTap: () {
        // Navigate or something else
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        height: 80,
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: getColorFromName(user.name),
              child: const Icon(Icons.person, size: 50),
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
            Obx(() {
              final alreadySent = requestController.users.value.containsKey(
                user.id,
              );
              final isSent = isSentController.obj.value;
              print(alreadySent);
              print(requestController.users.value);

              return IconButton(
                onPressed:
                    (alreadySent || isSent)
                        ? null
                        : () async {
                          isSentController.setValue(true);
                          if (!await Connection.internetConnection()) {
                            checkConnectionMsg();
                            return;
                          }
                          try {
                            await requestController.add(user);
                            isSentController.obj.value = true;
                          } catch (e) {
                            isSentController.setValue(false);
                            print("Friend request error: $e");
                          }
                        },
                icon: const Icon(Icons.add, size: 30),
              );
            }),
          ],
        ),
      ),
    );
  }
}
