import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/constant.dart';
import 'package:student_link/models/chat/message/message_model.dart';
import 'package:student_link/models/chat/user_chat_model/user_chat_model.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/chat/single_chat/single_chat.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:http/http.dart' as http;
import 'package:student_link/services/profile/profile_me/profile_me.dart';

class SingleChatPage extends StatefulWidget {
  final UserModelChat userModelChat;
  final String idChat;

  const SingleChatPage(this.userModelChat, this.idChat, {super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  List<MessageModel> messages = [];
  final TextEditingController _messageController = TextEditingController();

  Timer? _timer;

  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchMyProfile();
    _startTimer();
  }

  void _fetchMyProfile() async {
    try {
      User user = await ProfileMe.getMyProfile(context);
      setState(() {
        userId = user.id;
      });
    } catch (e) {
      print("Errore nel recupero del profilo: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      _fetchChatMessages();
    });
  }

  void _fetchChatMessages() async {
    final chats = await ChatService.getChatMessages(widget.userModelChat.id);
    final textMessages = chats.where((message) {
      return message.contentType == "TEXT";
    }).toList();
    setState(() {
      messages = textMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCDF0FF),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Row(
          children: [
            //INSERIRE ICONA ROTONDA USER CHAT
            FutureBuilder<String?>(
              future:
                  GetProfilePhoto.fetchProfilePhoto(widget.userModelChat.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding: const EdgeInsets.all(1),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ); //TODO: CARICAMNETO IMMAGINE PROFILO
                } else if (snapshot.hasError) {
                  return Container(
                    padding: const EdgeInsets.all(1),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    padding: const EdgeInsets.all(1),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.file(
                        File(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(1),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              '${widget.userModelChat.name} ${widget.userModelChat.surname}',
              style: GoogleFonts.poppins(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        //ICONA PER TONRARE INDIETRO
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        messages[index].content,
                        messages[index].senderId != widget.userModelChat.id,
                      );
                    },
                  ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    //TODO: Azione da eseguire quando si apre la selezione delle faccine
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Messaggio',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    bool success = await sendMessage(
                      chatId: widget.idChat,
                      senderId: userId!,
                      receiverId: widget.userModelChat.id,
                      content: _messageController.text,
                      context: context,
                    );
                    if (success) {
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const String _baseUrl = Request.endpoint;

  static Future<bool> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
    required BuildContext context,
  }) async {
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    if (token == null) {
      print('Token non trovato');
      return false;
    }

    final body = {
      "senderId": senderId,
      "receiverId": receiverId,
      "contentType": "TEXT",
      "content": content,
      "createdAt": DateTime.now().toIso8601String(),
      "status": "SENT"
    };

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/$chatId/messages'),
        headers: {
          'Content-Type': 'application/json',
          'Token': token,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Errore durante l\'invio del messaggio: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      throw Exception('Errore durante l\'invio del messaggio: $e');
    }
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  MessageBubble(this.message, this.isSender, {super.key});

  @override
  Widget build(BuildContext context) {
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor =
        isSender ? Theme.of(context).primaryColor : Colors.white;
    final textColor = isSender ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: alignment,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
          ),
          //TODO: INSERIRE ORARIO DI INVIO
        ),
      ),
    );
  }
}
