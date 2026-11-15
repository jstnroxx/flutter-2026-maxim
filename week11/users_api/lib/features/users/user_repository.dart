import 'package:users_api/core/api/api_client.dart';
import 'package:users_api/core/api/api_exception.dart';
import 'package:users_api/features/users/user.dart';

class UserRepository {
  final ApiClient _api;

  const UserRepository(this._api);

  Future<List<User>> getAll() async {
    final dynamic body = await _api.get('/users');

    try {
      final List<dynamic> list = body as List<dynamic>;

      return list.map((dynamic entry) => User.fromJson(entry as Map<String, dynamic>)).toList();
    } on TypeError catch (e) {
      throw BadResponseException('users: $e');
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