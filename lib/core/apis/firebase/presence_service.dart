import 'package:firebase_database/firebase_database.dart';

// not used currently
class PresenceService {
  final DatabaseReference _statusRef;
  final DatabaseReference _connectedRef;
  final String userId;

  PresenceService({required this.userId})
    : _statusRef = FirebaseDatabase.instance.ref("status/$userId"),
      _connectedRef = FirebaseDatabase.instance.ref(".info/connected");

  void init() {
    Map<String, dynamic> onlineStatus = {
      "state": "online",
      "last_changed": ServerValue.timestamp,
    };

    Map<String, dynamic> offlineStatus = {
      "state": "offline",
      "last_changed": ServerValue.timestamp,
    };

    _connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) {
        _statusRef.onDisconnect().set(offlineStatus).then((_) {
          _statusRef.set(onlineStatus);
        });
      }
    });
  }

  Stream<String> userStatusStream() {
    return _statusRef.onValue.map((event) {
      final status = event.snapshot.value as Map?;
      return status?["state"] ?? "offline";
    });
  }

  Future<void> dispose() async {
    // Optionally set offline on dispose
    await _statusRef.set({
      "state": "offline",
      "last_changed": ServerValue.timestamp,
    });
  }
}
