import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

class FriendRequest {
  final String id;
  final Timestamp createdAt;
  final DocumentReference sender;
  final DocumentReference receiver;
  final String status;

  FriendRequest({
    this.id = "",
    required this.createdAt,
    required this.sender,
    required this.receiver,
    required this.status,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json, String id) {
    try {
      return FriendRequest(
        id: id,
        createdAt: json['created_at'] as Timestamp? ?? Timestamp.now(),
        sender: json['sender'] as DocumentReference,
        receiver: json['receiver'] as DocumentReference,
        status: json['status'] as String,
      );
    } catch (e) {
      log.e("Exception: $e");
      throw FormatException('FriendRequest.fromJson failed: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'sender': sender,
      'receiver': receiver,
      'status': status,
    };
  }
}
