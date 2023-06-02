import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/marker_info.dart';

class CardmarkerStructure extends StatefulWidget {
  final String id, title;
  const CardmarkerStructure(this.id, this.title, {super.key});

  @override
  State<CardmarkerStructure> createState() => _CardmarkerStructureState();
}

class _CardmarkerStructureState extends State<CardmarkerStructure> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarkerInfo?>(
      future: loadMarkerInfo(widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final markerInfo = snapshot.data!;

          //TODO: SETTARE I CLICK SULLE VARIE ICONE DELLA CARD

          return SizedBox(
            height: 400,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  //TODO: CAMBIARE CON IMMAGINE PROFILO LOCALE
                  image: AssetImage('assets/back_card_strut.png'),
                  fit: BoxFit.cover,
                ),
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
                        //TODO: IMPOSTARE I CLICK SUI BUTTON
                        //BUTTON NOTIFICHE
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/card_structures/notify.svg',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //BUTTON DOWNLOAD
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/card_structures/download.svg',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //BUTTON MAP
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //TODO: CAMBIARE ICONA
                            child: SvgPicture.asset(
                              'assets/icons/card_structures/map.svg',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //BUTTON QR CODE
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              //TODO: CAMBIARE ICONA
                              child: SvgPicture.asset(
                                'assets/icons/card_structures/qrcode.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    //TODO: SETTARE NOME
                    //NOME STRUTTURA
                    Text(
                      'Pizzeria Hoboken',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),

                    //TODO: SETTARE
                    //TIPO STRUTTURA
                    Text(
                      'Ristorante pizzeria',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
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
