import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({super.key, required this.icon, required this.label});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ToggleController darkmode = Get.find(tag: "dark");
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
            height: 32,
            child: FittedBox(
              child: Icon(
                icon,
                color: (darkmode.obj.value) ? Colors.white : Colors.blue,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ],
      );
    });
  }
}
