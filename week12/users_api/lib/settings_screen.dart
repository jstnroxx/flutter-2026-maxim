import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_api/auth_model.dart';
import 'settings_model.dart';
import 'users_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsModel settings = context.watch<SettingsModel>();
    final UsersModel usr = context.watch<UsersModel>();
    final AuthModel auth = context.watch<AuthModel>();

    final Set<String> cities = usr.items.map((user) => user.address.city).toSet();
    final String? current = cities.contains(settings.city) ? settings.city : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('App theme'),
                      Expanded(
                        child: SwitchListTile(
                          value: settings.dark,
                          onChanged: settings.setDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Your city'),
                      const Spacer(),
                      Expanded(
                        child: DropdownButtonFormField<String?>(
                          initialValue: current,
                          items: [
                            const DropdownMenuItem(value: null, child: Text('All cities')),

                            for (final String city in cities)
                              DropdownMenuItem<String?>(value: city, child: Text(city)),
                          ],
                          onChanged: settings.setCity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SafeArea(
                child: OutlinedButton(
                  onPressed: () async {
                    await auth.logout();

                    if (!context.mounted) return;

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}