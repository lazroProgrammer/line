import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/message.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

class MessageDao extends FirestoreCRUD<Message> {
  MessageDao({required super.firestore})
    : super(
        collectionPath: Message.collectionPath,
        fromJson: Message.fromJson,
        toJson: (Message user) => user.toJson(),
      );

  Future<(List<Message>, DocumentSnapshot?)> getByInbox(
    DocumentReference inboxRef, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('inboxRef', isEqualTo: inboxRef)
        .orderBy('created_at', descending: true)
        .limit(8);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    final messages =
        querySnapshot.docs.map((doc) => fromJson(doc.data(), doc.id)).toList();
    final lastDoc =
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

    return (messages, lastDoc);
  }
}
