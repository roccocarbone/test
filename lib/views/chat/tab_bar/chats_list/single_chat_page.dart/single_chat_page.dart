import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleChatPage extends StatelessWidget {
  const SingleChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCDF0FF),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Row(
          children: [
            //INSERIRE ICONA ROTONDA USER CHAT
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: DecorationImage(image: AssetImage('assets/icons/immagini_provvisorie/image_profile.png'))
              ), //TODO: INSERT IMAGE USER IN CHILD
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'Nome User Chat ',
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              reverse:
                  false, // Per far scorrere i messaggi dall'alto verso il basso
              children: [
                //TODO: GET I MESSAGGI
                MessageBubble(
                  'Ciao, come stai?',
                  false,
                ),
                MessageBubble(
                  'Tutto bene, grazie!',
                  true,
                ),
                MessageBubble(
                  'Hai fatto qualche progetto interessante ultimamente?',
                  false,
                ),
                MessageBubble(
                  'Sì, ho appena completato un progetto di app mobile.',
                  true,
                ),
                // Aggiungi altri messaggi finti qui
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
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
                    // Azione da eseguire quando si apre la selezione delle faccine
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
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
                  onPressed: () {
                    // Azione da eseguire quando si invia un messaggio
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  MessageBubble(this.message, this.isSender, {super.key});

  @override
  Widget build(BuildContext context) {
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isSender ? Theme.of(context).primaryColor : Colors.white;
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
