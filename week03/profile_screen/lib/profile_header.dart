import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String university;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.university,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/monkey.jpg'),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          university,
          style: TextStyle(
            fontFamily: 'GoogleSans',
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
