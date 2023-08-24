import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http_parser/http_parser.dart';

// Function to upload the image using POST request
Future<bool> uploadPreviewtNote(File previewFile, String idNote) async {
  final url = Uri.parse('${Request.endpoint}/note/$idNote/preview');

  final AuthService authService = AuthService();

  String? token = await authService.getToken();

  final request = http.MultipartRequest('POST', url);
  request.headers['Token'] = token!;

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      previewFile.path,
      filename: 'note_preview.jpg', //TODO: CAMBIARE NOME FILE
    ),
  );

  request.fields['file'] = '@"${previewFile.path}"';
  request.fields['filename'] = 'note_preview.jpg'; //TODO: NOME FILE OVUNQUE

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Preview upload successful!');
      return true;
    } else {
      print('Preview upload failed. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error during preview upload: $e');
    return false;
  }
}
