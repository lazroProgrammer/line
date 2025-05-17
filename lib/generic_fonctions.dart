import 'package:flutter/material.dart';
import 'package:get/get.dart';

void navigateWithFade(Widget page) {
  Get.to(
    () => page,
    duration: const Duration(milliseconds: 400),
    transition: Transition.fade,
  );
}
