import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data_obj.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

class Message extends DataObj {
  static String collectionPath = "messages";
  final String id;
  final Map<String, dynamic> content;
  final Timestamp createdAt;
  final DocumentReference inboxRef;
  final bool isArchived;
  final bool isEdited;
  final Timestamp lastUpdate;
  final DocumentReference sender;

  Message({
    this.id = "",
    required this.content,
    required this.createdAt,
    required this.inboxRef,
    required this.isArchived,
    required this.isEdited,
    required this.lastUpdate,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Message(
        id: id,
        content: Map<String, dynamic>.from(json['content'] ?? {}),
        createdAt: json['created_at'] as Timestamp? ?? Timestamp.now(),
        inboxRef: json['inboxRef'] as DocumentReference,
        isArchived: json['isArchived'] as bool? ?? false,
        isEdited: json['isEdited'] as bool? ?? false,
        lastUpdate: json['lastUpdate'] as Timestamp? ?? Timestamp.now(),
        sender: json['sender'] as DocumentReference,
      );
    } catch (e) {
      log.e("Exception: $e");
      throw FormatException('Message.fromJson failed: $e');
    }
  }

  //TODO: make sure if the toJson() functions should have the id in them or not
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'created_at': createdAt,
      'inboxRef': inboxRef,
      'isArchived': isArchived,
      'isEdited': isEdited,
      'lastUpdate': lastUpdate,
      'sender': sender,
    };
  }

  static Map<String, dynamic> getContent(dynamic obj, {String? format}) {
    String type;
    String dataType;

    if (obj is String) {
      type = 'text';
      dataType = 'text/plain';
    } else if (obj is Uint8List) {
      throw UnimplementedError();
    } else {
      throw Exception("type not supported");
    }

    return {"type": type, "data": obj, "dataType": dataType};
  }

  @override
  DocumentReference<Object?> getRef() {
    return FirebaseFirestore.instance.collection(collectionPath).doc(id);
  }
}
