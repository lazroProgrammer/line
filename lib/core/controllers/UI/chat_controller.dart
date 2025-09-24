import 'dart:math';

import 'package:get/get.dart';

// a state machine that was used to test the UI, it responds to you based on
// messages you send
class ChatController extends GetxController {
  final messages = <_ChatMessage>[].obs;
  final _random = Random();

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(_ChatMessage(text: text.trim(), isUser: true));
    _simulateResponse(text.trim());
  }

  void _simulateResponse(String userInput) {
    Future.delayed(Duration(milliseconds: 600 + _random.nextInt(1000)), () {
      final inputTokens = userInput.toLowerCase().split(RegExp(r'\s+'));

      // Define keyword -> (priority, list of short/long responses)
      final Map<String, Map<String, List<String>>> keywordResponses = {
        "hello": {
          "short": ["Hey!", "Hi there!", "Hello 👋", "Yo!"],
          "long": [
            "Hey there! It's always nice to get a friendly greeting. How’s your day going so far? 😊",
          ],
        },
        "coffee": {
          "short": [
            "I love coffee too ☕",
            "Great idea!",
            "Coffee sounds perfect!",
          ],
          "long": [
            "Coffee is the fuel of champions. I usually start my day with a strong brew to stay focused and creative.",
            "Let’s definitely grab a cup together sometime soon. I know a cozy place!",
          ],
        },
        "how": {
          "short": ["Doing well, you?", "I'm fine! 😊", "All good here!"],
          "long": [
            "Thanks for asking! I'm doing pretty well today. What about you? Anything exciting happening?",
          ],
        },
        "joke": {
          "short": [
            "Wanna hear a joke?",
            "Why did the scarecrow win an award?",
          ],
          "long": [
            "Sure! Here’s a joke: Why don’t skeletons fight each other? Because they don’t have the guts! 😄",
            "Why don’t eggs tell jokes? Because they’d crack each other up! 😂",
          ],
        },
        "long": {
          "long": [
            "This is a longer response triggered by your use of the word 'long'. It’s meant to simulate a more thoughtful or detailed reply, which can be useful when the context demands more than just a quick reaction.",
            "Wow, that's quite a statement! Let me give you a proper reply with a bit more depth than usual. Here's a detailed message packed with warmth and enthusiasm.",
          ],
          "short": ["Got it.", "Okay."],
        },
      };

      // Find best keyword match by priority (e.g., first match)
      String? bestMatch;
      for (final token in inputTokens) {
        if (keywordResponses.containsKey(token)) {
          bestMatch = token;
          break;
        }
      }

      // Choose long or short variant
      bool wantsLong = inputTokens.contains("long") || userInput.length > 25;
      String response;

      if (bestMatch != null) {
        final variants = keywordResponses[bestMatch]!;
        final type =
            wantsLong && variants.containsKey("long") ? "long" : "short";
        final options = variants[type]!;
        response = options[_random.nextInt(options.length)];
      } else {
        // Fallback responses
        final fallback = [
          "That's interesting!",
          "Tell me more about that.",
          "Really? 😄",
          "Hmm 🤔",
          "Oh, I see.",
          "Nice one!",
          "Alright then!",
        ];
        response = fallback[_random.nextInt(fallback.length)];
      }

      messages.add(_ChatMessage(text: response, isUser: false));
    });
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}
