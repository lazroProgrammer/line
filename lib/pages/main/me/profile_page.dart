import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/data/user_data_controller.dart';
import 'package:line/widgets/data/friends_widget.dart';
import 'package:line/widgets/profile_picture.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataController userController = Get.find(tag: "user");
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Obx(() {
        final user = userController.user.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfilePicture(),
                  Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  FriendsWidget(),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
