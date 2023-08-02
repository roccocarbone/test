import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class DeleteNote {
  static Future<void> deleteNote(String noteId, BuildContext context) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    var uri = Uri.parse('${Request.endpoint}/note/$noteId');

    try {
      final response = await http.delete(
        uri,
        headers: {
          'Token': token!,
        },
      );

      if (response.statusCode == 200) {
        print('Nota eliminata correttamente');
      } else if (response.statusCode == 401) {
        await authService.logout(context);
        throw Exception('Request error: ${response.statusCode}');
      } else {
        throw Exception(
            'Errore durante l\'eliminazione della nota: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Errore durante la richiesta di eliminazione della nota: $error');
    }
  }
}
