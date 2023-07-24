import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:student_link/routings/routes.dart';

class AuthService {
  final String _loginUrl = 'https://testing.studentlink.cloud/v1/login';

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

      print(data['authToken']);
      await _secureStorage.write(
        key: 'authToken',
        value: data['authToken'],
      );
    } else {
      throw Exception('Failed to login');
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
