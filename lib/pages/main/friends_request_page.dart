import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/received_friend_requests_controller.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/widgets/data/friends_requests_widget.dart';

class FriendsRequestPage extends StatelessWidget {
  const FriendsRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReceivedFriendRequestsController receivedRequestsController = Get.put(
      ReceivedFriendRequestsController(),
    );
    final SentFriendRequestsController sentRequestsController = Get.put(
      SentFriendRequestsController(),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("friend requests")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Obx(() {
            final receivedRequests =
                receivedRequestsController.friendRequests.value;
            return (receivedRequests.isEmpty)
                ? Center(
                  child: Text(
                    "You have no friends requests at the moment",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                )
                : Column(
                  children: [
                    SizedBox(height: 8),
                    Text("sent requests", style: TextStyle(fontSize: 24)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Obx(
                        () => ListView.builder(
                          itemCount:
                              sentRequestsController
                                  .friendRequests
                                  .value
                                  .length,
                          itemBuilder:
                              (context, index) => FriendsRequestsWidget(
                                friendRequest:
                                    sentRequestsController
                                        .friendRequests
                                        .value[index],
                                user:
                                    sentRequestsController
                                        .users
                                        .value[sentRequestsController
                                        .friendRequests
                                        .value[index]
                                        .receiver
                                        .id]!,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("received requests", style: TextStyle(fontSize: 24)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Obx(
                        () => ListView.builder(
                          itemCount:
                              receivedRequestsController
                                  .friendRequests
                                  .value
                                  .length,
                          itemBuilder:
                              (context, index) => FriendsRequestsWidget(
                                friendRequest:
                                    receivedRequestsController
                                        .friendRequests
                                        .value[index],

                                user:
                                    receivedRequestsController
                                        .users
                                        .value[receivedRequestsController
                                        .friendRequests
                                        .value[index]
                                        .sender
                                        .id]!,
                              ),
                        ),
                      ),
                    ),
                  ],
                );
          }),
        ),
      ),
    );
  }
}
