import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/widgets/text_fields/social_text_filed.dart';
import 'package:student_link/widgets/toggle_with_descrption.dart';

class PersonalServicesPage extends StatelessWidget {
  const PersonalServicesPage({super.key});

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
            'assets/icons/icon_back.svg',
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
              const ToggleWithDescription(
                'Car pooling',
                'Se attivato, altri utenti potranno scriverti per organizzare condividere un viaggio insieme ad altre persone, con la possibilità di ridurre i costi di spostamento.',
                false,
              ),
              const SizedBox(
                height: 16,
              ),
              const ToggleWithDescription(
                'Tutoraggio',
                'Se attivato, altri utenti potranno contattarti per chiederti delle sessioni di tutoraggio.',
                true,
              ),
              const SizedBox(
                height: 16,
              ),
              const ToggleWithDescription(
                'Mostra mail',
                'Se attivato, altri utenti potranno vedere il tuo indirizzo mail per poterti contattare.',
                false,
              ),
              const SizedBox(
                height: 16,
              ),
              const ToggleWithDescription(
                'Mostra posizione',
                'Se attivato, altri utenti potranno vedere la tua posizione in tempo reale sulla mappa.',
                true,
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
              const SocialTextField(
                'Instagram',
                'instagram',
              ),
              const SizedBox(
                height: 16,
              ),
              const SocialTextField(
                'Facebook',
                'facebook',
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
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.on_boarding);
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
}
