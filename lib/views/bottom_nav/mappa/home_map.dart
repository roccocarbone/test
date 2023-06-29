import 'dart:async';
import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/marker_info.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/partner/card_marker_partner.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/user/card_marker_user.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  State<HomeMap> createState() => HomeMapState();
}

class HomeMapState extends State<HomeMap> {
  final Completer<GoogleMapController> googleMapController = Completer();

  //TODO: SETTARE POSIZIONE INIZIALE DI VISIBILITà
  LatLng initialLocation = const LatLng(45.46270689178515, 9.187460542417579);

  final Set<Marker> googleMapMarkers = {};

  @override
  void initState() {
    super.initState();
    loadImageData();
  }

  Future<void> loadImageData() async {
    var markerData = await loadMarkerData();
    List<Marker> markers = [];

    for (var markerInfo in markerData) {
      if (markerInfo.type == 'user') {
        // Setta un'icona diversa per i marker con tipo diverso da 'user'

        Uint8List resizedImageData = await getBytesFromUrl(markerInfo.icon, 85);

        markers.add(
          Marker(
            markerId: MarkerId(markerInfo.id),
            position: markerInfo.position,
            onTap: () => showMarkerDialog(markerInfo),
            icon: BitmapDescriptor.fromBytes(resizedImageData),
          ),
        );
      } else {
        //SE NON SI TRATTA DI UN UTENTE SI TRATTA DI PARTNER E QUINDI IMPOSTIAMO UN MARKER APPOSITO
        final BitmapDescriptor customIcon =
            await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/images/map/marker/marker_partner.png', // TODO: Sostituisci con il percorso giusto per il marker
        );
        markers.add(
          Marker(
            markerId: MarkerId(markerInfo.id),
            position: markerInfo.position,
            //SETTO IL CLICK SUL MARKER E RICHIAMO LA FUNCTION
            onTap: () => showMarkerDialog(markerInfo),
            //TODO: ICONA PERSONALIZZATA PER I Partner
            icon: customIcon,
          ),
        );
      }
    }

    setState(
      () {
        googleMapMarkers.addAll(markers);
      },
    );
  }

  Future<Uint8List> getBytesFromUrl(String url, int width) async {
    http.Response response = await http.get(Uri.parse(url));
    // Ottiene i byte dell'immagine dalla risposta HTTP
    Uint8List imageData = response.bodyBytes;

    return resizeImage(imageData,
        width); // Ridimensiona l'immagine utilizzando la funzione resizeImage
  }

  Future<Uint8List> resizeImage(Uint8List imageData, int desiredWidth) async {
    //decodificare l'immagine
    ui.Codec codec = await ui.instantiateImageCodec(
      imageData,
      targetWidth: desiredWidth,
    );

    ui.FrameInfo frameInfo = await codec.getNextFrame();

    return (await frameInfo.image.toByteData(
            format: ui.ImageByteFormat
                .png))! // si Converte l'immagine in formato ByteData nel formato PNG e restituisce i byte come Uint8List
        .buffer
        .asUint8List();
  }

  //RECUPER MARKER DA UN JSON E POI LA GET
  Future<List<MarkerInfo>> loadMarkerData() async {
    final jsonText = await rootBundle.loadString('assets/markers.json');
    final jsonData = json.decode(jsonText);
    return List<MarkerInfo>.from(
      jsonData.map(
        (markerJson) {
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
        },
      ),
    );
  }

  //CLICK SUL MARKER E APERTURA DEL DIALOG CON LE INFO
  void showMarkerDialog(MarkerInfo markerInfo) {
    //TODO: VEDERE LA CATEGORIA E PASSARE CRARD DIVERSE, USER O STRUTTURA

    if (markerInfo.type == 'user') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: CardMarkerUser(markerInfo.id, markerInfo.title),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: FlipCard(
            fill: Fill
                .fillBack, // Fill the back side of the card to make in the same size as the front.
            direction: FlipDirection.HORIZONTAL, // default
            side: CardSide.FRONT, // The side to initially display.
            front: CardMarkerPartner(markerInfo.id, markerInfo.title),
            back: CardMarkerPartner(markerInfo.id,
                markerInfo.title), //TODO: CREARE FRONT E BACK DELLA CARD
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          map(),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(child: searchBar()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //TODO: SETTARE RECUPERO POSIZIONE
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.my_location_sharp,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //CREO IL WIDGET DELLA MAPPA
  Widget map() => Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          zoomControlsEnabled: false,
          myLocationEnabled: false,
          buildingsEnabled: false,
          trafficEnabled: false,
          initialCameraPosition: CameraPosition(
            target: initialLocation,
            zoom: 13,
          ),
          onMapCreated: (controller) async {
            googleMapController.complete(controller);
            final style = await rootBundle
                .loadString('assets/maps_style/maps_style.json');
            controller.setMapStyle(style);
          },
          markers: googleMapMarkers,
        ),
      );

  //CREO IL WIDGET DELLA SERACHBAR
  Widget searchBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Opzione di elevazione
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 16),
              child: const Icon(Icons.search),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cerca qui...',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'assets/images/login/people_image.png',
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      );

  
}
