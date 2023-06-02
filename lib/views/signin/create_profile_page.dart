import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

import '../../widgets/alert_dialog/bottom_alert.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Profilo',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: const [
                    SizedBox(height: 30),
                    //TODO: CAMBIARE TEXTFIELD CON TIPO DATA
                    StandardTextField(
                      'Quando sei nato?',
                      'gg/mm/aaaa',
                    ),
                    SizedBox(height: 16),
                    StandardTextField(
                      'Indirizzo',
                      'Inserisci il tuo indirizzo',
                    ),
                    SizedBox(height: 16),
                    //TODO: BIOGRAFIA METTERE ALTEZZA SUPERIORE
                    StandardTextField(
                      'Biografia',
                      'Racconta qualcosa su di te!',
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: CONTROLLO INSERIMENTO DATI, SENNò mostrare alert dialog.

                Navigator.pushNamed(
                    context, RouteNames.insert_profile_photo_page);

                //CONTROLLO IF PER COMPLETEZZA DATI
                //DIALOG ERRORE

                if (false) {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: const BottomAlert(
                          'Ops...',
                          'Ti sei dimenticato di inserire qualche dato. Prova a controllare...',
                        ),
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Continua',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}