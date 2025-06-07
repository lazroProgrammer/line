import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data_obj.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

class FriendRequest extends DataObj {
  static String collectionPath = 'friend_requests';

  final String id;
  final Timestamp createdAt;
  final String sender;
  final String receiver;
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
        createdAt: json['createdAt'] as Timestamp,
        sender: json['sender'] as String,
        receiver: json['receiver'] as String,
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

  static List<String> getUsers(
    List<FriendRequest> friendRequests, {
    required bool isSender,
  }) {
    List<String> e = [];
    for (var element in friendRequests) {
      e.add(isSender ? element.sender : element.receiver);
    }
    return e;
  }

  @override
  DocumentReference<Object?> getRef() {
    return FirebaseFirestore.instance.collection(collectionPath).doc(id);
  }
}
