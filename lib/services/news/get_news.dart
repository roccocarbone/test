import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/models/news/news.dart';
import 'package:student_link/services/login/auth.dart';

class NewsServices {
  static const String _baseUrl = Request.endpoint;

  static Future<List<NewsModel>> getNews(BuildContext context) async {
    final String fullUrl = '$_baseUrl/news';
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
        List<NewsModel> newsList =
            jsonData.map((item) => NewsModel.fromJson(item)).toList();
        return newsList;
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
