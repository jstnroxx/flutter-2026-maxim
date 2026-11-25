import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'user.dart';

class UsersCache {
  const UsersCache();

  static const String _filename = 'users.json';

  Future<File> _file() async {
    final Directory dir = await getApplicationDocumentsDirectory();

    return File('${dir.path}/$_filename');
  }

  Future<void> save(List<User> users) async {
    final File file = await _file();

    await file.writeAsString(
      jsonEncode([for (final User u in users) u.toJson()]),
    );
  }

  Future<List<User>?> load() async {
    final File file = await _file();
    if (!await file.exists()) return null;

    try {
      final List<dynamic> rawData = jsonDecode(await file.readAsString()) as List<dynamic>;

      return [
        for (final dynamic item in rawData)
          User.fromJson(item as Map<String, dynamic>),
      ];
    } on FormatException {
      return null;
    }
  }
}