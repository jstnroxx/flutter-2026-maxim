import 'package:flutter/foundation.dart';
import 'core/storage/secure_store.dart';

class AuthModel extends ChangeNotifier {
  final SecureStore _store;
  bool _signedIn;

  AuthModel(this._store, {required this._signedIn});

  bool get signedIn => _signedIn;

  Future<void> login(String email, String password) async{
    await Future.delayed(const Duration(seconds: 1));
    if (password.length < 8) throw ArgumentError('Password must be at least 8 characters.');

    await _store.saveToken('tok_${email.hashCode}');

    _signedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _store.clear();

    _signedIn = false;
    notifyListeners();
  }
}