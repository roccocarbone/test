import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';

class UpdateProfile {
  static Future<void> updateProfile(
    Map<String, dynamic> profileData,
    BuildContext context,
  ) async {
    String body = json.encode(profileData);

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token!,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // L'aggiornamento del profilo è stato eseguito con successo
        print('Profilo aggiornato correttamente');
      } else if (response.statusCode == 401) {
        await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
        throw Exception('Request error: ${response.statusCode}');
      } else {
        // Gestisci l'errore in base al codice di stato della risposta
        print('Errore nell\'aggiornamento del profilo: ${response.statusCode}');
        throw Exception(
            'Errore nell\'aggiornamento del profilo: ${response.statusCode}');
      }
    } catch (error) {
      // Gestisci eventuali errori di connessione o eccezioni
      print('Errore durante la richiesta di aggiornamento del profilo: $error');
      throw Exception(
          'Errore durante la richiesta di aggiornamento del profilo: $error');
    }
  }
}
