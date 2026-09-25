import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchCard extends StatefulWidget {
  const StopwatchCard({super.key});

  @override
  State<StopwatchCard> createState() => _StopwatchCardState();
}

class _StopwatchCardState extends State<StopwatchCard> {
  int _seconds = 0;
  Timer? _timer;

  void _runTimer() {
    setState(() {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    });
  }

  String get _time =>
      '${(_seconds ~/ 60).toString().padLeft(2, "0")}:${(_seconds % 60).toString().padLeft(2, "0")}';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_time),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: (_timer?.isActive ?? false) ? null : _runTimer,
                  child: const Text('Start'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _timer?.cancel();

                    setState(() {
                      _seconds = 0;
                    });
                  },
                  child: const Text('Reset'),
                ),
                FilledButton(
                  onPressed: () {
                    _timer?.cancel();

                    setState(() {
                      _timer = null;
                    });
                  },
                  child: const Text('Stop'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
