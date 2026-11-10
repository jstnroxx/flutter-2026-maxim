import 'dart:async';

import 'package:flutter/material.dart';

import 'api/countdown.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  final int from = 10;
  late Stream<int> _stream = countdown(from);

  int _left = 10;
  late StreamSubscription<int> _sub;

  bool _isVersionA = true;

  @override
  void initState() {
    super.initState();

    _sub = countdown(10).listen((i) => setState(() => _left = i));
  }

  @override
  void dispose() {
    _sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SegmentedButton<bool>(
            segments: [
              ButtonSegment(
                value: true,
                label: const Text('Version A'),
              ),
              ButtonSegment(
                value: false,
                label: const Text('Version B'),
              ),
            ],
            selected: {_isVersionA},
            onSelectionChanged: (Set<bool> newSelection) {
              setState(() {
                _isVersionA = newSelection.first;

                if (_isVersionA) {
                  setState(() {
                    _stream = countdown(from);
                  });
                }
              });
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Center(
              child: _isVersionA ?
              StreamBuilder(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                    '${snapshot.data ?? from}',
                    style: Theme.of(context).textTheme.displayLarge,
                  );
                },
              )
              : Text(
                '$_left',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}