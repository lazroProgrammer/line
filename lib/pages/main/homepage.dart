import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/data/inboxes_controller.dart';
import 'package:line/widgets/data/inbox_widget.dart';
import 'package:line/widgets/data/simulation_inbox_widget.dart';
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

final inboxWidgets = [
  SimulationInboxWidget(
    userName: 'Alice',
    lastMessage:
        'Hey! Are you free tomorrow? We could get some coffee and hang out!',
    time: '2:15 PM',
    unreadCount: 3,
    avatarUrl: 'https://example.com/avatar_alice.jpg',
  ),
  SimulationInboxWidget(
    userName: 'Brian',
    lastMessage:
        'Got the files you sent. Will go through them this evening after dinner.',
    time: '6:42 PM',
    unreadCount: 1,
    avatarUrl: 'https://example.com/avatar_brian.jpg',
  ),
  SimulationInboxWidget(
    userName: 'Clara',
    lastMessage:
        'Don\'t forget the meeting at 10. I\'ll send a quick reminder later too.',
    time: '9:08 AM',
    unreadCount: 0,
    avatarUrl: 'https://example.com/avatar_clara.jpg',
  ),
  SimulationInboxWidget(
    userName: 'David',
    lastMessage:
        'Yes, that\'s exactly what I meant! We should try that new sushi place next week.',
    time: '4:20 PM',
    unreadCount: 5,
    avatarUrl: 'https://example.com/avatar_david.jpg',
  ),
  SimulationInboxWidget(
    userName: 'Ella',
    lastMessage:
        'See you at the station in 15. Let me know if you\'re running late.',
    time: '11:55 AM',
    unreadCount: 0,
    avatarUrl: 'https://example.com/avatar_ella.jpg',
  ),
  SimulationInboxWidget(
    userName: 'Farid',
    lastMessage:
        'Meeting pushed to Thursday. Please update the calendar and notify the others.',
    time: '3:33 PM',
    unreadCount: 2,
    avatarUrl: 'https://example.com/avatar_farid.jpg',
  ),
  SimulationInboxWidget(
    userName: 'Gwen',
    lastMessage:
        'Your package arrived! It\'s at the front desk, and it looks kind of heavy.',
    time: '12:10 PM',
    unreadCount: 7,
    avatarUrl: 'https://example.com/avatar_gwen.jpg',
  ),
  SimulationInboxWidget(
    userName: 'james',
    lastMessage: 'Hey let\'s have a pizza party this weekend.',
    time: '11:30 PM',
    unreadCount: 2,
    avatarUrl: 'https://example.com/avatar_gwen.jpg',
  ),
];
