import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/chat/message/message_model.dart';

import 'package:student_link/models/chat/user_chat_model/user_chat_model.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/views/chat/tab_bar/chats_list/single_chat_page.dart/single_chat_page.dart';

class BoxChatStyle extends StatelessWidget {
  final UserModelChat userModelChat;
  final String idChat;

  final MessageModel lastMessage;

  BoxChatStyle({
    required this.idChat,
    required this.userModelChat,
    required this.lastMessage,
  });

  //TODO: EVIDENZIARE TESTO SE IL MESSAGGIO è LETTO o MENO

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleChatPage(
              userModelChat,
              idChat,
            ),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<String?>(
                    future: GetProfilePhoto.fetchProfilePhoto(userModelChat.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          padding: const EdgeInsets.all(1),
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ); //TODO: CARICAMNETO IMMAGINE PROFILO
                      } else if (snapshot.hasError) {
                        return Container(
                          padding: const EdgeInsets.all(1),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Container(
                          padding: const EdgeInsets.all(1),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userModelChat.name} ${userModelChat.surname}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        if(lastMessage.contentType == "NOTE_DOWLOAD_REQUEST") 
                        Text(
                          "Richiesta appunto",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                        ) else 
                        Text(
                          lastMessage.content,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lastMessage.createdAt,
                      style: GoogleFonts.poppins(
                        color: Color(0xFFA6A5A5),
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                color: Colors.grey[300],
                height: 0,
                indent: 0,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
