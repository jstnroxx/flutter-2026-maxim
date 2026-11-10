import 'package:flutter/material.dart';

import 'api/fake_api.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';
import 'widgets/empty_view.dart';
import 'widgets/student_list.dart';

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
      appBar: AppBar(),
      body: StudentList(
          list: _students!,
          compact: false,
      ),
    );
  }
}