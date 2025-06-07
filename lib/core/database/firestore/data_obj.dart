import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataObj {
  DocumentReference getRef();
}
