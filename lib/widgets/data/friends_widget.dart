import 'package:flutter/material.dart';
import 'package:line/widgets/data/Friend_widget.dart';

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({super.key});
  final count = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Friends",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(
            10,
            (index) => FriendWidget(
              color: _avatarColors[index],
              name: "Alice",
              email: "",
            ),
          ),
        ),
      ],
    );
  }
}

final List<Color> _avatarColors = [
  Colors.redAccent,
  Colors.pinkAccent,
  Colors.orangeAccent,
  Colors.deepOrangeAccent,
  Colors.amber,
  Colors.yellow.shade700,
  Colors.lime.shade600,
  Colors.lightGreen,
  Colors.green,
  Colors.teal,
  Colors.cyan,
  Colors.lightBlue,
  Colors.blueAccent,
  Colors.indigoAccent,
  Colors.purpleAccent,
  Colors.deepPurpleAccent,
  Colors.grey.shade600,
];
