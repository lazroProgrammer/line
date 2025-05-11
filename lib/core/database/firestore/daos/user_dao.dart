import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

class UserDao extends FirestoreCRUD<AppUser> {
  UserDao({required super.firestore})
    : super(
        collectionPath: 'users',
        fromJson: AppUser.fromJson,
        toJson: (AppUser user) => user.toJson(),
      );

  Future<List<AppUser>> getByEmail(String email) async {
    final querySnapshot =
        await firestore
            .collection(collectionPath)
            .where('email', isEqualTo: email)
            .get();

    return querySnapshot.docs
        .map((doc) => fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<AppUser>> getByName(
    String name, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final query = firestore
        .collection(collectionPath)
        .where('name', isEqualTo: name)
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
