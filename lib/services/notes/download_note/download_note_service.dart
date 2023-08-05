import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class DownloadNote {
  static const String _baseUrl = Request.endpoint;

  static Future<File> getDownloadNote(
      BuildContext context, String idNote) async {
    final String fullUrl = '$_baseUrl/note/$idNote/download';
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
        final bytes = response.bodyBytes;
        final directory = await getApplicationDocumentsDirectory();
        final file = File(
            '${directory.path}/$idNote'); // Qui puoi specificare l'estensione del file in base al tuo caso (ad esempio, .png o .pdf)

        // Scrivi i byte sul file e ritorna il file
        return file.writeAsBytes(bytes);
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      await authService.logout(context);
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
