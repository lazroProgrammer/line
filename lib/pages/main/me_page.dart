import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/connectivity.dart';
import 'package:line/core/apis/firebase/auth.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/core/controllers/data/user_data_controller.dart';
import 'package:line/pages/main/me/about_page.dart';
import 'package:line/pages/main/me/profile_page.dart';
import 'package:line/pages/main/me/settings_page.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  // bool notification = true;
  @override
  Widget build(BuildContext context) {
    // final usr = ref.watch(userNotifier);
    final ToggleController darkmode = Get.find(tag: "dark");
    UserDataController userController = Get.put(
      UserDataController(),
      tag: "user",
    );

    return Column(
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(radius: 70, child: Icon(Icons.person, size: 110)),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final name = userController.user.value.name;
          return Text(
            // "${usr?.name}",
            name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        }),
        // Text("${usr?.email}"),
        Obx(() {
          final email = userController.user.value.email;
          return Text(email);
        }),

        const SizedBox(height: 20),
        Obx(() {
          final dark = darkmode.obj.value;
          return ElevatedButton(
            onPressed: () {},
            // onPressed: () => Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => UpdateProfileScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: (dark) ? Colors.blue[900] : Colors.blue[100],
              side: BorderSide.none,
              shape: const StadiumBorder(),
            ),
            child: const Text("Edit Profile"),
          );
        }),
        const SizedBox(height: 30),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('profile'),
          onTap: () {
            Get.to(
              () => ProfilePage(),
              duration: Duration(milliseconds: 400),
              transition: Transition.fade,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Get.to(
              () => SettingsPage(),
              duration: Duration(milliseconds: 400),
              transition: Transition.fade,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.text_snippet_rounded),
          title: const Text('About us'),
          onTap: () {
            Get.to(
              () => AboutPage(),
              duration: Duration(milliseconds: 400),
              transition: Transition.fade,
            );
          },
        ),

        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('logout'),
          onTap: () {
            // SettingsData.setLogin(false);
            Connection.internetConnection().then((value) {
              // usr!.exportData(usr.id);
              // User.signOut();
              signOut().then((v) {});
            });
          },
        ),
      ],
    );
  }
}
