import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/user_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

class UserSearchController extends GetxController {
  RxString query = ''.obs;
  late Rx<List<AppUser>> results;
  RxBool isLoading = false.obs;
  final UserDao userDao = UserDao(firestore: FirebaseFirestore.instance);
  UserSearchController() {
    results = Rx([]);
  }

  void onQueryChanged(String input) {
    query.value = input.trim();

    if (query.value.length >= 3) {
      if (query.value.contains('@')) {
        searchByEmail(query.value);
      } else {
        searchByName(query.value);
      }
    } else {
      results.value.clear();
    }
  }

  Future<void> searchByName(String name) async {
    isLoading.value = true;
    try {
      final res = await userDao.getByName(name);
      results.value.clear();
      results.value.addAll(res);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchByEmail(String email) async {
    isLoading.value = true;
    try {
      final res = await userDao.getByEmailSearch(email);
      results.value.clear();
      results.value.addAll(res);
    } finally {
      isLoading.value = false;
    }
  }
}
