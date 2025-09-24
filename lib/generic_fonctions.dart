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

void showSnackbar(
  String message, {
  String title = "Oops",
  bool isError = true,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor:
        isError ? const Color(0xFFDC3545) : const Color(0xFF28A745),
    colorText: const Color(0xFFFFFFFF),
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
    icon: Icon(
      isError ? Icons.error_outline : Icons.check_circle_outline,
      color: Colors.white,
    ),
  );
}
