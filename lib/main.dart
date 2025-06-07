import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/core/controllers/data/inboxes_controller.dart';
import 'package:line/core/controllers/data/received_friend_requests_controller.dart';
import 'package:line/core/controllers/data/sent_friend_requests_controller.dart';
import 'package:line/core/controllers/data/user_data_controller.dart';
import 'package:line/core/controllers/settings/darkmode_controller.dart';
import 'package:line/root.dart';
import 'package:line/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SettingsData.init();
  _initControllers();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ToggleController darkmodeController = Get.put(
      DarkmodeController(),
      tag: "dark",
    );
    return Obx(() {
      final dark = darkmodeController.obj.value;
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: dark ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: const Root(),
      );
    });
  }
}

void _initControllers() {
  Get.put(InboxesController(), tag: "inboxes");
  Get.put(SentFriendRequestsController(), tag: "sentRequests");
  Get.put(ReceivedFriendRequestsController(), tag: "receivedRequests");
  Get.put(UserDataController(), tag: "user");
}

Future<void> getData() async {
  final InboxesController inboxesController = Get.find(tag: "inboxes");
  final SentFriendRequestsController sentRequestsController = Get.find(
    tag: "sentRequests",
  );
  final ReceivedFriendRequestsController receivedRequestsController = Get.find(
    tag: "receivedRequests",
  );

  await Future.wait([
    inboxesController.getInboxes(),
    sentRequestsController.getSentRequests(),
    receivedRequestsController.getReceivedRequests(),
  ]);
}
