import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class ProfileMe {
  static const String _baseUrl = Request.endpoint;

  static Future<User> getMyProfile(
     BuildContext context) async {
    final String fullUrl = '$_baseUrl/profile/me';
    final AuthService authService = AuthService();

    String? token = await authService.getToken();

    try {
      final response = await http.get(
        Uri.parse(fullUrl),
        headers: {
          'Token': token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        User user = User.fromJson(body['profile']);
        return user;
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      await authService.logout(context);
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
