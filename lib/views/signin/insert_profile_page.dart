import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';

import '../../widgets/alert_dialog/bottom_alert.dart';

class InsertProfilePhotoPage extends StatelessWidget {
  const InsertProfilePhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Foto Profilo',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        //ICONA PER TONRARE INDIETRO
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/icon_back.svg',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      //TODO: MODIFICARE BODY QUANDO SI INSERISCE LA FOTO, CAMBIARE TESTO E TESTO SOTTO IL BUTTON PER SKIPPARE
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Carica la foto che più ti rappresenta!',
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child:
                                  //TODO: SETTARE INSERIMENTO IMMAGINE.
                                  SvgPicture.asset(
                                'assets/icons/camera.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //TODO: SET USERNAME UTENTE
                          Text(
                            '@username',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //TODO: SET NOME E COGNOME USTENTE
                          Text(
                            'Nome Cognome',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: CONTROLLO INSERIMENTO FOTO E Se non inserita mostrare messaggio

                Navigator.pushNamed(context, RouteNames.personal_services_page);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              child: Center(
                //TODO: INSERIRE IN BASSO A DESTRA IL SIMBOLO DI MODIFICA DOPO L'AGGIUNTA DELLA FOTO
                child: Text(
                  'Aggiungi foto',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //TODO: RIMUOVERE SE PRESENTE LA FOTO
            Center(
              child: TextButton(
                onPressed: () {
                  //TODO: SET SKIP CARICAMNETO FOTOGRAFIA
                  Navigator.pushNamed(
                      context, RouteNames.personal_services_page);
                },
                child: Text(
                  'Ricordamelo più tardi',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFA6A5A5),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
