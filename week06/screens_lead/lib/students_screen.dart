import 'package:flutter/material.dart';

import 'students.dart';
import 'detail_screen.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key, required this._students});

  final List<Student> _students;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(_students[index].name[0]),
            ),
            title: Text(_students[index].name),
            subtitle: Text(_students[index].group),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailScreen(student: _students[index]),
              ));
            },
          );
        },
      ),
    );
  }
}