import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/marker_info.dart';

class CardMarkerPartner extends StatefulWidget {
  final String id, title;
  const CardMarkerPartner(this.id, this.title, {super.key});

  @override
  State<CardMarkerPartner> createState() => _CardMarkerPartnerState();
}

class _CardMarkerPartnerState extends State<CardMarkerPartner> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarkerInfo?>(
      future: loadMarkerInfo(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final markerInfo = snapshot.data!;

          //TODO: SETTARE I CLICK SULLE VARIE ICONE DELLA CARD

          //TODO: COMPLETARE LA PARTE POSTERIORE DELLA CARD

          return Stack(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                    //TODO: INSERIRE image: CON IMMAGINE LOCALE
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/icons/immagini_provvisorie/back_card_strut.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
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
                            //BUTTON MAP
                            ElevatedButton(
                              onPressed: () {
                                //TODO: SET CLICK MAP
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(5),
                                backgroundColor: Colors.white,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/map/card_partners/map.svg',
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
                          'Pizzeria Hoboken',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //TODO: SETTARE
                        //TIPO STRUTTURA
                        Text(
                          'Ristorante pizzeria',
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
              Positioned(
                right: 10,
                bottom:
                    10, // Incrementa il valore negativo per spostare il pulsante più in basso
                child: SvgPicture.asset(
                  'assets/icons/map/card_partners/change_arrow.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ),
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
          );
        } else if (snapshot.hasError) {
          return const Text(
              'Errore nel caricamento delle info della struttura');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  //TODO: FARE LA GET PER LA CARD, PASSANDO O ID O CORDINATE QUI ABBIAMO RECUPERO DA FILE JSON
  Future<MarkerInfo?> loadMarkerInfo(String id) async {
    final jsonText = await rootBundle.loadString('assets/markers.json');
    final jsonData = json.decode(jsonText);
    final markerJson =
        jsonData.firstWhere((marker) => marker['id'] == id, orElse: () => null);
    if (markerJson != null) {
      return MarkerInfo(
          id: markerJson['id'],
          position: LatLng(
            markerJson['position']['latitude'],
            markerJson['position']['longitude'],
          ),
          title: markerJson['title'],
          description: markerJson['description'],
          type: markerJson['type'],
          icon: markerJson['icon']);
    } else {
      return null;
    }
  }
}
