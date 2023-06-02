import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked = false;
  // Stato del CheckBox
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Benvenuto!',
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const StandardTextField(
                'Mail universitaria',
                'example@stud.uni.it',
              ),
              const SizedBox(
                height: 16,
              ),
              const StandardTextField(
                'Nome',
                'Il tuo nome',
              ),
              const SizedBox(
                height: 16,
              ),
              const StandardTextField(
                'Cognome',
                'Il tuo cognome',
              ),
              const SizedBox(
                height: 16,
              ),
              const StandardTextField(
                'Username',
                'Come vuoi essere chiamato?',
              ),
              //TODO: CAMBIARE CON TIPE PASSWORD ENTRAMBI
              const SizedBox(
                height: 16,
              ),
              PasswordTextField(
                title: 'Password',
                hint: 'Password',
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordTextField(
                title: 'Password',
                hint: 'Password',
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          isChecked = value!;
                        },
                      );
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        'Accetto i',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          //TODO: CLICK TERMINI E CONDIZIONI
                        },
                        child: Text(
                          'Termini e Condizioni',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO: GO TO LA TUA CARRIERA
                  //CONTROLLO INSERIMENTO DATI, SENNò mostrare alert dialog.

                  //CONTROLLO IF PER COMPLETEZZA DATI
                  //DIALOG ERRORE

                  Navigator.pushNamed(context, RouteNames.create_carrier_page);

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
      ),
    );
  }
}
