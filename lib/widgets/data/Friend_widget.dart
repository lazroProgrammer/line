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
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 6),
      // elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 40,
              child: Icon(Icons.person, size: 65),
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
