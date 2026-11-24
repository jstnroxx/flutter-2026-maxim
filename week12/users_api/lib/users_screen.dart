import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/users_model.dart';

import 'user_detail_screen.dart';
import 'new_user_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  Widget _buildBody(BuildContext context, UsersModel m) {
    if (m.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return switch (m.error) {
      null => RefreshIndicator(
        onRefresh: m.load,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: m.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => UserDetailScreen(user: m.items[index]),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(m.items[index].name[0]),
                      ),
                      title: Text(m.items[index].name),
                      subtitle: Text(m.items[index].address.city),
                      trailing: Text(m.items[index].email),
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

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildBody(context, m),
      ),
    );
  }
}
