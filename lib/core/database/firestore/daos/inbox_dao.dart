import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/inbox.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

class InboxDao extends FirestoreCRUD<Inbox> {
  InboxDao({required super.firestore})
    : super(
        collectionPath: Inbox.collectionPath,
        fromJson: Inbox.fromJson,
        toJson: (Inbox user) => user.toJson(),
      );

  Future<(List<Inbox>, DocumentSnapshot?)> getByUser(
    String userID, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('userIDs', arrayContains: userID)
        .limit(8);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    final messages =
        querySnapshot.docs
            .map((doc) => Inbox.fromJson(doc.data(), doc.id))
            .toList();
    final lastDoc =
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

    return (messages, lastDoc);
  }
}
