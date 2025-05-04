import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class ChatController extends GetxController {
  final messages = <_ChatMessage>[].obs;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(_ChatMessage(text: text.trim(), isUser: true));
    _simulateResponse();
  }

  void _simulateResponse() {
    Future.delayed(Duration(milliseconds: 600 + Random().nextInt(1000)), () {
      final responses = [
        "HI, how are you?"
            "That's interesting!",
        "Tell me more.",
        "Really? 😄",
        "I didn't know that!",
        "Sounds good to me.",
        "Cool!",
        "Let's do it.",
        "Haha, nice one!",
        "Okay!",
        "Hmm 🤔",
      ];
      final response = responses[Random().nextInt(responses.length)];
      messages.add(_ChatMessage(text: response, isUser: false));
    });
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}
