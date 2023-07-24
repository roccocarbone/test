import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class GetMyNote {
  static const String _baseUrl = Request.endpoint;

  static Future<List<Note>>? getMyNotes(BuildContext context, String idUser) async {
    final String fullUrl = '$_baseUrl/note/user/$idUser';
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
        Iterable body = jsonDecode(response.body);
        List<Note> notes = body.map((e) => Note.fromJson(e)).toList();
        return notes;
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      await authService.logout(context);
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
