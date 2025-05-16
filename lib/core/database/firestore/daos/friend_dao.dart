import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/friend.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

//TODO: all Daos functions needs testing
//TODO: if you add state to the DAO classes for any reason (which you shouldn't), you should make them singleton
class FriendDao extends FirestoreCRUD<Friend> {
  FriendDao({required super.firestore})
    : super(
        collectionPath: 'friend_requests',
        fromJson: Friend.fromJson,
        toJson: (Friend user) => user.toJson(),
      );

  Future<List<Friend>> getBySender(
    DocumentReference sender, {
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

  Future<List<Friend>> getByReceiver(
    DocumentReference receiver, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('receiver', isEqualTo: receiver)
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
