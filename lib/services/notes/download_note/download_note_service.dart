import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DownloadNoteService {
  static const String _baseUrl = Request.endpoint;

  static Future<bool> downloadAndOpenNote(
      BuildContext context, String noteId) async {
    try {
      final file = await _downloadNote(context, noteId);
      await _openFile(context,file);
      return true;
    } catch (e) {
      _showError(context, e.toString());
      return false;
    }
  }

  static Future<File> _downloadNote(BuildContext context, String noteId) async {
    final fullUrl = '$_baseUrl/note/$noteId/download';
    final authService = AuthService();
    final token = await authService.getToken();

    if (token == null) {
      _showError(context, 'Token non disponibile');
      return Future.error('Token non disponibile');
    }

    final hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      _showError(context, 'Permesso di storage non concesso.');
      return Future.error('Permesso di storage non concesso.');
    }

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'Token': token,
        'Content-Type': 'application/json',
      },
    );


    if (response.statusCode != 200) {
      _showError(
          context, 'Errore durante la richiesta: ${response.statusCode}');
      return Future.error(
          'Errore durante la richiesta: ${response.statusCode}');
    }

    return _writeFile(noteId, response.bodyBytes);
  }

  static Future<File> _writeFile(String noteId, List<int> bytes) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/$noteId.pdf';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> _openFile(BuildContext context, File file) async {
  final filePath = file.path;
  print(filePath);
  
  try {
    await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => PDFView(filePath: filePath),
      ),
    );
  } catch (e) {
    return Future.error('Could not launch $filePath: $e');
  }
}

  static Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) return true;
    status = await Permission.storage.request();
    return status.isGranted;
  }

  static void _showError(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }
}
