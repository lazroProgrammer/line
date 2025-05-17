import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/UI/index_controller.dart';
import 'package:line/generic_fonctions.dart';
import 'package:line/pages/main/add_friends_page.dart';
import 'package:line/pages/main/friends_request_page.dart';
import 'package:line/pages/main/homepage.dart';
import 'package:line/pages/main/me_page.dart';

const List<String> labels = ["Home", "Me"];
const List<Widget> widgets = [Homepage(), MePage()];

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController indexController = Get.put(
      IndexController(0),
      tag: "navbar",
    );
    return Obx(() {
      final int index = indexController.obj.value;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(labels[index]),
            actions: [
              IconButton(
                onPressed: () {
                  navigateWithFade(AddFriendsPage());
                },
                icon: Icon(Icons.person_add),
              ),
              IconButton(
                onPressed: () {
                  navigateWithFade(FriendsRequestPage());
                },
                icon: Icon(Icons.person_pin_sharp),
              ),
            ],
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: widgets[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            items: [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Me", icon: Icon(Icons.person)),
            ],
            onTap: (value) => indexController.set(value),
          ),
        ),
      );
    });
  }
}
