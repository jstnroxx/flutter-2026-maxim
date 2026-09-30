import 'package:flutter/material.dart';
import 'contacts.dart';
import 'contact_card.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ContactCard(contact: contacts[4]);
  }
}