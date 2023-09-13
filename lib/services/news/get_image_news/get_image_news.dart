import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';

class NewsImageServices {
  static const String _baseUrl = Request.endpoint;

  static Future<ImageProvider> getNewsImage(
      BuildContext context, String id) async {
    final String fullUrl = '$_baseUrl/news/$id/image';
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
       
        return MemoryImage(response.bodyBytes);
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      // TODO: DA ERRORE QUANDO IL TOKEN NON è VALIDO, VERIFICARE IL REFRESH
      await authService.logout(context);

      
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
