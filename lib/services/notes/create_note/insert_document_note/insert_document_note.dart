import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http_parser/http_parser.dart';


Future<bool> uploadDocumentNote(
    PlatformFile documentFile, String idNote) async {
  final url = Uri.parse('${Request.endpoint}/note/$idNote/upload');

  final AuthService authService = AuthService();

  String? token = await authService.getToken();

  final request = http.MultipartRequest('POST', url);
  request.headers['Token'] = token!;

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      documentFile.path!,
      filename: 'note_file.pdf', //TODO: CAMBIARE NOME FILE
    ),
  );

  request.fields['file'] = '@"${documentFile.path}"';
  request.fields['filename'] = 'note_file.pdf'; //TODO: NOME FILE OVUNQUE

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Document upload successful!');
      return true;
    } else {
      print('Document upload failed. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error during document upload: $e');
    return false;
  }
}
