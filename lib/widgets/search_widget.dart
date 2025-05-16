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

  Future<void> _onSubmitted() async {
    final text = controller.text.trim();
    if (text.length < 3) {
      Fluttertoast.showToast(msg: "Enter at least 3 characters");
      return;
    }

    if (_containsInvalidNameChars(text)) {
      await _searchController.searchByEmail(text);
    } else {
      await _searchController.searchByName(text);
    }

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      isFullScreen: false,
      viewOnChanged: (_) {}, // No suggestions
      builder: (context, controller) {
        return SearchBar(
          controller: controller,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          onTap: () => controller.openView(),
          onChanged: (_) {}, // Keep it empty to avoid filtering or triggering
          leading: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSubmitted,
          ),
        );
      },
      suggestionsBuilder: (_, __) => [], // No suggestions shown
    );
  }
}
