import 'package:flutter/material.dart';

import 'students.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.student});

  final Student student;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String _name = widget.student.name;

  Future<bool?> _showPopAlert() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          actions: [
            TextButton(
              child: const Text('Keep editing'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Discard'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  bool get _dirty => _name != widget.student.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit student')),
      body: PopScope(
        canPop: !_dirty,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;

          final bool shouldPop = await _showPopAlert() ?? false;

          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => setState(() => _name = value),
                ),
              ),
              const SizedBox(width: 16.0),
              FilledButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop(_name);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
