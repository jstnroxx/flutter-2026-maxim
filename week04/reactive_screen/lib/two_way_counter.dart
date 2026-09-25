import 'package:flutter/material.dart';

class TwoWayCounter extends StatefulWidget {
  const TwoWayCounter({super.key});

  @override
  State<TwoWayCounter> createState() => _TwoWayCounterState();
}

class _TwoWayCounterState extends State<TwoWayCounter> {
  int _value = 0;
  bool _saving = false;

  static const savedBar = SnackBar(content: Text('Saved'));

  Future<void> _save() async {
    setState(() {
      _saving = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _saving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(savedBar);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: (_value < 1 || _saving)
                      ? null
                      : () {
                          setState(() {
                            _value--;
                          });
                        },
                  child: const Text('-'),
                ),
                Text('$_value'),
                FilledButton(
                  onPressed: (_saving)
                      ? null
                      : () {
                          setState(() {
                            _value++;
                          });
                        },
                  child: const Text('+'),
                ),
              ],
            ),
            FilledButton(
              onPressed: (_saving) ? null : _save,
              child: (_saving)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
