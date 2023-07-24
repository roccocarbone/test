import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class ChangePassword {
  static Future<void> changePassword(
    Map<String, dynamic> profileData,
    BuildContext context,
  ) async {
    String body = json.encode(profileData);

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/profile/password/change'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token!,
        },
        body: body,
      );

      if (response.statusCode == 200) {
 
        print('password aggiornata correttamente');
      } else if (response.statusCode == 401) {
        await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
        throw Exception('Request error: ${response.statusCode}');
      } else {
        // Gestisci l'errore in base al codice di stato della risposta
        print('Errore nell\'aggiornamento della password: ${response.statusCode}');
        throw Exception(
            'Errore nell\'aggiornamento della password: ${response.statusCode}');
      }
    } catch (error) {
      // Gestisci eventuali errori di connessione o eccezioni
      print('Errore durante la richiesta di aggiornamento password: $error');
      throw Exception(
          'Errore durante la richiesta di aggiornamento password: $error');
    }
  }
}
