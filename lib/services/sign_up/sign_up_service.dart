import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpService {
  static Future<void> signUp(String name, String surname, String email,
      String username, String password, String birthday) async {
    String endpoint = Request.endpoint;

    final url = Uri.parse('${endpoint}/signup');

    final body = {
      "name": name,
      "surname": surname,
      "email": email,
      "username": username,
      "password": password,
      "birthday": birthday
    };

    try {
      final response = await http.post(url, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // Richiesta POST riuscita
        print('Registrazione avvenuta con successo!');


      } else {
        // Errore nella richiesta POST
        final errorResponse = jsonDecode(response.body);
        print(
            'Errore durante la registrazione. Codice di stato: ${response.statusCode}. Dettagli errore: ${errorResponse['errorInfo']['details']}');
        throw 'Errore durante la registrazione: ${errorResponse['errorInfo']['details']}';
      }
    } catch (e) {
      // Questo blocco catturerà sia l'errore di rete che l'eccezione lanciata nel blocco else dell'if precedente
      print('Errore durante la registrazione: $e');
      throw e.toString();
    }
  }
}
