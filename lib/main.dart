import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/UI/toggle_controller.dart';
import 'package:line/core/controllers/settings/darkmode_controller.dart';
import 'package:line/pages/login/login_page.dart';
import 'package:line/pages/main/main_page.dart';
import 'package:line/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SettingsData.init();
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
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData) {
              return const Mainpage();
            } else {
              return LoginPage();
            }
          },
        ),
      );
    });
  }
}
