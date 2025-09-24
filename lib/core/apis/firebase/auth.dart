import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:line/generic_fonctions.dart';
import 'package:logger/logger.dart';

Logger log = Logger();
Future<UserCredential?> signInWithEmail(String email, String password) async {
  return await safeRun(() async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  });
}

Future<UserCredential> signUpWithEmail(String email, String password) async {
  return await safeRun(() async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  });
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

//helper function
Future safeRun(Future Function() task) async {
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
