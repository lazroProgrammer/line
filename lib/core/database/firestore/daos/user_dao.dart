import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data/app_user.dart';
import 'package:line/core/database/firestore/firestore_crud.dart';

class UserDao extends FirestoreCRUD<AppUser> {
  UserDao({required super.firestore})
    : super(
        collectionPath: AppUser.collectionPath,
        fromJson: AppUser.fromJson,
        toJson: (AppUser user) => user.toJson(),
      );

  Future<AppUser> getByEmailAuth(String email) async {
    final querySnapshot =
        await firestore
            .collection(collectionPath)
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

    return querySnapshot.docs.map((doc) => fromJson(doc.data(), doc.id)).first;
  }

  Future<List<AppUser>> getByName(
    String name, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final cleaned = name.trim().toLowerCase();

    final query = firestore
        .collection(collectionPath)
        .where('name', isGreaterThanOrEqualTo: cleaned)
        .where('name', isLessThan: '${cleaned}z')
        .limit(5);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    return querySnapshot.docs
        .map((doc) => fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<AppUser>> getByEmailSearch(
    String email, {
    DocumentSnapshot? lastVisibleMessage,
  }) async {
    final cleaned = email.trim().toLowerCase();

    final query = firestore
        .collection(collectionPath)
        .where('email', isGreaterThanOrEqualTo: cleaned)
        .where('email', isLessThan: '$cleaned\uf8ff')
        .limit(5);

    final querySnapshot =
        (lastVisibleMessage == null)
            ? await query.get()
            : await query.startAfterDocument(lastVisibleMessage).get();

    return querySnapshot.docs
        .map((doc) => fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<AppUser>> getByIDs(List<String> ids) async {
    if (ids.isEmpty) return [];

    final futures =
        ids.map((id) async {
          final doc = await firestore.collection(collectionPath).doc(id).get();
          if (doc.exists) {
            return fromJson(doc.data()!, doc.id);
          }
          return null;
        }).toList();

    final users = await Future.wait(futures);
    return users.whereType<AppUser>().toList(); // remove nulls
  }
}
