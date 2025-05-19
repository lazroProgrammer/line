import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data_obj.dart';

//TODO: think about friends and friend_requests collections, you may add them or embed them or both, choose wisely
class FirestoreCRUD<T extends DataObj> {
  final FirebaseFirestore firestore;
  final String collectionPath;
  final T Function(Map<String, dynamic> json, String id) fromJson;
  final Map<String, dynamic> Function(T item) toJson;

  FirestoreCRUD({
    required this.firestore,
    required this.collectionPath,
    required this.fromJson,
    required this.toJson,
  });

  CollectionReference get collection => firestore.collection(collectionPath);

  Future<T?> getById(String id) async {
    final doc = await collection.doc(id).get();
    if (!doc.exists) return null;
    return fromJson(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<String> add(T item, {String? id}) async {
    final docRef = id != null ? collection.doc(id) : collection.doc();

    await docRef.set(toJson(item));
    return docRef.id;
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await collection.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await collection.doc(id).delete();
  }
}
