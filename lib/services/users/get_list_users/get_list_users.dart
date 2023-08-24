import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class GetListUsers {
  static const String _baseUrl = Request.endpoint;

  static Future<List<User>> getUsers(BuildContext context, int page) async {
    final String fullUrl = '$_baseUrl/users?page=$page&search=.'; //TODO: PAGINAZIONE
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
        List<dynamic> body = jsonDecode(response.body);

        List<User> users =
            body.map((userJson) => User.fromJson(userJson)).toList();
        return users;
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      //TODO: DA ERRORE QUANDO IL TOKEN NON è VALIDO, VERIFICARE IL REFRESH
      await authService.logout(context);

      // Effettua il logout dell'utente
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
