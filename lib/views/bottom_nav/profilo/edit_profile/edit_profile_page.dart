import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/widgets/text_fields/social_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';
import 'package:student_link/widgets/toggle/toggle_with_descrption.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerCognome = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerUniversita = TextEditingController();
  final TextEditingController _controllerCorso = TextEditingController();
  final TextEditingController _controllerDataNascita = TextEditingController();
  final TextEditingController _controllerIndirizzo = TextEditingController();
  final TextEditingController _controllerBio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(68, 3, 168, 244),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(3),
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Text(
          'Modifica profilo',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(3),
                elevation: 0.0,
              ),
              onPressed: () {
                //TODO: SET POST CHANGE PROFILE DATA //TODO: VERIFICARE DATI INSERITI
              },
              child: const Icon(
                Icons.done_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                  //TODO: SET IMAGE PROFILE
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            listaTextField(),
            const SizedBox(
              height: 8,
            ),
            listToggleDescription(),
            const SizedBox(
              height: 8,
            ),
            listSocialNetwork(),
          ],
        ),
      ),
    );
  }

  //WIDGET CON AL LISTA DEI TEXTFIELD
  Widget listaTextField() => Column(
        children: [
          StandardTextField(
            'Nome',
            'Il tuo nome',
            _controllerNome,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Cognome',
            'Il tuo cognome',
            _controllerCognome,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Username',
            'Il tuo username',
            _controllerUsername,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Università',
            'Quale università stai frequentando',
            _controllerUniversita,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Corso di studi',
            'Quale percorso di studi hai scelto?',
            _controllerCorso,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Quando sei nato?',
            'gg/mm/aaaa',
            _controllerDataNascita,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Indirizzo',
            'Inserisci il tuo indirizzo',
            _controllerIndirizzo,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            //TODO: CREATE EXPAND TEXTFIELD
            'Biografia',
            'Racconta qualcosa su di te',
            _controllerBio,
          ),
        ],
      );

//LIST OF TOGGLE
  Widget listToggleDescription() => Column(
        children: const [
          ToggleWithDescription(
            'Car pooling',
            'Se attivato, altri utenti potranno scriverti per organizzare condividere un viaggio insieme ad altre persone, con la possibilità di ridurre i costi di spostamento.',
            true,
          ),
          SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            'Mostra mail',
            'Se attivato, altri utenti potranno vedere il tuo indirizzo mail per poterti contattare.',
            true,
          ),
          SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            'Mostra posizione',
            'Se attivato, altri utenti potranno vedere la tua posizione in tempo reale sulla mappa.',
            true,
          ),
        ],
      );

  //LIST OF SOCIAL NETWORK
  Widget listSocialNetwork() => Column(
        children: [
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
            height: 8,
          ),
          const SocialTextField('Instagram', 'instagram'),
          const SizedBox(
            height: 8,
          ),
          const SocialTextField('Facebook', 'facebook'),
        ],
      );
}
