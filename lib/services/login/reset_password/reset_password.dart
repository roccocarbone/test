import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';

class ResetPassword {
  static Future<void> sendEmailCode(BuildContext context, String email) async {
    try {
      final Map<String, String> body = {
        'email': email,
      };

      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/passwordRecovery/code'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          body,
        ),
      );
      if (response.statusCode == 200) {
        // L'aggiornamento del profilo è stato eseguito con successo
        print('Codice inviato per email');
      } else {
        // Gestisci l'errore in base al codice di stato della risposta
        print('Errore nell\'invio del codice: ${response.statusCode}');
        throw Exception('Errore nell\'ivio del codice: ${response.statusCode}');
      }
    } catch (error) {
      // Gestisci eventuali errori di connessione o eccezioni
      print('Errore durante la richiesta di invio codice: $error');
      throw Exception('Errore durante la richiesta di invio codice: $error');
    }
  }

  static Future<void> resetPassword(
    BuildContext context,
    String email,
    int code,
    String password,
  ) async {
    try {
      final Map<String, dynamic> body = {
        'email': email,
        'code': code,
        'password': password,
      };

      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/passwordRecovery'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Password resettata con successo');
      } else {
        print('Errore nel reset della password: ${response.statusCode}');
        throw Exception(
            'Errore nel reset della password: ${response.statusCode}');
      }
    } catch (error) {
      print('Errore durante la richiesta di reset della password: $error');
      throw Exception(
          'Errore durante la richiesta di reset della password: $error');
    }
  }
}
