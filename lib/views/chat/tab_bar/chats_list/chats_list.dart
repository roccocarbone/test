import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  //TODO SET LIST CHAT: SE NON CI SONO CHAT MOSTRARE PAGE NON PRESENTI
  //CREALE FUTURE LIST VIEW
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFCDF0FF),
              ),
            ),
            child: const Icon(
              Icons.send_outlined,
              color: Color(0xFFCDF0FF), //TODO: CAMBIARE ICONA SEND
              size: 40,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Nessuna chat presente',
            style: GoogleFonts.poppins(
              color: const Color(0xFFCDF0FF),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),

      /* Column(
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
      ), */
    );
  }
}
