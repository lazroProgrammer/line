import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/generic/users_ref_controller.dart';
import 'package:line/core/database/firestore/daos/friend_request_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart' as u;
import 'package:line/core/database/firestore/data/friend_request.dart';

class SentFriendRequestsController extends UsersRefController {
  late Rx<List<FriendRequest>> friendRequests;
  FriendRequestDao dao = FriendRequestDao(
    firestore: FirebaseFirestore.instance,
  );
  SentFriendRequestsController() {
    friendRequests = Rx([]);
    getSentRequests().then((_) {});
  }

  Future<void> getSentRequests() async {
    List<FriendRequest> requests = await dao.getBySender(
      SettingsData().getUser().getRef(),
    );
    friendRequests.value.addAll(requests);
    await getUsers(
      FriendRequest.getUsers(friendRequests.value, isSender: false),
    );
  }

  Future<void> add(u.AppUser user) async {
    final request = FriendRequest(
      createdAt: DateTime.timestamp() as Timestamp,
      sender: SettingsData().getUser().getRef(),
      receiver: user.getRef(),
      status: "pending",
    );
    try {
      await dao.add(request, id: request.id);
      friendRequests.value.add(request);
      await getUsers(
        FriendRequest.getUsers(friendRequests.value, isSender: false),
      );
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      friendRequests.value.removeWhere((r) => r.id == id);
      //TODO: remove user when friend request is deleted
    } catch (e) {}
  }
}
