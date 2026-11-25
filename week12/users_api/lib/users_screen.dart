import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/settings_model.dart';
import 'package:users_api/users_model.dart';

import 'features/users/user.dart';
import 'user_detail_screen.dart';
import 'new_user_screen.dart';
import 'settings_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  Widget _buildBody(BuildContext context, UsersModel m, String? city) {
    if (m.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<User> visible = city == null ? m.items : m.items.where((user) => user.address.city == city).toList();

    return switch (m.error) {
      null => RefreshIndicator(
        onRefresh: m.load,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: visible.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UserDetailScreen(user: visible[index]),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(visible[index].name[0]),
                      ),
                      title: Text(visible[index].name),
                      subtitle: Text(visible[index].address.city),
                      trailing: Text(visible[index].email),
                    ),
                  );
                },
                separatorBuilder: (_, _) {
                  return const Divider();
                },
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => NewUserScreen())),
              child: const Text('New user'),
            ),
          ],
        ),
      ),
      NoConnectionException() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No connection.'),
            FilledButton(onPressed: m.load, child: const Text('Retry')),
          ],
        ),
      ),
      NotFoundException() || UnauthorizedException() => Center(
        child: const Text('Not found or unauthorized.'),
      ),
      ServerException(:final int status) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Status: $status'),
            TextButton(onPressed: m.load, child: const Text('Retry')),
          ],
        ),
      ),
      BadResponseException() => const Center(
        child: Text('Something went wrong.'),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final UsersModel m = context.watch<UsersModel>();
    final String? city = context.watch<SettingsModel>().city;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actionsPadding: const EdgeInsets.all(8.0),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          if (m.fromCache)
            MaterialBanner(
              content: const Text('Saved data'),
              actions: [TextButton(onPressed: m.load, child: const Text('Retry'))],
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _buildBody(context, m, city),
            ),
          ),
        ],
      ),
    );
  }
}
