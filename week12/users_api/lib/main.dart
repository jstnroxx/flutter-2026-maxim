import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_api/auth_model.dart';
import 'package:users_api/core/api/api_client.dart';
import 'package:users_api/features/users/user_repository.dart';
import 'package:users_api/users_model.dart';
import 'package:users_api/settings_model.dart';
import 'core/storage/secure_store.dart';

import 'login_screen.dart';
import 'users_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // before any plugin

  final prefs = SharedPreferencesAsync();
  final dark = await prefs.getBool('darkMode') ?? false;
  final city = await prefs.getString('cityFilter'); // String?

  const store = SecureStore();
  final token = await store.readToken();

  final api = ApiClient(http.Client(), store);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => SettingsModel(prefs, dark: dark, city: city),
      ),
      ChangeNotifierProvider(
        create: (_) => UsersModel(UserRepository(api))..load(),
      ),
      ChangeNotifierProvider(
        create: (_) => AuthModel(store, signedIn: token != null),
      ),
      Provider<SecureStore>.value(value: store),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users API',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo, brightness: Brightness.light)),
      darkTheme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark)),
      themeMode: context.watch<SettingsModel>().dark ? ThemeMode.dark : ThemeMode.light,
      home: context.watch<AuthModel>().signedIn ? const UsersScreen() : const LoginScreen(),
    );
  }
}

