import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/widgets/data/friends_requests_widget.dart';
import 'package:line/widgets/search_widget.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});
  //TODO:not fully implemented
  @override
  Widget build(BuildContext context) {
    final SentFriendRequestsController requestsController = Get.put(
      SentFriendRequestsController(),
      tag: "sentRequests",
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Add Friends")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            children: [
              SearchWidget(),
              SizedBox(height: 8),
              Text("sent requests", style: TextStyle(fontSize: 24)),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Obx(
                  () => ListView.builder(
                    itemCount: requestsController.friendRequests.value.length,
                    itemBuilder:
                        (context, index) => FriendsRequestsWidget(
                          friendRequest:
                              requestsController.friendRequests.value[index],
                          user: requestsController.users.value.firstWhere(
                            (element) =>
                                requestsController
                                    .friendRequests
                                    .value[index]
                                    .receiver ==
                                element.getRef(),
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
