import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/profile/update_profile.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/social_text_filed.dart';
import 'package:student_link/widgets/toggle/toggle_with_descrption.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalServicesPage extends StatefulWidget {
  final String email;
  const PersonalServicesPage(this.email, {super.key});

  @override
  State<PersonalServicesPage> createState() => _PersonalServicesPageState();
}

class _PersonalServicesPageState extends State<PersonalServicesPage> {
  TextEditingController controllerInstagram = TextEditingController();
  TextEditingController controllerFacebook = TextEditingController();

  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;
  bool isActive4 = false;

  bool loadButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Servizi',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //TODO: SETTARE I CLICK SUI TOGGLE SWITCH
              ToggleWithDescription(
                title: 'Car pooling',
                isActive: false,
                description:
                    'Se attivato, altri utenti potranno scriverti per organizzare condividere un viaggio insieme ad altre persone, con la possibilità di ridurre i costi di spostamento.',
                onToggle: (bool value) {
                  setState(() {
                    isActive1 = value;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ToggleWithDescription(
                title: 'Tutoraggio',
                isActive: false,
                description:
                    'Se attivato, altri utenti potranno contattarti per chiederti delle sessioni di tutoraggio.',
                onToggle: (bool value) {
                  setState(() {
                    isActive2 = value;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ToggleWithDescription(
                title: 'Mostra mail',
                isActive: false,
                description:
                    'Se attivato, altri utenti potranno vedere il tuo indirizzo mail per poterti contattare.',
                onToggle: (bool value) {
                  setState(() {
                    isActive3 = value;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ToggleWithDescription(
                title: 'Mostra posizione',
                isActive: false,
                description:
                    'Se attivato, altri utenti potranno vedere la tua posizione in tempo reale sulla mappa.',
                onToggle: (bool value) {
                  setState(() {
                    isActive4 = value;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F4F7),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: Text(
                  'Profili social',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SocialTextField(
                'Instagram',
                'instagram',
                controllerInstagram,
              ),
              const SizedBox(
                height: 16,
              ),
              SocialTextField(
                'Facebook',
                'facebook',
                controllerFacebook,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Inserisci il tuo username se vuoi che gli altri utenti possano visualizzare i tuoi profili social.',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loadButton = true;
                  });

                  Map<String, dynamic> profileData = {
                    "isVisible": isActive4,
                    "services": {
                      "carSharing": isActive1,
                      "tutoring": isActive2,
                      "repetitions": false
                    },
                    "social": {
                      "facebook": controllerFacebook.text,
                      "instagram": controllerInstagram.text,
                    }
                  };

                  try {
                    await UpdateProfile.updateProfile(
                      profileData,
                      context,
                    );

                    //TODO: SALVARE SALVATAGGIO IN LOCALE, FINE REGISTRAZIONE

                    savePrefs(false);

                    setState(() {
                      loadButton = false;
                    });

                    Navigator.pushNamed(context, RouteNames.on_boarding);
                  } catch (error) {
                    dialogError(
                      'Ops..',
                      error.toString(),
                    );
                    setState(() {
                      loadButton = false;
                    });
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
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Text(
                          'Conferma profilo',
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

  void savePrefs(bool firstTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.email, firstTime);
  }
}
