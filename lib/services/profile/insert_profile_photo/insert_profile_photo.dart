import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';

class InsertProfilePhoto {
  static Future<bool> sendProfilePhoto(File imageFile) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token != null) {
      var request = http.MultipartRequest('POST', Uri.parse('${Request.endpoint}/profile/photo'));
      request.headers['Token'] = token;
      request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

      try {
        var response = await request.send();

        if (response.statusCode == 200) {
          print('Immagine inviata con successo');
          return true;
        } else {
          print('Errore durante l\'invio dell\'immagine: ${response.statusCode}');
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
