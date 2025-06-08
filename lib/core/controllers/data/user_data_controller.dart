import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      userIDP: FirebaseAuth.instance.currentUser!.uid,
      nameP: userData.name,
      emailP: userData.email,
    );
    user.value = SettingsData().getUser();
    user.refresh();
  }

  Future<void> logout() async {
    SettingsData().update(
      userIDP: "",
      nameP: "None",
      emailP: "example@wow.com",
    );
    user.value = AppUser(id: "", email: "example@wow.com", name: "None");
  }

  void setUser() {
    user.value = SettingsData().getUser();
  }
}
