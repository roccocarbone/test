import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_link/services/profile/insert_profile_photo/insert_profile_photo.dart';
import 'package:student_link/views/signin/personal_services_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';

class InsertProfilePhotoPage extends StatefulWidget {
  final String email;
  const InsertProfilePhotoPage(this.email, {super.key});

  @override
  State<InsertProfilePhotoPage> createState() => _InsertProfilePhotoPageState();
}

class _InsertProfilePhotoPageState extends State<InsertProfilePhotoPage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();

    print(_imageFile);
    //TODO: GET USER DATA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Foto Profilo',
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
      //TODO: MODIFICARE BODY QUANDO SI INSERISCE LA FOTO, CAMBIARE TESTO E TESTO SOTTO IL BUTTON PER SKIPPARE
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Carica la foto che più ti rappresenta!',
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _openImagePicker();
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: _imageFile == null
                                        ? const AssetImage(
                                            'assets/icons/immagini_provvisorie/camera.png')
                                        : FileImage(_imageFile!)
                                            as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              )),

                          const SizedBox(
                            height: 16,
                          ),
                          //TODO: SET USERNAME UTENTE
                          Text(
                            '@username',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //TODO: SET NOME E COGNOME USTENTE
                          Text(
                            'Nome Cognome',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //TODO: CONTROLLO INSERIMENTO FOTO E Se non inserita mostrare messaggio

                //TODO: CONTROLLO SE IMMAGINE NON CARICATA

                if (_imageFile == null) {
                  dialogError(
                    'Ops..',
                    'Non hai inserito nessuna immagine',
                  );
                } else {
                  try {
                    bool success =
                        await InsertProfilePhoto.sendProfilePhoto(_imageFile!);

                    if (success) {
                      //TODO: VERIFICARE INSERIMENTO PHOTO

                      //TODO: RESTITUISCE 502, VERIFICARE

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PersonalServicesPage(widget.email),
                        ),
                      );
                    } else {
                      dialogError(
                        'Ops..',
                        'Errore durante il caricamento. ',
                      );
                    }
                  } catch (error) {
                    dialogError(
                      'Ops..',
                      'Errore durante il caricamento. ',
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
                //TODO: INSERIRE IN BASSO A DESTRA IL SIMBOLO DI MODIFICA DOPO L'AGGIUNTA DELLA FOTO
                child: Text(
                  'Aggiungi foto',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            _imageFile != null
                ? Container()
                : Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PersonalServicesPage(widget.email),
                          ),
                        );
                      },
                      child: Text(
                        'Ricordamelo più tardi',
                        style: GoogleFonts.poppins(
                          color: const Color(
                            0xFFA6A5A5,
                          ),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> _openImagePicker() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }

    try {
      InsertProfilePhoto.sendProfilePhoto(_imageFile!);
    } catch (error) {
      dialogError(
        'Ops..',
        error.toString(),
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
