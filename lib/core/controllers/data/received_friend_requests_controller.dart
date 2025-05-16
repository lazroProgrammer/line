import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/friend_request_dao.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';

class ReceivedFriendRequestsController extends GetxController {
  Rx<List<FriendRequest>> friendRequests;
  FriendRequestDao dao = FriendRequestDao(
    firestore: FirebaseFirestore.instance,
  );
  ReceivedFriendRequestsController() : friendRequests = Rx([]);

  Future<void> getReceivedRequests(String userID) async {
    // List<FriendRequest> requests = await dao.getByReceiver(userID);
    // friendRequests.value = requests;
    throw UnimplementedError();
  }

  Future<void> updateStatus(String id, bool isAccepted) async {
    try {
      throw UnimplementedError();
      await dao.update(id, {"status": isAccepted ? "accepted" : "rejected"});
      //TODO: you update the value
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }
}
