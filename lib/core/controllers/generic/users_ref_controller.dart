import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/user_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

class UsersRefController extends GetxController {
  late Rx<List<AppUser>> users;
  UserDao userDao = UserDao(firestore: FirebaseFirestore.instance);

  UsersRefController() {
    users = Rx([]);
  }

  Future<void> getUsers(List<String> allIDs) async {
    final allIds = allIDs;
    final fetchedIds = users.value.map((element) => element.id).toList();

    final ids = allIds.where((id) => !fetchedIds.contains(id)).toList();
    final list = await userDao.getByIDs(ids);
    users.value.addAll(list);
  }
}
