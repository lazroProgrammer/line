import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataObj {
  String id = "";
  DocumentReference getRef();
}
