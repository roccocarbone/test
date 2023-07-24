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

  static Future<void> uploadFile(
      PlatformFile file, String noteId, BuildContext context) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    var uri = Uri.parse('${Request.endpoint}/note/$noteId/upload');

    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll({
        'Token': token!,
      })
      ..files.add(await http.MultipartFile.fromPath(
        'file', // considera di cambiare 'file' con il nome appropriato
        file.path!,
        filename: file.name, // usa il nome originale del file
      ));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Upload riuscito!');
    } else if (response.statusCode == 401) {
      await authService.logout(context);
      throw Exception('Request error: ${response.statusCode}');
    } else {
      throw Exception(
          'Errore durante l\'upload del file: ${response.statusCode}');
    }
  }

  static Future<bool> uploadPreview(File imageFile, Note note) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token != null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Request.endpoint}/note/${note.id}/preview'));
      request.headers['Token'] = token;
      request.files
          .add(await http.MultipartFile.fromPath('photo', imageFile.path));

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          print('Immagine inviata con successo');
          return true;
        } else {
          print(
              'Errore durante l\'invio dell\'immagine: ${response.statusCode}');
          return false;
        }
      } catch (e) {
        print('Errore durante la richiesta: $e');
        return false;
      }
    } else {
      print('Token di autenticazione non disponibile');
      return false;
    }
  }
}
