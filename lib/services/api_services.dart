import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/services/login/auth.dart';
import 'dart:convert';

class ApiService {
  static Future<http.Response> performRequest(String url,
      {String? token,
      Map<String, String>? additionalHeaders,
      String method = 'GET',
      dynamic body}) async {
    final AuthService authService = AuthService();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Token': token,
      if (additionalHeaders != null) ...additionalHeaders,
    };

    http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(Uri.parse(url), headers: headers);
        break;
      case 'POST':
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case 'PUT':
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse(url), headers: headers);
        break;
      default:
        throw Exception('Metodo HTTP non supportato');
    }

    if (response.statusCode == 401) {
      // Unauthorized
      await authService.refreshToken();
      final refreshedToken = await authService.getToken();
      headers['Token'] = refreshedToken!;

      switch (method) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case 'POST':
          response = await http.post(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response = await http.put(Uri.parse(url),
              headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
      }
    }

    return response;
  }
}
