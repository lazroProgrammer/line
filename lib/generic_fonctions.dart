import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

Future<void> safeRun(Future<void> Function() task) async {
  try {
    await task();
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'user-not-found':
        showSnackbar("No user found for that email.");
        break;
      case 'wrong-password':
        showSnackbar("Wrong password provided.");
        break;
      case 'too-many-requests':
        showSnackbar("Too many login attempts. Try again later.");
        break;
      default:
        showSnackbar("Auth error: ${e.message}");
    }
  } on FirebaseException catch (e) {
    switch (e.code) {
      case 'permission-denied':
        showSnackbar("Permission denied.");
        break;
      case 'resource-exhausted':
        showSnackbar("Quota exceeded. Try again later.");
        break;
      case 'unavailable':
        showSnackbar("Firebase is currently unavailable.");
        break;
      default:
        showSnackbar("Firebase error: ${e.message}");
    }
  } on SocketException {
    showSnackbar("No internet connection.");
  } on TimeoutException {
    showSnackbar("Operation timed out.");
  } on PlatformException catch (e) {
    showSnackbar("Platform error: ${e.message}");
  } catch (e) {
    showSnackbar("Unexpected error: $e");
  }
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
