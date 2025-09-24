import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/database/firestore/daos/inbox_dao.dart';
import 'package:line/core/database/firestore/data/inbox.dart';

//TODO: add archiving, editing later..
class MessagesController extends GetxController {
  late RxList<Inbox> messages;
  late Rx<DocumentReference<Object?>> inbox;
  late Rx<DocumentSnapshot<Object?>?> lastDoc;

  final InboxDao dao = InboxDao(firestore: FirebaseFirestore.instance);

  MessagesController(DocumentReference inboxP) {
    inbox = inboxP.obs;
    lastDoc = Rx<DocumentSnapshot<Object?>?>(null);
    messages = RxList([]);
  }

  Future<void> fetchInboxes(String userID) async {
    final (msgs, last) = await dao.getByUser(
      userID,
      lastVisibleMessage: lastDoc.value,
    );
    messages.addAll(msgs);
    lastDoc.value = last;
  }

  Future<void> add(String user1, String user2) async {
    Timestamp now = Timestamp.now();
    Inbox inbox = Inbox(
      lastMessage: "",
      lastUpdated: now,
      userIDs: [user1, user2],
    );
    try {
      String id = await dao.add(inbox);

      //? after adding to server
      final newInbox = Inbox(
        id: id,
        lastMessage: "",
        lastUpdated: now,
        userIDs: [user1, user2],
      );

      messages.add(newInbox);
      throw UnimplementedError();
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      messages.removeWhere((r) => r.id == id);
    } catch (e) {}
  }
}
