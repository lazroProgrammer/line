import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/data/inboxes_controller.dart';
import 'package:line/widgets/data/inbox_widget.dart';
import 'package:line/widgets/skeltons/skelton.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final InboxesController inboxesController = Get.find(tag: "inboxes");
    return Obx(() {
      final inboxes = inboxesController.inboxes;
      final users = inboxesController.users.value;
      final userID = SettingsData().getUser().id;
      return inboxesController.isLoaded.value
          ? ListView.builder(
            itemCount: inboxes.length,
            itemBuilder:
                (context, index) => InboxWidget(
                  inbox: inboxes[index],
                  user:
                      users[inboxes[index].userIDs.firstWhere(
                        (element) => element != userID,
                      )]!,
                ),
          )
          : ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) => Skelton(),
          );
    });
  }
}
