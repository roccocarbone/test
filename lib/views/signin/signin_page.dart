import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/sign_up/sign_up_service.dart';
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

  SignUpService signUpService = SignUpService();

  final TextEditingController _textEditingControllerEmail =
      TextEditingController();
  final TextEditingController _textEditingControllerNome =
      TextEditingController();
  final TextEditingController _textEditingControllerCognome =
      TextEditingController();
  final TextEditingController _textEditingControllerUsername =
      TextEditingController();
  final TextEditingController _textEditingControllerData =
      TextEditingController();
  final TextEditingController _textEditingControllerPassword =
      TextEditingController();
  final TextEditingController _textEditingControllerConfermaPass =
      TextEditingController();

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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              StandardTextField('Mail universitaria', 'example@stud.uni.it',
                  _textEditingControllerEmail),
              const SizedBox(
                height: 16,
              ),
              StandardTextField(
                'Nome',
                'Il tuo nome',
                _textEditingControllerNome,
              ),
              const SizedBox(
                height: 16,
              ),
              StandardTextField(
                'Cognome',
                'Il tuo cognome',
                _textEditingControllerCognome,
              ),
              const SizedBox(
                height: 16,
              ),
              StandardTextField('Username', 'Come vuoi essere chiamato?',
                  _textEditingControllerUsername),
              const SizedBox(
                height: 16,
              ),
              StandardTextField(
                'Quando sei nato?',
                'gg/mm/aaaa',
                _textEditingControllerData,
              ),
              const SizedBox(height: 16),
              PasswordTextField(
                title: 'Password',
                hint: 'Password',
                textEditingController: _textEditingControllerPassword,
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordTextField(
                title: 'Password',
                hint: 'Password',
                textEditingController: _textEditingControllerConfermaPass,
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
                onPressed: () async {
                  if (_textEditingControllerPassword.text !=
                      _textEditingControllerConfermaPass.text) {
                    dialogError(
                      'Ops...',
                      'Le password non coincidono!',
                    );
                  } else if (_textEditingControllerNome.text.isEmpty ||
                      _textEditingControllerCognome.text.isEmpty ||
                      _textEditingControllerEmail.text.isEmpty ||
                      _textEditingControllerUsername.text.isEmpty ||
                      _textEditingControllerData.text.isEmpty ||
                      _textEditingControllerPassword.text.isEmpty ||
                      _textEditingControllerConfermaPass.text.isEmpty) {
                    dialogError(
                      'Ops...',
                      'Ti sei dimenticato di inserire qualche dato. Prova a controllare...',
                    );
                  } else if (!isChecked) {
                    dialogError(
                      'Ops...',
                      'Per favore, accetta i Termini e Condizioni per procedere.',
                    );
                  } else {
                    handleSignUp();
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

  //ESECUZIONE POST DELL'UTENTE
  void handleSignUp() async {
    try {
      await SignUpService.signUp(
        _textEditingControllerNome.text,
        _textEditingControllerCognome.text,
        _textEditingControllerEmail.text,
        _textEditingControllerUsername.text,
        _textEditingControllerPassword.text,
        '',
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.login_page,
        (route) => false,
      );
    } catch (e) {
      dialogError(
        'Ops...',
        e.toString(),
      );
    }
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
