import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/received_friend_requests_controller.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/widgets/data/friends_requests_widget.dart';

class FriendsRequestPage extends StatelessWidget {
  const FriendsRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceivedFriendRequestsController receivedRequestsController =
        Get.find(tag: "receivedRequests");
    final SentFriendRequestsController sentRequestsController = Get.find(
      tag: "sentRequests",
    );

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Friend Requests"),
            bottom: const TabBar(
              tabs: [Tab(text: "Sent"), Tab(text: "Received")],
            ),
          ),
          body: TabBarView(
            children: [
              // Sent Requests
              Obx(() {
                final sent = sentRequestsController.friendRequests;
                if (sent.isEmpty) {
                  return const Center(child: Text("No sent requests."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: sent.length,
                  itemBuilder: (context, index) {
                    final request = sent[index];
                    final user =
                        sentRequestsController.users.value[request.receiver];
                    if (user == null) {
                      return const SizedBox.shrink(); // avoid null
                    }
                    return FriendsRequestsWidget(
                      friendRequest: request,
                      user: user,
                      isReceived: false,
                    );
                  },
                );
              }),

              // Received Requests
              Obx(() {
                final received = receivedRequestsController.friendRequests;
                if (received.isEmpty) {
                  return const Center(child: Text("No received requests."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: received.length,
                  itemBuilder: (context, index) {
                    final request = received[index];
                    final user =
                        receivedRequestsController.users.value[request.sender];
                    if (user == null) return const SizedBox.shrink();
                    return FriendsRequestsWidget(
                      friendRequest: request,
                      user: user,
                      isReceived: true,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
