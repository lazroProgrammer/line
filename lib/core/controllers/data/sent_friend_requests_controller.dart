import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/friend_request_dao.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';

class SentFriendRequestsController extends GetxController {
  Rx<List<FriendRequest>> friendRequests;
  FriendRequestDao dao = FriendRequestDao(
    firestore: FirebaseFirestore.instance,
  );
  SentFriendRequestsController() : friendRequests = Rx([]);

  Future<void> getSentRequests(String userID) async {
    // List<FriendRequest> requests = await dao.getBySender(userID);
    // friendRequests.value = requests;
    throw UnimplementedError();
  }

  Future<void> add(FriendRequest request) async {
    try {
      await dao.add(request, id: request.id);
      friendRequests.value.add(request);
      throw UnimplementedError();
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      friendRequests.value.removeWhere((r) => r.id == id);
    } catch (e) {}
  }
}
