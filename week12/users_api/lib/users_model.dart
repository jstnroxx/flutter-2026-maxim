import 'package:flutter/foundation.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/features/users/user.dart';
import 'package:users_api/features/users/user_repository.dart';

typedef UsersResult = ({List<User> items, bool fromCache});

class UsersModel extends ChangeNotifier {
  final UserRepository _repo;

  List<User> items = const [];
  ApiException? error;
  bool loading = false;
  bool fromCache = false;

  UsersModel(this._repo);

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final UsersResult result = await _repo.getAll();

      items = result.items;
      fromCache = result.fromCache;
    } on ApiException catch (e) {
      error = e;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<ApiException?> create(User draft) async {
    try {
      final User created = await _repo.create(draft);
      items = [created, ...items];
      notifyListeners();
      return null;
    } on ApiException catch (e) {
      return e;
    }
  }
}
