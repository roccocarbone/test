import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/marker_info.dart';
import 'package:student_link/models/partner/partner_model.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';

class CardMarkerPartner extends StatefulWidget {
  final Partner partner;
  const CardMarkerPartner(this.partner, {super.key});

  @override
  State<CardMarkerPartner> createState() => _CardMarkerPartnerState();
}

class _CardMarkerPartnerState extends State<CardMarkerPartner> {
  String? _profileImagePath;

  bool _isImageLoading = true;

  bool showButton = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProfilePhoto();
  }

  void _fetchProfilePhoto() async {
    String? profileImagePath =
        await GetProfilePhoto.fetchProfilePhotoPartner(widget.partner.id);

    setState(() {
      _profileImagePath = profileImagePath;
      _isImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showButton = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
                //TODO: CAMBIARE CON IMMAGINE PROFILO UTENTE image:
                image: _profileImagePath != null
                    ? DecorationImage(
                        image: new FileImage(
                          File(
                            _profileImagePath!,
                          ),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //BUTTON NOTIFICHE
                        ElevatedButton(
                          onPressed: () {
                            //TODO: SET CLICK Notify
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor: Colors.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/map/card_partners/notify.svg',
                            color: Theme.of(context).primaryColor,
                            height: 30,
                            width: 30,
                          ),
                        ),

                        //BUTTON DOWNLOAD
                        ElevatedButton(
                          onPressed: () {
                            //TODO: SET CLICK DOWNLOAD
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(5),
                            backgroundColor: Colors.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/map/card_partners/download.svg',
                            color: Theme.of(context).primaryColor,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        
                      ],
                    ),
                    Spacer(),
                    //TODO: SETTARE NOME PARTNER.NAME
                    //NOME STRUTTURA
                    Text(
                      widget.partner.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //TODO: SETTARE
                    //TIPO STRUTTURA
                    Text(
                      widget.partner.description,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          /* Positioned(
            right: 10,
            bottom:
                10, // Incrementa il valore negativo per spostare il pulsante più in basso
            child: SvgPicture.asset(
              'assets/icons/map/card_partners/change_arrow.svg',
              height: 24,
              width: 24,
              color: Colors.white,
            ),
          ), */
          //TODO: VERIFICARE BUTTON TAGLIATO
          Positioned(
            left: 0,
            right: 1,
            bottom:
                10, // Incrementa il valore negativo per spostare il pulsante più in basso
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  //TODO: SET CLICK MAP
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: SvgPicture.asset(
                  'assets/icons/map/card_partners/qrcode.svg',
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
