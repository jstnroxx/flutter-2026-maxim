import 'package:flutter/material.dart';
import 'package:users_api/features/users/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64.0,
                  child: Text(
                    user.name[0],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text('also known as ${user.username}'),
                const SizedBox(height: 8),
                const Divider(),
                ListTile(
                  leading: const Text('Phone number'),
                  trailing: Text(user.phone),
                ),
                const Divider(),
                ListTile(
                  leading: const Text('Email'),
                  trailing: Text(user.email),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
