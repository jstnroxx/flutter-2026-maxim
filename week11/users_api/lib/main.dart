import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:users_api/core/api/api_client.dart';
import 'package:users_api/features/users/user_repository.dart';
import 'package:users_api/users_model.dart';

import 'users_screen.dart';

void main() {
  return runApp(
    ChangeNotifierProvider(
      create: (_) =>
          UsersModel(UserRepository(ApiClient(http.Client())))..load(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users API',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: UsersScreen(),
    );
  }
}
