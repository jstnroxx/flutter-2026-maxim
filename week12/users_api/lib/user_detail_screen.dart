import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:users_api/features/users/user.dart';

import 'core/storage/secure_store.dart';

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
                if (kDebugMode)
                  OutlinedButton(
                    onPressed: () async {
                      final String? token = await context.read<SecureStore>().readToken();
                      if (token == null) return;

                      await Clipboard.setData(ClipboardData(text: token));
                      if (!context.mounted) return;
                      
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Token copied')),
                      );
                    },
                    child: const Text('Copy token to clipboard'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
