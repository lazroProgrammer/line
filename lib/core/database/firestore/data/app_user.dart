import 'package:logger/logger.dart';

Logger log = Logger();

class AppUser {
  final String id;
  final String email;
  final String name;

  AppUser({this.id = "", required this.email, required this.name});

  factory AppUser.fromJson(Map<String, dynamic> json, String id) {
    try {
      return AppUser(
        id: id,
        email: json['email'] as String? ?? '',
        name: json['name'] as String? ?? '',
      );
    } catch (e) {
      throw FormatException('AppUser.fromJson failed: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }
}
