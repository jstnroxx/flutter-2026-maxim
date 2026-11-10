import 'package:flutter/material.dart';

import 'api/fake_api.dart';
import 'widgets/error_view.dart';
import 'widgets/loading_view.dart';
import 'widgets/empty_view.dart';
import 'widgets/student_list.dart';

class StudentsFutureScreen extends StatefulWidget {
  const StudentsFutureScreen({super.key});

  @override
  State<StudentsFutureScreen> createState() => _StudentsFutureScreenState();
}

class _StudentsFutureScreenState extends State<StudentsFutureScreen> {
  final _api = FakeApi();
  bool _compact = false;

  late Future<List<Student>> _future;

  void _retry () {
    setState(() {
      _future = _api.fetchStudents();
    });
  }

  @override
  void initState() {
    super.initState();

    _future = _api.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Compact'),
            const SizedBox(width: 8.0),
            Switch(
              value: _compact,
              onChanged: (bool value) {
                setState(() {
                  _compact = value;
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return ErrorView(onRetry: _retry);
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return LoadingView();
            }

            final list = snapshot.data ?? const [];
            if (list.isEmpty) {
              return EmptyView();
            }

            return StudentList(
              list: list,
              compact: _compact,
            );
          },
      ),
    );
  }
}