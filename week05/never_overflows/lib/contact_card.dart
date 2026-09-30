import 'package:flutter/material.dart';
import 'contacts.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this._contact});

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),

        // 140
        child: Row(
          children: [
            CircleAvatar(
              child: Text(_contact.initial),
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