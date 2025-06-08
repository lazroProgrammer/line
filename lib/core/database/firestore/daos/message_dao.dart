import 'dart:async';

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
        .orderBy('createdAt', descending: true)
        .limit(20);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    final messages =
        querySnapshot.docs
            .map((doc) => Message.fromJson(doc.data(), doc.id))
            .toList();
    final lastDoc =
        querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;

    return (messages, lastDoc);
  }

  Stream<List<Message>> listenToMessagesOfInbox(
    DocumentReference inbox,
    Timestamp latestLocalMessageTimestamp,
  ) {
    print("hello there");
    final query = FirebaseFirestore.instance
        .collection('messages')
        .where('inboxRef', isEqualTo: inbox)
        .orderBy('createdAt', descending: true);

    return query.snapshots().map((snapshot) {
      print("📥 New snapshot received: ${snapshot.docChanges.length} changes");
      return snapshot.docChanges
          .where(
            (change) =>
                change.type == DocumentChangeType.added &&
                (change.doc.data()?['createdAt'] as Timestamp).compareTo(
                      latestLocalMessageTimestamp,
                    ) >
                    0,
          )
          .map((change) => Message.fromJson(change.doc.data()!, change.doc.id))
          .toList();
    });
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> startMessageListener({
    required DocumentReference inboxRef,
    required Timestamp latestTimestamp,
    required void Function(List<Message>) onNewMessages,
  }) {
    final query = FirebaseFirestore.instance
        .collection('messages')
        .where('inboxRef', isEqualTo: inboxRef)
        .orderBy(
          'createdAt',
          descending: true,
        ); // do NOT use startAfter in a live listener

    return query.snapshots().listen((snapshot) {
      // Filter messages based on the timestamp
      final newMessages =
          snapshot.docs
              .map((doc) => Message.fromJson(doc.data(), doc.id))
              .where((msg) => msg.createdAt.compareTo(latestTimestamp) > 0)
              .toList();

      if (newMessages.isNotEmpty) {
        onNewMessages(newMessages);
      }
    });
  }
}
