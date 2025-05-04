import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line/core/controllers/settings/darkmode_controller.dart';
import 'package:line/core/controllers/settings/time_format_controller.dart';

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({
    super.key,
    required this.index,
    required this.widgetKey,
  });
  final int index;
  final GlobalKey widgetKey;
  @override
  Widget build(BuildContext context) {
    final DarkmodeController darkmode = Get.find(tag: "dark");
    final TimeFormatController timeFormatController = Get.put(
      TimeFormatController(),
    );
    return Material(
      child: InkWell(
        onTap: () {
          // showTransactionPopupMenu(
          //   context,
          //   widgetKey,
          //   edit: () {
          //     // final PageControllerX pageController = Get.find(
          //     //   tag: "pageController",
          //     // );
          //     // showBottomSlide(context, pageController, tr);
          //   },
          //   delete: () {
          //   //   final TransactionsController trController = Get.find(
          //   //     tag: "transactions",
          //   //   );
          //   //   trController.deleteTransactionByID(tr.transactionID);
          //   },
          // );
        },
        child: Container(
          key: widgetKey,
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width - 40,
          height: 80,
          child: Container(),
        ),
      ),
    );
  }
}
