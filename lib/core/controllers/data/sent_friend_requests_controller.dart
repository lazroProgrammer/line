import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/generic/users_ref_controller.dart';
import 'package:line/core/database/firestore/daos/friend_request_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart' as u;
import 'package:line/core/database/firestore/data/friend_request.dart';

class SentFriendRequestsController extends UsersRefController {
  late RxList<FriendRequest> friendRequests;
  FriendRequestDao dao = FriendRequestDao(
    firestore: FirebaseFirestore.instance,
  );
  SentFriendRequestsController() {
    friendRequests = RxList();
  }

  Future<void> getSentRequests() async {
    print(SettingsData().getUser().id);

    List<FriendRequest> requests = await dao.getBySender(
      SettingsData().getUser().id,
    );
    friendRequests.assignAll(requests);
    await getUsers(FriendRequest.getUsers(friendRequests, isSender: false));
  }

  Future<void> add(u.AppUser user) async {
    final request = FriendRequest(
      createdAt: Timestamp.fromDate(DateTime.timestamp()),
      sender: SettingsData().getUser().id,
      receiver: user.id,
      status: "pending",
    );
    try {
      String id = await dao.add(request);
      final newRequest = FriendRequest(
        id: id,
        createdAt: Timestamp.fromDate(DateTime.timestamp()),
        sender: SettingsData().getUser().id,
        receiver: user.id,
        status: "pending",
      );
      friendRequests.add(newRequest);
      await getUsers(FriendRequest.getUsers(friendRequests, isSender: false));
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      friendRequests.removeWhere((r) => r.id == id);
      print(friendRequests.length);
      await getUsers(FriendRequest.getUsers(friendRequests, isSender: false));
    } catch (e) {
      log.e("exception $e");
    }
  }
}
