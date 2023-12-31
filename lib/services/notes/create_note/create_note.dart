import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class CreateNote {
  static Future<Note> createNote(
    Map<String, dynamic> profileData,
    BuildContext context,
  ) async {
    String body = json.encode(profileData);

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse('${Request.endpoint}/note'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token!,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        Note note = Note.fromJson(json);
        print('Nota creata correttamente');
        return note;
      } else if (response.statusCode == 401) {
        await authService.logout(context); //TODO: VERIFICARE DISCONESSIONE
        throw Exception('Request error: ${response.statusCode}');
      } else {
        throw Exception(
            'Errore nell\'aggiornamento del profilo: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Errore durante la richiesta di aggiornamento del profilo: $error');
    }
  }
}
