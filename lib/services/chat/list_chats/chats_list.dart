import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/chat/chat_model/chat_model.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class GetMyChat {
  static const String _baseUrl = Request.endpoint;

  static Future<List<ChatModel>>? getMyChats(BuildContext context) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    Future<http.Response> _makeRequest(String url) async {
      return await http.get(
        Uri.parse(url),
        headers: {
          'Token': token!,
          'Content-Type': 'application/json',
        },
      );
    }

    try {
      // Fetching user data
      var userResponse = await _makeRequest('$_baseUrl/chat/contacts');

      if (userResponse.statusCode != 200) {
        throw Exception(
            'Errore durante la richiesta utente: ${userResponse.statusCode}');
      }

      final userJson = jsonDecode(userResponse.body);
      final List<ChatModel> chats = [];

      for (var user in userJson) {
        // Fetching last message for each user
        var messageResponse =
            await _makeRequest('$_baseUrl/chat/${user['id']}/messages');

        if (messageResponse.statusCode != 200) {
          throw Exception(
              'Errore durante la richiesta messaggio: ${messageResponse.statusCode}');
        }

        final messageJson = jsonDecode(messageResponse.body);
        final lastTextMessage = messageJson.lastWhere(
            (msg) => msg['contentType'] == 'TEXT',
            orElse: () => null);

        if (lastTextMessage != null) {
          chats.add(ChatModel.fromJson(user, lastTextMessage));
        }
      }

      return chats;
    } catch (e) {
      throw Exception(e);
    }
  }
}
