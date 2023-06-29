import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController _textEditingControllerPasswordAttuale =
      TextEditingController();

  final TextEditingController _textEditingControllerPasswordNuovaPassword =
      TextEditingController();

  final TextEditingController _textEditingControllerPasswordConfermaNuovaPass =
      TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Cambia password',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            PasswordTextField(
              title: 'Password attuale',
              hint: 'Password',
              textEditingController: _textEditingControllerPasswordAttuale,
            ),
            const SizedBox(
              height: 16,
            ),
            PasswordTextField(
              title: 'Conferma password',
              hint: 'Password',
              textEditingController: _textEditingControllerPasswordNuovaPassword,
            ),
            const SizedBox(
              height: 16,
            ),
            PasswordTextField(
              title: 'Nuova password',
              hint: 'Password',
              textEditingController: _textEditingControllerPasswordConfermaNuovaPass,
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              onPressed: () {
                //TODO: SET Change password ACCOUNT USER

                //TODO: MOSTRARE ALERT BOTTOM SE PASSWORD NON COINCIDONO O NON VALIDA
                //TODO: MOSTRARE AVVISO DI SUCCESSO
              },
              child: Center(
                child: Text(
                  'Conferma',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
