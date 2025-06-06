import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/UI/user_search_controller.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = SearchController();
  final _searchController = Get.put(UserSearchController());

  bool _containsInvalidNameChars(String input) {
    // Only allow letters (a-z, A-Z) and at most two spaces
    final validNameRegex = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+){0,2}$");
    return !validNameRegex.hasMatch(input);
  }

  Future<void> _onSubmitted([String? text]) async {
    final input = (text ?? controller.text).trim();

    if (input.length < 3) {
      Fluttertoast.showToast(msg: "Enter at least 3 characters");
      return;
    }

    if (_containsInvalidNameChars(input)) {
      await _searchController.searchByEmail(input);
    } else {
      await _searchController.searchByName(input);
    }
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SearchAnchor(
        isFullScreen: false,
        viewOnChanged: (_) {}, // No live filtering
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16),
            ),
            // onTap: () => controller.openView(),
            // onChanged: (_) {}, // No throttle/search on change
            onSubmitted: (text) async {
              await _onSubmitted(text);
            }, // Triggers when hitting enter
            leading: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                await _onSubmitted(controller.text);
              },
            ),
          );
        },
        suggestionsBuilder: (_, __) => [], // No suggestions
      ),
    );
  }
}
