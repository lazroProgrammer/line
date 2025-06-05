import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/user_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart';

class UsersRefController extends GetxController {
  late Rx<Map<String, AppUser>> users;
  final UserDao userDao = UserDao(firestore: FirebaseFirestore.instance);

  UsersRefController() {
    users = Rx({});
  }

  Future<void> getUsers(List<String> allIDs) async {
    if (allIDs.isEmpty) return;
    final idsToFetch =
        allIDs.where((id) => !users.value.containsKey(id)).toList();

    if (idsToFetch.isEmpty) return;

    final newUsers = await userDao.getByIDs(idsToFetch);
    for (final user in newUsers) {
      users.value[user.id] = user;
    }
    users.refresh();
  }
}
