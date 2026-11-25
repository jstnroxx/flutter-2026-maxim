import 'package:users_api/core/api/api_client.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/features/users/user.dart';
import 'users_cache.dart';

typedef UsersResult = ({List<User> items, bool fromCache});

class UserRepository {
  final ApiClient _api;
  final UsersCache _cache;

  const UserRepository(this._api, this._cache);

  Future<List<User>> _fetch() async {
    final dynamic body = await _api.get('/users');

    try {
      final List<dynamic> list = body as List<dynamic>;

      return list
          .map((dynamic entry) => User.fromJson(entry as Map<String, dynamic>))
          .toList();
    } on TypeError catch (e) {
      throw BadResponseException('users: $e');
    }
  }

  Future<UsersResult> getAll() async {
    try {
      final fresh = await _fetch();
      await _cache.save(fresh);

      return (items: fresh, fromCache: false);
    } on NoConnectionException {
      final saved = await _cache.load();
      if (saved == null) rethrow;

      return (items: saved, fromCache: true);
    }
  }

  Future<User> getById(int id) async {
    final dynamic body = await _api.get('/users/$id');

    try {
      return User.fromJson(body as Map<String, dynamic>);
    } on TypeError catch (e) {
      throw BadResponseException('users: $e');
    }
  }

  Future<User> create(User draft) async {
    final dynamic body = await _api.post('/users', draft.toJson());

    try {
      return User.fromJson(body as Map<String, dynamic>);
    } on TypeError catch (e) {
      throw BadResponseException('users: $e');
    }
  }
}
