import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/generic/users_ref_controller.dart';
import 'package:line/core/database/firestore/daos/friend_request_dao.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';

class ReceivedFriendRequestsController extends UsersRefController {
  late Rx<List<FriendRequest>> friendRequests;
  FriendRequestDao dao = FriendRequestDao(
    firestore: FirebaseFirestore.instance,
  );
  ReceivedFriendRequestsController() {
    friendRequests = Rx([]);
  }

  Future<void> getReceivedRequests() async {
    List<FriendRequest> requests = await dao.getByReceiver(
      SettingsData().getUser().getRef(),
    );
    friendRequests.value.assignAll(requests);
    await getUsers(
      FriendRequest.getUsers(friendRequests.value, isSender: true),
    );
  }

  Future<void> updateStatus(String id, bool isAccepted) async {
    try {
      await dao.update(id, {"status": isAccepted ? "accepted" : "rejected"});
      for (var element in friendRequests.value) {
        if (element.id == id) {
          FriendRequest n = FriendRequest(
            createdAt: element.createdAt,
            sender: element.sender,
            receiver: element.receiver,
            status: isAccepted ? "accepted" : "rejected",
          );
          element = n;
        }
      }
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }
}
