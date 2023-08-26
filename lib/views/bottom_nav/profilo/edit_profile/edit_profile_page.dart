import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/widgets/text_fields/social_text_filed.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';
import 'package:student_link/widgets/toggle/toggle_with_descrption.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  EditProfilePage(this.user, {super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _controllerNome = TextEditingController();

  final TextEditingController _controllerCognome = TextEditingController();

  final TextEditingController _controllerUsername = TextEditingController();

  final TextEditingController _controllerUniversita = TextEditingController();

  final TextEditingController _controllerCorso = TextEditingController();

  final TextEditingController _controllerIndirizzo = TextEditingController();

  final TextEditingController _controllerBio = TextEditingController();

  final TextEditingController _controllerInstagram = TextEditingController();

  final TextEditingController _controllerFacebook = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerNome.text = widget.user.name;
    _controllerCognome.text = widget.user.surname;
    _controllerUsername.text = widget.user.username;
    _controllerUniversita.text = widget.user.university;
    _controllerCorso.text = widget.user.courseOfStudy;
    
  }

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
                //TODO: SET POST CHANGE PROFILE DATA

                //TODO: VERIFICARE DATI INSERITI

                //TODO: CREARE JSONDATA E PASSARLA AD UPDATEPROFIL
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
                //TODO: QUESTO CONTAINER DEV'ESSERE CLICCABILE PER INSERIRE LA FOTO PROFILO
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: FutureBuilder(
                  future: GetProfilePhoto.fetchProfilePhoto(widget.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ClipOval(
                        child: Image.file(
                          File(snapshot.data!),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                  },
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
            widget.user.name,
            _controllerNome,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Cognome',
            widget.user.surname,
            _controllerCognome,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Username',
            widget.user.username,
            _controllerUsername,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Università',
            widget.user.university ?? 'Quale università stai frequentando',
            _controllerUniversita,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Corso di studi',
            widget.user.courseOfStudy ?? 'Quale percorso di studi hai scelto?',
            _controllerCorso,
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
            widget.user.bio ?? 'Racconta qualcosa su di te',
            _controllerBio,
          ),
        ],
      );

//LIST OF TOGGLE
  Widget listToggleDescription() => Column(
        children: [
          //TODO:SISTEMARE TOGGLE

          //TODO: VEDERE PAGINA CREAZIONE SEZIONE
          ToggleWithDescription(
            title: 'Car pooling',
            description:
                'Se attivato, altri utenti potranno scriverti per organizzare condividere un viaggio insieme ad altre persone, con la possibilità di ridurre i costi di spostamento.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
            },
          ),
          SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            title: 'Tutoraggio',
            description:
                'Se attivato, altri utenti potranno contattarti per chiederti delle sessioni di tutoraggio.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
            },
          ),
          SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            title: 'Mostra mail',
            description:
                'Se attivato, altri utenti potranno vedere il tuo indirizzo mail per poterti contattare.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
            },
          ),
          SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            title: 'Mostra posizione',
            description:
                'Se attivato, altri utenti potranno vedere la tua posizione in tempo reale sulla mappa.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
            },
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
          SocialTextField(
            widget.user.social!.instagram ?? 'Instagram',
            'instagram',
            _controllerInstagram,
          ),
          const SizedBox(
            height: 8,
          ),
          SocialTextField(
            widget.user.social!.facebook ?? 'Facebook',
            'facebook',
            _controllerFacebook,
          ),
        ],
      );
}
