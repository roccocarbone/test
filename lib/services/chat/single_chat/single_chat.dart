import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/chat/message/message_model.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static const String _baseUrl = Request.endpoint;

  static Future<List<MessageModel>> getChatMessages(String chatId) async {
    final AuthService authService = AuthService();
    final String? token = await authService.getToken();

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/chat/$chatId/messages'),
        headers: {
          'Token': token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Errore durante la richiesta dei messaggi: ${response.statusCode}');
      }

      final List<dynamic> data = jsonDecode(response.body);
      return data.map((message) => MessageModel.fromJson(message)).toList();

    } catch (e) {
      throw Exception('Errore durante la richiesta: $e');
    }
  }
}
