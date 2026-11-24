import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:users_api/core/api/api_exception.dart';

class ApiClient {
  final http.Client _client;
  final String host;

  const ApiClient(this._client, {this.host = 'jsonplaceholder.typicode.com'});

  Future<http.Response> _send(Future<http.Response> Function() call) async {
    try {
      return await call().timeout(const Duration(seconds: 10));
    } on SocketException {
      throw const NoConnectionException();
    } on TimeoutException {
      throw const NoConnectionException();
    }
  }

  void _check(http.Response r) {
    if (r.statusCode == 401) {
      throw const UnauthorizedException();
    } else if (r.statusCode == 404) {
      throw const NotFoundException();
    } else if (r.statusCode >= 500) {
      throw ServerException(r.statusCode);
    }
  }

  dynamic _decode(http.Response r) {
    try {
      return jsonDecode(r.body);
    } on FormatException {
      throw const BadResponseException();
    }
  }

  void _log(http.Response r) {
    if (kDebugMode) {
      log(
        '${r.request?.method} ${r.request?.url.path} → ${r.statusCode}',
        name: 'api',
      );
    }
  }

  Map<String, String> get _headers => {'Accept': 'application/json'};

  Future<dynamic> get(String path) async {
    final Uri uri = Uri.https(host, path);

    final http.Response resp = await _send(
      () => _client.get(uri, headers: _headers),
    );
    _log(resp);
    _check(resp);

    return _decode(resp);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final Uri uri = Uri.https(host, path);

    final http.Response resp = await _send(
      () => _client.post(
        uri,
        headers: {..._headers, 'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ),
    );
    _log(resp);
    _check(resp);

    if (resp.statusCode != 201) {
      throw BadResponseException(
        'POST $path: expected 201, got ${resp.statusCode}',
      );
    }

    return _decode(resp);
  }
}
