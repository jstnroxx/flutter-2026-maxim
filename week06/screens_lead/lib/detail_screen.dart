import 'package:flutter/material.dart';

import 'students.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this._student});

  final Student _student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_student.name),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.school),
            title: Text(_student.group),
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text(_student.email),
          ),
        ],
      ),
    );
  }
}