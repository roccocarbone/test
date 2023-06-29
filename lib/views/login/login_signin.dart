import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';

class LoginSigninPage extends StatelessWidget {
  const LoginSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/login/logo_orizzontale_completo.png'),

            Image.asset('assets/images/login/people_image.png'),

            Text(
              'ENTRA ANCHE TU NELLA COMMUNITY DI STUDENT LINK!',
              style: GoogleFonts.poppins(
                color: Theme.of(context).primaryColor,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            //BUTTON ACCEDI
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.login_page);
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
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 50,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Se non possiedi ancora un account',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 1,
                  width: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            //BUTTON REGISTRATI
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.signin_page);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                side: BorderSide(
                  width: 2.5,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'Registrati',
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).primaryColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
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
