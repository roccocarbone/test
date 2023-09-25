import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/services/profile/update_profile.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
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

  bool carPoling = false, tutoraggio = false, visibile = false;

  String? selectedUniversity;
  String? selectedCourse;
  bool loadButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerNome.text = widget.user.name;
    _controllerCognome.text = widget.user.surname;
    _controllerUsername.text = widget.user.username;
    _controllerUniversita.text = widget.user.university;
    _controllerCorso.text = widget.user.courseOfStudy;

    //RECUPERARE INDIRIZZO DALLA COORDINATE: TODO: RIMOSSO PERChè bisogna trovare la miglio soluzione //COMMENTATO giuù

    _controllerBio.text = widget.user.bio;

    _controllerInstagram.text = widget.user.social!.instagram ?? '';

    _controllerFacebook.text = widget.user.social!.facebook ?? '';

    carPoling = widget.user.services.carSharing;
    tutoraggio = widget.user.services.tutoring;
    visibile = widget.user.isVisible!;
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
              Navigator.pop(context, true);
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
              onPressed: () async {
                //TODO: SET POST CHANGE PROFILE DATA

                //TODO: VERIFICARE DATI INSERITI

                //TODO: CREARE JSONDATA E PASSARLA AD UPDATEPROFIL

                Map<String, dynamic> profileData = {
                  "name": _controllerNome.text,
                  "surname": _controllerCognome.text,
                  "bio": _controllerBio.text,
                  "username": _controllerUsername.text,
                  "university": selectedUniversity,
                  "courseOfStudy": selectedCourse,
                  "isVisible": visibile,
                  "services": {
                    "carSharing": carPoling,
                    "tutoring": tutoraggio,
                    "repetitions": false
                  },
                  "social": {
                    "facebook": _controllerFacebook.text,
                    "instagram": _controllerInstagram.text,
                  }
                };

                try {
                  await UpdateProfile.updateProfile(
                    profileData,
                    context,
                  );

                  Navigator.pop(context, true);
                } catch (error) {
                  dialogError(
                    'Ops..',
                    error.toString(),
                  );
                }
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
                      return const CircularProgressIndicator();
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

  Widget _buildStyledDropdown({
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required String labelText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: value,
              items: items,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: value ?? hintText,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFFC6C6C6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

//WIDGET CON LA LISTA DEI TEXTFIELD
  Widget listaTextField() {
    return Column(
      children: [
        StandardTextField('Nome', widget.user.name, _controllerNome),
        const SizedBox(height: 8),
        StandardTextField('Cognome', widget.user.surname, _controllerCognome),
        const SizedBox(height: 8),
        StandardTextField(
            'Username', widget.user.username, _controllerUsername),
        const SizedBox(height: 8),
        _buildStyledDropdown(
          value: widget.user.university,
          items: const [
            DropdownMenuItem(child: Text("Liuc"), value: "Liuc"),
            // Aggiungi altre università se necessario
          ],
          onChanged: (value) => setState(() => selectedUniversity = value),
          labelText: 'Università',
          hintText: 'Quale università stai frequentando?',
        ),
        const SizedBox(height: 8),
        _buildStyledDropdown(
          value: widget.user.courseOfStudy,
          items: const [
            DropdownMenuItem(
                value: "Ing. Gestionale - Triennale",
                child: Text("Ing. Gestionale - Triennale")),
            DropdownMenuItem(
                value: "Ing. Gestionale - Magistrale",
                child: Text("Ing. Gestionale - Magistrale")),
            DropdownMenuItem(
                value: "Eco. Aziendale - Triennale",
                child: Text("Eco. Aziendale - Triennale")),
            DropdownMenuItem(
                value: "Eco. Aziendale - Magistrale",
                child: Text("Eco. Aziendale - Magistrale")),
          ],
          onChanged: (value) => setState(() => selectedCourse = value),
          labelText: 'Corso di studi',
          hintText: 'Quale percorso di studi hai scelto?',
        ),
        const SizedBox(height: 8),
        StandardTextField('Biografia',
            widget.user.bio ?? 'Racconta qualcosa su di te', _controllerBio),
      ],
    );
  }

//LIST OF TOGGLE
  Widget listToggleDescription() => Column(
        children: [
          ToggleWithDescription(
            title: 'Car pooling',
            isActive: widget.user.services.carSharing,
            description:
                'Se attivato, altri utenti potranno scriverti per organizzare condividere un viaggio insieme ad altre persone, con la possibilità di ridurre i costi di spostamento.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');

              setState(() {
                carPoling = isActive;
              });
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            title: 'Tutoraggio',
            isActive: widget.user.services.tutoring,
            description:
                'Se attivato, altri utenti potranno contattarti per chiederti delle sessioni di tutoraggio.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
              setState(() {
                tutoraggio = isActive;
              });
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ToggleWithDescription(
            title: 'Mostra posizione',
            isActive: widget.user.isVisible!,
            description:
                'Se attivato, altri utenti potranno vedere la tua posizione in tempo reale sulla mappa.',
            onToggle: (bool isActive) {
              print('Lo switch è: $isActive');
              setState(() {
                visibile = isActive;
              });
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
