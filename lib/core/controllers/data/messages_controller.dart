import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/daos/message_dao.dart';
import 'package:line/core/database/firestore/data/inbox.dart';
import 'package:line/core/database/firestore/data/message.dart' as m;
import 'package:line/widgets/formatted_time.dart';

//TODO: add archiving, editing later..
class MessagesController extends GetxController {
  late RxList<m.Message> messages;
  late Rx<Inbox> inbox;
  late Rx<DocumentSnapshot<Object?>?> lastDoc;
  //for regrouping messages with dates like social media messages
  late RxMap<String, List<m.Message>> dates_messages;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  final MessageDao dao = MessageDao(firestore: FirebaseFirestore.instance);

  MessagesController(Inbox inboxP) {
    inbox = inboxP.obs;
    lastDoc = Rx<DocumentSnapshot<Object?>?>(null);
    messages = RxList([]);
    dates_messages = RxMap();

    print(FirebaseAuth.instance.currentUser!.uid);
    startListening(inboxP.getRef());
    // fetchMessages().then((_) {
    // startListening(lastDoc.value!.reference, messages.first.createdAt);
    // });
  }

  Future<void> fetchMessages() async {
    final (msgs, last) = await dao.getByInbox(
      inbox.value.getRef(),
      lastVisibleMessage: lastDoc.value,
    );
    messages.addAll(msgs.reversed);
    lastDoc.value = last;
    dates_messages.value = groupMessagesByDate();
    // startListening(lastDoc.value!.reference, messages.first.createdAt);
  }

  Future<void> add(String text) async {
    // preparing data
    Timestamp now = Timestamp.now();
    final userRef = SettingsData().getUser().id;
    final content = m.Message.getContent(text);
    m.Message msg = m.Message(
      content: content,
      createdAt: now,
      inboxRef: inbox.value.getRef(),
      isArchived: false,
      isEdited: false,
      lastUpdate: now,
      sender: userRef,
      receiver: inbox.value.userIDs.firstWhere((element) => userRef != element),
    );
    try {
      // add object to controller data
      await dao.add(msg);
      final date = formatedTime("dd/MM/yyyy", msg.lastUpdate.toDate());
      dates_messages.putIfAbsent(date, () => []).add(msg);
    } catch (e) {
      m.log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      final msg = messages.firstWhere((r) => r.id == id);
      final date = formatedTime("dd/MM/yyyy", msg.lastUpdate.toDate());

      // remove from controller data
      dates_messages[date]!.remove(msg);
      messages.remove(msg);
    } catch (e) {}
  }

  Map<String, List<m.Message>> groupMessagesByDate() {
    final Map<String, List<m.Message>> grouped = {};

    for (final msg in messages) {
      final date = formatedTime("dd/MM/yyyy", msg.lastUpdate.toDate());
      grouped.putIfAbsent(date, () => []).add(msg);
    }

    return grouped;
  }

  void startListening(DocumentReference inboxRef) {
    _subscription?.cancel();
    //defining what the subscription gives
    _subscription = FirebaseFirestore.instance
        .collection('messages')
        .where('inboxRef', isEqualTo: inboxRef)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          final newMessages =
              snapshot.docs
                  .map((doc) => m.Message.fromJson(doc.data(), doc.id))
                  .toList();
          messages.assignAll(newMessages.reversed);
          dates_messages.clear();
          dates_messages.value = groupMessagesByDate();
        });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void onClose() {
    stopListening();
    super.onClose();
  }
}
