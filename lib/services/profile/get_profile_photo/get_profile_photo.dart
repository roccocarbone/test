import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:student_link/services/login/auth.dart';

class GetProfilePhoto {
  static Future<String?> fetchProfilePhoto(String userId) async {
    final String url =
        'https://testing.studentlink.cloud/v1/profile/$userId/photo';

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/octet-stream',
        'Token': token!, // Aggiungi il token nell'header della richiesta
      },
    );

    if (response.statusCode == 200) {
      // Recupera il percorso della directory temporanea
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Genera il percorso completo per il file temporaneo
      String tempFilePath = path.join(tempPath, '$userId.jpg');

      // Scrive i dati dell'immagine nel file temporaneo
      File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(response.bodyBytes);

      print('Immagine recuperata con successo: $tempFilePath');

      print(tempFile);

      return tempFilePath;
    } else {
      print(
          'Errore durante il recupero dell\'immagine: ${response.statusCode}');
      return null;
    }
  }
}
