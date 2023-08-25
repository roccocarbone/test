import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/services/profile/profile_me/change_password/change_password.dart';
import 'package:student_link/views/login/login_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
              title: 'Nuova password',
              hint: 'Password',
              textEditingController:
                  _textEditingControllerPasswordNuovaPassword,
            ),
            const SizedBox(
              height: 16,
            ),
            PasswordTextField(
              title: 'Conferma password',
              hint: 'Password',
              textEditingController:
                  _textEditingControllerPasswordConfermaNuovaPass,
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
              onPressed: () async {
                //TODO: SET Change password ACCOUNT USER

                //TODO: MOSTRARE ALERT BOTTOM SE PASSWORD NON COINCIDONO O NON VALIDA
                //TODO: MOSTRARE AVVISO DI SUCCESSO

                if (_textEditingControllerPasswordNuovaPassword.text ==
                    _textEditingControllerPasswordConfermaNuovaPass.text) {
                  Map<String, dynamic> profileData = {
                    "oldPassword": _textEditingControllerPasswordAttuale.text,
                    "newPassword":
                        _textEditingControllerPasswordConfermaNuovaPass.text
                  };

                  try {
                    await ChangePassword.changePassword(
                      profileData,
                      context,
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );

                    //TODO: ELIMINARE SCHERMATE IN CODA E RIPORTARE AL LOGIN
                  } catch (error) {
                    dialogError(
                      'Ops..',
                      error.toString(),
                    );
                  }
                } else {
                  dialogError(
                    'Ops..',
                    'Le due password non coincidono.',
                  );

                  print(_textEditingControllerPasswordNuovaPassword.text);

                  print(_textEditingControllerPasswordConfermaNuovaPass.text);
                }
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

  //ALERT DIALOG DI ERRORE PASSANDO TESTI
  void dialogError(String title, String message) {
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
          child: BottomAlert(
            title,
            message,
          ),
        );
      },
    );
  }
}
