import 'package:flutter/material.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget({
    super.key,
    required this.color,
    required this.name,
    required this.email,
  });

  final Color color;
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 40,
            child: Icon(Icons.person, size: 60),
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
