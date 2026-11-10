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

  bool _saving = false;

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
      body: Column(
        children: [
          Expanded(
              child: StudentList(
                list: _students!,
                compact: false,
              ),
          ),
          const SizedBox(height: 8.0),
          SafeArea(
            child: FloatingActionButton(
              onPressed: _saving ?
              null
              : () async {
                try {
                  setState(() {
                    _saving = true;
                  });

                  await _api.save(_students!.length);

                  if (!context.mounted) return;

                  Navigator.pop(context);
                } on StateError catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
                } finally {
                  if (mounted) {
                    setState(() {
                      _saving = false;
                    });
                  }
                }
              },
              child: _saving ?
              CircularProgressIndicator()
              : const Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}