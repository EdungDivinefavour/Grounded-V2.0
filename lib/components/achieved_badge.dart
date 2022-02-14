import 'package:flutter/material.dart';
import 'package:grounded/models/badge.dart';

class AchievedBadge extends StatelessWidget {
  final Badge badge;
  final bool showTitle;

  AchievedBadge({required this.badge, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
        ),
        Text(badge.name)
      ],
    );
  }
}
