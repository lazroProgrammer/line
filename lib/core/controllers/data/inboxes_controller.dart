import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:line/core/apis/app/settings.dart';
import 'package:line/core/controllers/generic/users_ref_controller.dart';
import 'package:line/core/database/firestore/daos/inbox_dao.dart';
import 'package:line/core/database/firestore/data/app_user.dart' as u;
import 'package:line/core/database/firestore/data/inbox.dart';

class InboxesController extends UsersRefController {
  late RxList<Inbox> inboxes;
  late Rx<DocumentSnapshot<Object?>?> lastDoc;
  late RxBool isLoaded;
  InboxDao dao = InboxDao(firestore: FirebaseFirestore.instance);
  InboxesController() {
    inboxes = RxList();
    isLoaded = false.obs;
    lastDoc = Rx(null);
  }

  Future<void> getInboxes() async {
    isLoaded.value = false;
    final (a, b) = await dao.getByUser(
      SettingsData().getUser().id,
      lastVisibleMessage: lastDoc.value,
    );
    print("'a' length: ${a.length}");
    if (lastDoc.value == null) {
      inboxes.clear();
      inboxes.addAll(a);
    } else {
      inboxes.addAll(a);
    }
    lastDoc.value = b;
    //this stores users in the user refs variable
    await getUsers(getInboxSecondUser());
    isLoaded.value = true;
  }

  Future<void> add(u.AppUser user) async {
    final now = Timestamp.now();
    final inbox = Inbox(
      lastUpdated: now,
      userIDs: [SettingsData().getUser().id, user.id],
      lastMessage: "",
    );
    try {
      final id = await dao.add(inbox);
      final newInbox = Inbox(
        id: id,
        lastUpdated: now,
        userIDs: [SettingsData().getUser().id, user.id],
        lastMessage: "",
      );
      inboxes.add(newInbox);
      //this stores users in the user refs variable
      await getUsers(getInboxSecondUser());
    } catch (e) {
      log.e("Error at updating status:$e");
    }
  }

  Future<void> deleteByID(String id) async {
    try {
      await dao.delete(id);
      inboxes.removeWhere((r) => r.id == id);
      //TODO: remove user when inboxes inbox is deleted
    } catch (e) {}
  }

  //? this assumes that there are no group chat and assumes that there are strictly 2 users
  List<String> getInboxSecondUser() {
    return inboxes.map((e) {
      final a = e.userIDs.firstWhere(
        (element) => element != SettingsData().getUser().id,
      );
      return a;
    }).toList();
  }
}
