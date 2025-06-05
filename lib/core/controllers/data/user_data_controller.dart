import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/daos/user_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

class UserDataController extends GetxController {
  Rx<AppUser> user;
  UserDao dao = UserDao(firestore: FirebaseFirestore.instance);
  UserDataController() : user = SettingsData().getUser().obs;

  Future<void> add(AppUser user) async {
    String id = await dao.add(user);
    print("~~~~~ USERID: $id");
  }

  Future<void> login(String email) async {
    AppUser userData = await dao.getByEmailAuth(email);
    SettingsData().update(
      userIDP: userData.id,
      nameP: userData.name,
      emailP: userData.email,
    );
    user.value = userData;
  }

  Future<void> logout() async {
    SettingsData().update(
      userIDP: "None",
      nameP: "example@wow.com",
      emailP: "",
    );
    user.value = AppUser(email: "example@wow.com", name: "None");
  }
}
