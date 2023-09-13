import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';

class GetPreviewNote {
  static Future<String?> fetchPreviewNote(String noteId) async {
    final String url = '${Request.endpoint}/note/$noteId/preview/0'; //TODO PASSARE INDEX

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

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;


      String tempFilePath = path.join(tempPath, '$noteId.jpg');


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
