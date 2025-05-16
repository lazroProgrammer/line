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

  Future<List<AppUser>> getByEmailAuth(String email) async {
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
}
