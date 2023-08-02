import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;


class AcceptRequest{
  static Future<bool> acceptRequest(
    Map<String, dynamic> noteData,
    String idNote,
    BuildContext context,
  ) async {
    String body = json.encode(noteData);

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/note/claim/$idNote'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token!,
        },
        body: body,
      );

      if (response.statusCode == 200) {
       
        print('Nota accettata correttamente');
        return true;
      } else if (response.statusCode == 401) {
        await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
        throw Exception('Request error: ${response.statusCode}');
      } else {
        throw Exception(
            'Errore nell\'accettazione della nota: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Errore durante la richiesta di accettazione nota: $error');
    }
  }
}