import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/partner/partner_model.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http/http.dart' as http;

class Partnersrequest{
  static const String _baseUrl = Request.endpoint;
  static Future<List<Partner>> getPartners(
      double latitude, double longitude, BuildContext context) async {
    final String fullUrl = '$_baseUrl/map/$longitude/$latitude';
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
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> partnersData = body['partners']; 
        List<Partner> partners =
            partnersData.map((partnerJson) => Partner.fromJson(partnerJson)).toList();
        return partners;
      } else {
        throw Exception('Errore durante la richiesta: ${response.statusCode}');
      }
    } catch (e) {
      await authService.logout(context);
      throw Exception('Errore durante la richiesta: $e');
    }
  }

}