import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/services/login/reset_password/reset_password.dart';
import 'package:student_link/views/login/login_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class InsertCodeResetPage extends StatefulWidget {
  final String email;
  const InsertCodeResetPage(this.email, {super.key});

  @override
  State<InsertCodeResetPage> createState() => _InsertCodeResetPageState();
}

class _InsertCodeResetPageState extends State<InsertCodeResetPage> {
  final TextEditingController _textEditingControllerCode =
      TextEditingController();

  final TextEditingController _textEditingControllerPassword =
      TextEditingController();

  final TextEditingController _textEditingControllerConfermaPassword =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Nuova Password',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        //ICONA PER TONRARE INDIETRO
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/app_bar/icon_back.svg',
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
            Text(
              'Inserisci il codice che ti abbiamo inviato per mail e scegli una nuova password. Questa volta non te la scordare!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //TODO: SETTARE CONTROLLER CON CONTROLLO SE SCRITTO E NON CAMPO VUOTO
            StandardTextField(
              'Codice',
              'Inserisci codice',
              _textEditingControllerCode,
            ),

            const SizedBox(
              height: 16,
            ),
            //TODO: SETTARE CONTROLLER CON CONTROLLO SE SCRITTO E NON CAMPO VUOTO
            PasswordTextField(
              title: 'Nuova password',
              hint: 'Nuova password',
              textEditingController: _textEditingControllerPassword,
            ),
            const SizedBox(
              height: 16,
            ),
            //TODO: SETTARE CONTROLLER CON CONTROLLO SE SCRITTO E NON CAMPO VUOTO
            PasswordTextField(
              title: 'Conferma password',
              hint: 'Conferma password',
              textEditingController: _textEditingControllerConfermaPassword,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                //TODO: SET CLICK Conferma e fare i controlli su codice e se coincide la pass

                try {
                  await ResetPassword.resetPassword(
                    context,
                    widget.email,
                    int.parse(_textEditingControllerCode.text),
                    _textEditingControllerConfermaPassword.text,
                  );
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);

                } catch (error) {
                  print(error);
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
                  'Conferma',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
