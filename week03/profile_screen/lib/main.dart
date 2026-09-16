import 'package:flutter/material.dart';

import 'data.dart';
import 'profile_header.dart';
import 'info_row.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My profile')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProfileHeader(name: myName, university: myUniversity),
              for (final fact in facts)
                InfoRow(label: fact.label, value: fact.value),
            ],
          ),
        ),
      ),
    ),
  );
}
