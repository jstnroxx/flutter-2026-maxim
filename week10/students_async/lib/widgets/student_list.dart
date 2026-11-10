import 'package:flutter/material.dart';

import '../api/fake_api.dart';

class StudentList extends StatelessWidget {
  final List<Student> list;
  final bool compact;

  const StudentList({super.key, required this.list, required this.compact});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          dense: compact,
          leading: CircleAvatar(
            child: Text(list[index].name[0]),
          ),
          title: Text(list[index].name),
          trailing: Text('GPA: ${list[index].gpa ?? '-'}'),
        );
      },
    );
  }
}