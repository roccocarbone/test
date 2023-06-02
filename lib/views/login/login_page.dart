import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Bentornato!',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            //TODO: SETTARE CONTROLLER CON CONTROLLO SE SCRITTO
            const StandardTextField(
              'Mail',
              'example@stud.uni.it',
            ),
            const SizedBox(
              height: 15,
            ),
            //TODO: SETTARE CONTROLLER CON CONTROLLO SE SCRITTO E CORRETTEZZA PASSWORD
            const PasswordTextField(
              title: 'Password',
              hint: 'La tua password',
            ), //TODO: CAMBIARE TEXTFIELD CON TIPO PASSWORD
            const SizedBox(
              height: 15,
            ),
            //BUTTON CHE PORTA ALLA PAGINA DI RECUPERO PASSWORD
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteNames.password_dimenticata_page);
              },
              child: Text(
                'Ho dimenticato la mia password',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Non hai ancora un account?',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                //BUTTON CHE VA ALLA PAGINA DI REGISTRAZIONE
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.signin_page);
                  },
                  child: Text(
                    'Registrati subito!',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: SET CLICK ACCEDI
                Navigator.pushNamed(context, RouteNames.main_bottom_nav);
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
                  'Accedi',
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
