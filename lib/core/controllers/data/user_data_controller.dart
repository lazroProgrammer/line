import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

class UserDataController extends GetxController {
  Rx<AppUser> user;
  UserDataController() : user = SettingsData().getUser().obs;
}
