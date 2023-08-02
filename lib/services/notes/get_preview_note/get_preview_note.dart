import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:student_link/services/login/auth.dart';

class GetPreviewNote {
  static Future<String?> fetchPreviewNote(String noteId) async {
    final String url =
        'https://testing.studentlink.cloud/v1/note/$noteId/preview';

    final AuthService authService = AuthService();

    String? token = await authService.getToken();
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/octet-stream',
        'Token': token!, 
      },
    );

    if (response.statusCode == 200) {
      // Recupera il percorso della directory temporanea
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Genera il percorso completo per il file temporaneo
      String tempFilePath = path.join(tempPath, '$noteId.jpg');

      // Scrive i dati dell'immagine nel file temporaneo
      File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(response.bodyBytes);

      print('Preview nota recuperata con successo: $tempFilePath');



      return tempFilePath;
    } else {
      print(
          'Errore durante il recupero della preview nota: ${response.statusCode}');
      return null;
    }
  }
}
