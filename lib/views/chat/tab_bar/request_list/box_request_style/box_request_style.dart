import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/chat/tab_bar/request_list/single_request_page/single_request_page.dart';

class BoxRequestStyle extends StatelessWidget {
  const BoxRequestStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: APRIRE ACCETTAZIONE RICHIESTA
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleRequestPage(),
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
                          'Sofia Donate',
                          style: GoogleFonts.poppins(
                            color: Colors
                                .black, //TODO: CAMBIARE IL COLORE IN BASE AD APPROVATO,RIFIUTATO, IN CORSO
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromARGB(134, 198, 198, 198),
                          ),
                          child: Row(
                            children: [
                              //TODO: ICON IN BASE AL TIPO DEL DOC
                              const Icon(Icons.file_copy_outlined),
                              const SizedBox(
                                width: 8,
                              ),
                              //TODO: CAMBIARE CON NOME DOCUMENTO
                              Text(
                                'Formulario termodinamica.pdf',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
