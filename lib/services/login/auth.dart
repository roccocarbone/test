import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:student_link/routings/routes.dart';
import 'package:student_link/constant.dart';

class AuthService {
  final String _loginUrl = '${Request.endpoint}/login';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    var body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      await _secureStorage.write(
        key: 'authToken',
        value: data['authToken'],
      );

      await _secureStorage.write(
        key: 'refreshToken',
        value: data['refreshToken'],
      );
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> refreshToken() async {
    final String refreshUrl = '${Request.endpoint}/login/refresh';
    final refreshToken = await _secureStorage.read(key: 'refreshToken');

    print('REFRESHHHH');
    print(refreshToken);

    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    var body = jsonEncode(<String, String>{
      'refreshToken': refreshToken,
    });

    final response = await http.post(
      Uri.parse(refreshUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      await _secureStorage.write(
        key: 'authToken',
        value: data['authToken'],
      );
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'authToken');
  }

  Future<void> logout(BuildContext context) async {
    // Elimina tutti i dati memorizzati
    await _secureStorage.deleteAll();

    // Naviga alla schermata di login e rimuovi tutte le altre schermate dallo stack
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.login_signin,
      (route) => false,
    );
  }
}
