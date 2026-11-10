import 'package:flutter/material.dart';

import 'api/fake_api.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';
import 'widgets/empty_view.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student>? _students;
  Object? _error;

  final _api = FakeApi();

  Future<void> _load () async {
    setState(() {
      _students = null;
      _error = null;
    });

    try {
      final list = await _api.fetchStudents();

      if (!mounted) return;

      setState(() {
        _students = list;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _load();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return ErrorView(onRetry: _load);
    }

    if (_students == null) {
      return LoadingView();
    }

    if (_students!.isEmpty) {
      return EmptyView();
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: _students!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(_students![index].name[0]),
            ),
            title: Text(_students![index].name),
            trailing: Text('GPA: ${_students![index].gpa ?? '-'}'),
          );
        },
      ),
    );
  }
}