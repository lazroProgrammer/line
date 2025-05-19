import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line/core/database/firestore/data_obj.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

class Inbox extends DataObj {
  static String collectionPath = 'inboxes';

  final String id; // Firestore document ID
  final String lastMessage;
  final Timestamp lastUpdated;
  final List<DocumentReference> userIDs;

  Inbox({
    this.id = "",
    required this.lastMessage,
    required this.lastUpdated,
    required this.userIDs,
  });

  factory Inbox.fromJson(Map<String, dynamic> json, String id) {
    try {
      return Inbox(
        id: id,
        lastMessage: json['lastMessage'] as String? ?? '',
        lastUpdated: json['lastUpdated'] as Timestamp? ?? Timestamp.now(),
        userIDs:
            (json['userIDs'] as List?)
                ?.whereType<DocumentReference>()
                .toList() ??
            [],
      );
    } catch (e) {
      log.e("Exception: $e");
      throw FormatException('Inbox.fromJson failed: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastUpdated': lastUpdated,
      'userIDs': userIDs,
    };
  }

  @override
  DocumentReference<Object?> getRef() {
    return FirebaseFirestore.instance.collection(collectionPath).doc(id);
  }
}
