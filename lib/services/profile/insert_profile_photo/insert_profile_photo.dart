import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:student_link/constant.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:http_parser/http_parser.dart';

// Function to upload the image using POST request
Future<bool> uploadImage(File imageFile) async {
  final url = Uri.parse('${Request.endpoint}/profile/photo');

  final AuthService authService = AuthService();

  String? token = await authService.getToken();

  final request = http.MultipartRequest('POST', url);
  request.headers['Token'] = token!;

  print(
    imageFile.path,
  );

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      imageFile.path,
      filename: 'profile.jpg',
    ),
  );

  request.fields['file'] = '@"${imageFile.path}"';
  request.fields['filename'] = 'profile.jpg';

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image upload successful!');
      return true;
    } else {
      print('Image upload failed. Status code: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Error during image upload: $e');
    return false;
  }
}
