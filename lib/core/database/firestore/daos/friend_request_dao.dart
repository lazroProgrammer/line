import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/friend_request.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

class FriendRequestDao extends FirestoreCRUD<FriendRequest> {
  FriendRequestDao({required super.firestore})
    : super(
        collectionPath: FriendRequest.collectionPath,
        fromJson: FriendRequest.fromJson,
        toJson: (FriendRequest user) => user.toJson(),
      );

  Future<List<FriendRequest>> getBySender(
    String sender, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('sender', isEqualTo: sender)
        .limit(5);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    return querySnapshot.docs
        .map((doc) => fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<FriendRequest>> getByReceiver(
    String receiver, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('receiver', isEqualTo: receiver)
        .where('status', isNotEqualTo: "accepted")
        .limit(5);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    return querySnapshot.docs
        .map((doc) => fromJson(doc.data(), doc.id))
        .toList();
  }
}
