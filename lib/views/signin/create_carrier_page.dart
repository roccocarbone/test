import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/profile/update_profile.dart';
import 'package:student_link/views/signin/create_profile_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class CreateCarrierPage extends StatefulWidget {
  String email;
  CreateCarrierPage(this.email, {super.key});

  @override
  State<CreateCarrierPage> createState() => _CreateCarrierPageState();
}

class _CreateCarrierPageState extends State<CreateCarrierPage> {
  final TextEditingController _textEditingControllerUniversita =
      TextEditingController();

  final TextEditingController _textEditingControllerCorso =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'La tua carriera',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    StandardTextField(
                      'Università',
                      'Quale università stai frequentando?',
                      _textEditingControllerUniversita,
                    ),
                    const SizedBox(height: 16),
                    StandardTextField(
                      'Corso di studi',
                      'Quale percorso di studi hai scelto?',
                      _textEditingControllerCorso,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //TODO: CONTROLLO INSERIMENTO DATI, SENNò mostrare alert dialog.

                if (_textEditingControllerUniversita.text.isEmpty ||
                    _textEditingControllerCorso.text.isEmpty) {
                  dialogError(
                    'Ops..',
                    'Ti sei dimenticato di inserire qualche dato. Prova a controllare...',
                  );
                } else {
                  Map<String, dynamic> profileData = {
                    'university': _textEditingControllerUniversita.text,
                    'courseOfStudy': _textEditingControllerCorso.text,
                  };

                  try {
                    await UpdateProfile.updateProfile(
                      profileData,
                      context,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfilePage(widget.email),
                      ),
                    );
                  } catch (error) {
                    dialogError(
                      'Ops..',
                      error.toString(),
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
