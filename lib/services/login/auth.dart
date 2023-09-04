import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

    _handleHttpResponse(response, 'Failed to login');

    var data = jsonDecode(response.body);

    final jwtPayload = json.decode(ascii.decode(
        base64.decode(base64.normalize(data['authToken'].split(".")[1]))));
    final expiryDate =
        DateTime.fromMillisecondsSinceEpoch(jwtPayload['exp'] * 1000);
    await _secureStorage.write(
        key: 'tokenExpiryDate', value: expiryDate.toIso8601String());

    await _secureStorage.write(
      key: 'authToken',
      value: data['authToken'],
    );

    await _secureStorage.write(
      key: 'refreshToken',
      value: data['refreshToken'],
    );
  }

  Future<void> refreshToken() async {
    final String refreshUrl = '${Request.endpoint}/login/refresh';
    final refreshToken = await _secureStorage.read(key: 'refreshToken');

    if (refreshToken == null) {
      await logout(null); // Logout if no refresh token found
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
      await _secureStorage.write(key: 'authToken', value: data['authToken']);
    } else {
      await logout(null); // Force the user to log in again.
      throw Exception('Failed to refresh token');
    }
  }

  Future<String?> getToken() async {
    final expiryDateString = await _secureStorage.read(key: 'tokenExpiryDate');
    if (expiryDateString != null &&
        DateTime.now().isAfter(DateTime.parse(expiryDateString))) {
      try {
        await refreshToken();
      } catch (error) {
        print('Errore durante il refresh: $error');
        
      }
    }
    return await _secureStorage.read(key: 'authToken');
  }

  Future<void> logout(BuildContext? context) async {
    // Elimina tutti i dati memorizzati
    await _secureStorage.deleteAll();

    // If context is available, navigate to login
    if (context != null) {
      // Naviga alla schermata di login e rimuovi tutte le altre schermate dallo stack
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.login_signin,
        (route) => false,
      );
    }
  }

  void _handleHttpResponse(http.Response response, String errorMessage) {
    if (response.statusCode != 200) {
      throw Exception(errorMessage);
    }
  }

  Future<bool> isTokenValid() async {
    final token = await getToken();
    return token != null;
  }
}
