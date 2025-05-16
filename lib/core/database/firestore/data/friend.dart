import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

class Friend {
  final String id;
  final Timestamp createdAt;
  final DocumentReference sender;
  final DocumentReference receiver;

  Friend({
    this.id = "",
    required this.createdAt,
    required this.sender,
    required this.receiver,
  });

  factory Friend.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Friend(
        id: id,
        createdAt: json['created_at'] as Timestamp? ?? Timestamp.now(),
        sender: json['sender'] as DocumentReference,
        receiver: json['receiver'] as DocumentReference,
      );
    } catch (e) {
      log.e("Exception: $e");
      throw FormatException('Friend.fromJson failed: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {'createdAt': createdAt, 'sender': sender, 'receiver': receiver};
  }
}
