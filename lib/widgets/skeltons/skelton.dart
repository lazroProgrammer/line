import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Color color = Colors.grey[300]!;

class Skelton extends StatelessWidget {
  const Skelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),

        height: 80,
        child: Row(
          children: [
            CircleAvatar(radius: 40, backgroundColor: color),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    height: 18,
                    width: 100,
                    color: color,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 12,
                    width: 200,
                    color: color,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 12,
                    width: 200,
                    color: color,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 20,
                    width: 80,
                    color: color,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
