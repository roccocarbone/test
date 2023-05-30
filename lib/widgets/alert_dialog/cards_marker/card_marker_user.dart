import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_link/models/marker_info.dart';

class CardMarkerUser extends StatefulWidget {
  final String id, title;
  const CardMarkerUser(this.id, this.title, {super.key});

  @override
  State<CardMarkerUser> createState() => _CardMarkerUserState();
}

class _CardMarkerUserState extends State<CardMarkerUser> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      //TODO: CAMBIARE CON IMMAGINE PROFILO UTENTE
                      image: AssetImage('assets/back_card.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO: LA CARD CAMBIA STILE SE è UTENTE O LOCALE
                        //NAME USER OR LOCAL
                        Text(
                          'Alessia Rossi',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        //USERNAME
                        Text(
                          '@rossialessia',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        //TODO:
                        //PASSARE ICONA
                        const Icon(
                          Icons.abc,
                          color: Colors.white,
                        ),
                        //PASSARE DATI GIUSTI
                        Text(
                          'LIUC Cattaneo, Castellanza',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),

                        Text(
                          'Ingegneria gestionale',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: WormEffect(
                                spacing: 5.0,
                                radius: 5.0,
                                dotHeight: 8.0,
                                dotColor: const Color(0xFFD9D9D9),
                                activeDotColor: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //TODO: SECONDA PAGINA
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TODO
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                //TODO: SOSTITUIRE CON IMMAGINE PROFILO
                                child: Image.asset(
                                  'assets/back_card.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TODO: INSERIRE NOME
                                Text(
                                  'Alessia Rossi',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                //TODO: SETTARE USERNAME
                                Text(
                                  '@rossialessia',
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    //TODO:
                                    //ICON CAR POOLING TRUE OR FALSE
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCDF0FF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3.0),
                                        ),
                                      ),
                                      //TODO: ICONA CAR POOLING
                                      child: const Icon(
                                        Icons.abc,
                                        size: 13,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    //ICON TUTORAGGIO TRUE OR FALSE
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCDF0FF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3.0),
                                        ),
                                      ),
                                      //TODO: ICONA tutoraggio
                                      child: const Icon(
                                        Icons.abc,
                                        size: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    //TODO:
                                    //ICON POSITION USER
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCDF0FF),
                                        shape: BoxShape.circle,
                                      ),
                                      //TODO: ICONA PSOITION USER
                                      child: const Icon(
                                        Icons.abc,
                                        size: 13,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    //ICON CHAT TRUE OR FALSE
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCDF0FF),
                                        shape: BoxShape.circle,
                                      ),
                                      //TODO: ICONA CHAT
                                      child: const Icon(
                                        Icons.abc,
                                        size: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //TODO:
                                    //ICON SOCIAL TRUE OR FALSE SHOW
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/icons/social/instagram.svg'),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    //ICON FACEBOOK TRUE OR FALSE
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/icons/social/facebook.svg'),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFCDF0FF),
                                          shape: BoxShape.circle),
                                      //TODO: EMAIL tutoraggio
                                      child: const Icon(
                                        Icons.mail,
                                        size: 13,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //DIVIDER
                        const Divider(
                          height: 1,
                          color: Color(0xFFC6C6C6),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //TODO SE DESCRIZIONE PRESENTE MOSTRARE TESTO SENNò IMMAGINE NESSUN TESTO

                        Text(
                          'Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It va esser tam simplic quam Occidental: in fact, it va esser Occidental.',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        ),
                        const Spacer(),

                        Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: WormEffect(
                                spacing: 5.0,
                                radius: 5.0,
                                dotHeight: 8.0,
                                dotColor: const Color(0xFFD9D9D9),
                                activeDotColor: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Errore nel caricamento delle info della persona');
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
          type: markerJson['type']);
    } else {
      return null;
    }
  }
}
