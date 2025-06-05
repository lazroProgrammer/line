import 'package:flutter/material.dart';
import 'package:get/get.dart';

void navigateWithFade(Widget page) {
  Get.to(
    () => page,
    duration: const Duration(milliseconds: 400),
    transition: Transition.fade,
  );
}

void normalNavigation(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}
