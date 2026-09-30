import 'package:flutter/material.dart';

import 'contacts.dart';
import 'contact_card.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            '20 contacts',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              return ContactCard(contact: contacts[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(indent: 16, endIndent: 16);
            },
          ),
        ),
      ],
    );
  }
}
