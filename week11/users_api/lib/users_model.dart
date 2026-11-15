import 'package:flutter/foundation.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/features/users/user.dart';
import 'package:users_api/features/users/user_repository.dart';

class UsersModel extends ChangeNotifier {
  final UserRepository _repo;

  List<User> items = const [];
  ApiException? error;
  bool loading = false;

  UsersModel(this._repo);

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      items = await _repo.getAll();
    } on ApiException catch (e) {
      error = e;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}