import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/chat/chat_model/chat_model.dart';
import 'package:student_link/services/chat/list_chats/chats_list.dart';
import 'package:student_link/views/chat/tab_bar/chats_list/box_chat_style/box_chat_style.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatModel>>(
      future: GetMyChat.getMyChats(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Errore: ${snapshot.error}'));
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFCDF0FF)),
                  ),
                  child: const Icon(Icons.send_outlined,
                      color: Color(0xFFCDF0FF), size: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  'Nessuna chat presente',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFCDF0FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            ChatModel chat = snapshot.data![index];
            return BoxChatStyle(
              idChat: chat.id,
              userModelChat: chat.user,
              lastMessage: chat.lastMessage,
            );
          },
        );
      },
    );
  }
}
