import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/views/chat/tab_bar/chats_list/box_chat_style/box_chat_style.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  //TODO SET LIST CHAT: SE NON CI SONO CHAT MOSTRARE PAGE NON PRESENTI
  //CREALE FUTURE LIST VIEW
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
          BoxChatStyle(),
        ],
      ),
    );
  }
}
