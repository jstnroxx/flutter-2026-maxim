import 'package:flutter/material.dart';

import 'api/fake_api.dart';
import 'students_screen.dart';
import 'students_future_screen.dart';
import 'countdown_screen.dart';

void main() {
  print('A');
  Future.delayed(const Duration(seconds: 2), () => print('B'));
  print('C');

  final api = FakeApi();
  api.fetchStudents().then((l) => print('${l.length} students'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentsScreen())),
              child: Text('By hand'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StudentsFutureScreen())),
              child: Text('FutureBuilder'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CountdownScreen())),
              child: Text('Countdown'),
            ),
          ],
        ),
      ),
    );
  }
}
