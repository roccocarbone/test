import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/login/auth.dart';
import 'package:student_link/services/profile/profile_me/profile_me.dart';
import 'package:student_link/views/signin/create_carrier_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/password_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textEditingControllerEmail =
      TextEditingController();

  final TextEditingController _textEditingControllerPassword =
      TextEditingController();

  final AuthService authService = AuthService();

  String email = '';

  bool loadButton = false;

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
            const SizedBox(
              height: 15,
            ),

            StandardTextField(
              'Mail',
              'example@stud.uni.it',
              _textEditingControllerEmail,
            ),
            const SizedBox(
              height: 15,
            ),

            PasswordTextField(
              title: 'Password',
              hint: 'La tua password',
              textEditingController: _textEditingControllerPassword,
            ),
            const SizedBox(
              height: 15,
            ),
            //TODO: BUTTON CHE PORTA ALLA PAGINA DI RECUPERO PASSWORD
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.password_dimenticata_page,
                );
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
              onPressed: () async {
                setState(() {
                  loadButton = true;
                });
                email = _textEditingControllerEmail.text;
                String password = _textEditingControllerPassword.text;

                if (email.isEmpty || password.isEmpty) {
                  dialogError(
                    'Ops..',
                    'Hai lasciato qualche campo vuoto!',
                  );
                } else {
                  try {
                    await authService.login(email, password);
                    User userMe = await ProfileMe.getMyProfile(context);

                    setState(() {
                      loadButton = false;
                    });

                    // Se è la prima volta o ci sono campi vuoti nell'utente
                    if (areUserFieldsEmpty(userMe)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCarrierPage(email),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, RouteNames.main_bottom_nav);
                    }
                  } catch (e) {
                    setState(() {
                      loadButton = false;
                    });
                    dialogError(
                      'Ops..',
                      'Email o password errati!',
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              child: loadButton
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Center(
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

  bool areUserFieldsEmpty(User userMe) {
   
    if (userMe.id.isEmpty ||
        userMe.name.isEmpty ||
        userMe.surname.isEmpty ||
        userMe.bio.isEmpty ||
        userMe.username.isEmpty ||
        userMe.university.isEmpty ||
        userMe.courseOfStudy.isEmpty
        ) {
      return true;
    }

    return false;
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

  Future<bool?> getprefs() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstTime = prefs.getBool(email);

    return firstTime;
  }
}
