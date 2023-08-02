import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';

class SendRequestNote {
  static Future<void> sendRequestNote(
    BuildContext context,
    String idNote,
  ) async {
    try {
      final AuthService authService = AuthService();

      String? token = await authService.getToken();

      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/note/$idNote/claim'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token!,
        },
      );
      if (response.statusCode == 200) {
        print('Richiesta inviata con successo');
      } else {
        print('Errore nell\'invio della richiesta: ${response.statusCode}');
        throw Exception(
            'Errore nell\'ivio della richiesta: ${response.statusCode}');
      }
    } catch (error) {
      print('Errore durante la richiesta della nota: $error');
      throw Exception('Errore durante la  richiesta della nota: $error');
    }
  }
}
