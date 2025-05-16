import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/received_friend_requests_controller.dart';
import 'package:line/widgets/data/friends_requests_widget.dart';

class FriendsRequestPage extends StatelessWidget {
  const FriendsRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceivedFriendRequestsController requestsController = Get.put(
      ReceivedFriendRequestsController(),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("friend requests")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Obx(() {
            final receivedRequests = requestsController.friendRequests.value;
            return (receivedRequests.isEmpty)
                ? Center(
                  child: Text(
                    "You have no friends requests at the moment",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                )
                : FriendsRequestsWidget();
          }),
        ),
      ),
    );
  }
}
