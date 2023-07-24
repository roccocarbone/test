import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/chat/tab_bar/chats_list/single_chat_page.dart/single_chat_page.dart';

class BoxChatStyle extends StatelessWidget {
  const BoxChatStyle({super.key});

  //TODO: EVIDENZIARE TESTO SE IL MESSAGGIO è LETTO o MENO

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        //TODO: APRIRE CHAT CON UTENTE PASSARE ID

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleChatPage(),
          ),
        );
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      image: DecorationImage(image: AssetImage('assets/icons/immagini_provvisorie/image_profile.png'))
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Luca Luca',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'LIUC Cattaneo - Ingegneria gestionale',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TODO: INSERIRE DATA ULTIMO MESSAGGIO
                ],
              ),
            ),
            SizedBox(
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
