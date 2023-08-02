import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/login/auth.dart';

class RequestListNote {
  static const String baseUrl = Request.endpoint;

  static Future<List<Note>?> getNotes(
      String endpoint, BuildContext context) async {
    final String url = '$baseUrl/$endpoint';
    final AuthService authService = AuthService();

    String? token = await authService.getToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Token': token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Note.fromJson(item)).toList();
      } else if (response.statusCode == 401) {
        await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
        throw Exception('Request error: ${response.statusCode}');
      }
    } catch (e) {
      await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
      throw Exception('Request error: $e');
    }
  }
}
