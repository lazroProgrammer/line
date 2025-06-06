import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/generic/users_ref_controller.dart';
import 'package:line/core/database/firestore/daos/inbox_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart' as u;
import 'package:line/core/database/firestore/data/inbox.dart';

class InboxesController extends UsersRefController {
  late Rx<List<Inbox>> inboxes;
  late Rx<DocumentSnapshot<Object?>?> lastDoc;
  late RxBool isLoaded;
  InboxDao dao = InboxDao(firestore: FirebaseFirestore.instance);
  InboxesController() {
    inboxes = Rx([]);
    isLoaded = false.obs;
    lastDoc = Rx(null);
  }

  Future<void> getInboxes() async {
    isLoaded.value = false;
    final (a, b) = await dao.getByUser(
      SettingsData().getUser().id,
      lastVisibleMessage: lastDoc.value,
    );

    lastDoc.value == null
        ? inboxes.value.assignAll(a)
        : inboxes.value.addAll(a);
    lastDoc.value = b;
    await getUsers(_getInboxSecondUser());
    isLoaded.value = true;
  }

  Future<void> add(u.AppUser user) async {
    final inbox = Inbox(
      lastUpdated: Timestamp.now(),
      userIDs: [SettingsData().getUser().getRef(), user.getRef()],
      lastMessage: "",
    );
    try {
      await dao.add(inbox, id: inbox.id);
      inboxes.value.add(inbox);
      await getUsers(_getInboxSecondUser());
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      inboxes.value.removeWhere((r) => r.id == id);
      //TODO: remove user when inboxes inbox is deleted
    } catch (e) {}
  }

  //? this assumes that there are no group chat and assumes that there are strictly 2 users
  List<String> _getInboxSecondUser() {
    return inboxes.value.map((e) {
      final a = e.userIDs.firstWhere(
        (element) => element.id != SettingsData().getUser().id,
      );
      return a.id;
    }).toList();
  }
}
