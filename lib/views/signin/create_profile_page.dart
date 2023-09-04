import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/address_services/address_retrive_services.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/profile/insert_profile_photo/insert_profile_photo.dart';
import 'package:student_link/services/profile/update_profile.dart';
import 'package:student_link/views/signin/insert_profile_page.dart';
import 'package:student_link/views/signin/retrive_address/retrive_address_page.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';
import 'package:geocoding/geocoding.dart';

import '../../widgets/alert_dialog/bottom_alert.dart';

class CreateProfilePage extends StatefulWidget {
  final String email;
  CreateProfilePage(this.email, {super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _textEditingControllerIndirizzo =
      TextEditingController();

  final TextEditingController _textEditingControllerBio =
      TextEditingController();

  PlaceDetail? _selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Profilo',
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Indirizzo',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 328.0),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          child: TextField(
                            onTap: () async {
                              final PlaceDetail? selectedPlace =
                                  await showSearch<PlaceDetail?>(
                                context: context,
                                delegate: AddressSearch(),
                              );
                              if (selectedPlace != null &&
                                  selectedPlace.address != null) {
                                _textEditingControllerIndirizzo.text =
                                    selectedPlace.address;
                                setState(() {
                                  _selectedPlace = selectedPlace;

                              
                                });
                              }
                            },
                            controller: _textEditingControllerIndirizzo,
                            decoration: InputDecoration(
                              hintText: 'Inserisci il tuo indirizzo',
                              hintStyle: TextStyle(
                                color: const Color(0xFFC6C6C6),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    //TODO: BIOGRAFIA METTERE ALTEZZA SUPERIORE
                    StandardTextField(
                      'Biografia',
                      'Racconta qualcosa su di te!',
                      _textEditingControllerBio,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //CONTROLLO IF PER COMPLETEZZA DATI
                //DIALOG ERRORE
                if (_textEditingControllerIndirizzo.text.isEmpty ||
                    _textEditingControllerBio.text.isEmpty) {
                  dialogError(
                    'Ops..',
                    'Ti sei dimenticato di inserire qualche dato. Prova a controllare...',
                  );
                } else {
                  Map<String, dynamic> profileData = {
                    'bio': _textEditingControllerBio.text,
                    'coordinates': {
                      
                      "lat":_selectedPlace!.lat,
                      "lon": _selectedPlace!.lng,
                    },
                  };
                  try {
                    await UpdateProfile.updateProfile(
                      profileData,
                      context,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InsertProfilePhotoPage(widget.email),
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
