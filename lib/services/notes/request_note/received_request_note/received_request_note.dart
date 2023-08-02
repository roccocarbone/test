import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;
import '../../../../models/notes/request_note/request_note.dart';

class ReceivedRequestNote{
  static const String _baseUrl = Request.endpoint;

  static Future<List<RequestNote>> myReceivedRequestNote(
      BuildContext context, int page) async {
    final String fullUrl = '$_baseUrl/note/claims/received?page=$page';
    
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
        List<dynamic> jsonData = json.decode(response.body);
        List<RequestNote> requestNoteList =
            jsonData.map((item) => RequestNote.fromJson(item)).toList();
        return requestNoteList;
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      // TODO: DA ERRORE QUANDO IL TOKEN NON è VALIDO, VERIFICARE IL REFRESH
      await authService.logout(context);

      // Effettua il logout dell'utente
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}