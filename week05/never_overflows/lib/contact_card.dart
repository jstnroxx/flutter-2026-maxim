import 'package:flutter/material.dart';
import 'contacts.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this._contact});

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),

        // 140
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  child: Text(_contact.initial),
                ),
                if (_contact.unread > 0) Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.error,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _contact.unread.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _contact.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _contact.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}