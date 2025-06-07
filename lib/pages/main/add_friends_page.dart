import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/UI/user_search_controller.dart';
import 'package:line/widgets/data/user_search_widget.dart';
import 'package:line/widgets/search_widget.dart';

class AddFriendsPage extends StatelessWidget {
  const AddFriendsPage({super.key});
  //TODO:not fully implemented
  @override
  Widget build(BuildContext context) {
    final UserSearchController resultController = Get.put(
      UserSearchController(),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Add Friends")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
            children: [
              SearchWidget(),
              SizedBox(height: 8),
              Obx(() {
                final isLoading = resultController.isLoading.value;
                return isLoading
                    ? Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 3,
                      child: ListView.builder(
                        itemCount: resultController.results.length,
                        itemBuilder:
                            (context, index) => UserSearchWidget(
                              user: resultController.results[index],
                            ),
                      ),
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
