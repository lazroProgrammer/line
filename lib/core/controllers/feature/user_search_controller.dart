import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/daos/user_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

//handles user searches

class UserSearchController extends GetxController {
  RxString query = ''.obs;
  late RxList<AppUser> results;
  RxBool isLoading = false.obs;
  final UserDao userDao = UserDao(firestore: FirebaseFirestore.instance);
  UserSearchController() {
    results = RxList();
  }
  // this judges what suggestion function to use
  void onQueryChanged(String input) {
    query.value = input.trim();

    if (query.value.length >= 3) {
      if (query.value.contains('@')) {
        searchByEmail(query.value);
      } else {
        searchByName(query.value);
      }
    } else {
      results.clear();
    }
  }

  Future<void> searchByName(String name) async {
    isLoading.value = true;
    final user = SettingsData().getUser();
    try {
      if (user.name.contains(name)) {
        final res = await userDao.getByName(name);
        results.clear();
        final you = res.firstWhere((element) => user.email == element.email);
        res.remove(you);
        results.addAll(res);
      } else {
        final res = await userDao.getByName(name);
        results.clear();
        results.addAll(res);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchByEmail(String email) async {
    isLoading.value = true;
    final user = SettingsData().getUser();
    try {
      if (user.email.contains(email)) {
        final res = await userDao.getByEmailSearch(email);
        results.clear();
        final you = res.firstWhere((element) => user.email == element.email);
        res.remove(you);
        results.addAll(res);
      } else {
        final res = await userDao.getByEmailSearch(email);
        results.clear();
        results.addAll(res);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
