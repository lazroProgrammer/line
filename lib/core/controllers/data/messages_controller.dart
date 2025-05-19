import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/database/firestore/daos/message_dao.dart';
import 'package:line/core/database/firestore/data/message.dart' as m;

//TODO: add archiving, editing later..
class MessagesController extends GetxController {
  late Rx<List<m.Message>> messages;
  late Rx<DocumentReference<Object?>> inbox;
  late Rx<DocumentSnapshot<Object?>?> lastDoc;

  final MessageDao dao = MessageDao(firestore: FirebaseFirestore.instance);

  MessagesController(DocumentReference inboxP) {
    inbox = inboxP.obs;
    lastDoc = Rx<DocumentSnapshot<Object?>?>(null);
    messages = Rx<List<m.Message>>([]);
  }

  Future<void> fetchMessages(String userID) async {
    final (msgs, last) = await dao.getByInbox(
      inbox.value,
      lastVisibleMessage: lastDoc.value,
    );
    messages.value.addAll(msgs);
    lastDoc.value = last;
  }

  Future<void> add(String text) async {
    Timestamp now = Timestamp.now();
    final userRef = SettingsData().getUser().getRef();
    final content = m.Message.getContent(text);
    m.Message msg = m.Message(
      content: content,
      createdAt: Timestamp.now(),
      inboxRef: inbox.value,
      isArchived: false,
      isEdited: false,
      lastUpdate: now,
      sender: userRef,
    );
    try {
      await dao.add(msg, id: msg.id);
      messages.value.add(msg);
      throw UnimplementedError();
    } catch (e) {
      m.log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      messages.value.removeWhere((r) => r.id == id);
    } catch (e) {}
  }
}
