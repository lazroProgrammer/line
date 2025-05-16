import 'package:flutter/material.dart';
import 'package:line/widgets/search_widget.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});
  //TODO:not fully implemented
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Add Friends")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(children: [SearchWidget()]),
        ),
      ),
    );
  }
}
