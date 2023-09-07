import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/partner/partner_model.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/map/partners_map/request_partners_map.dart';
import 'package:student_link/services/map/users_map/request/request_users_map.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/services/profile/profile_me/profile_me.dart';
import 'package:student_link/services/users/get_list_users/get_list_users.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/partner/card_marker_partner.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/user/card_marker_user.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  State<HomeMap> createState() => HomeMapState();
}

class HomeMapState extends State<HomeMap> {
  final Completer<GoogleMapController> googleMapController = Completer();
  LatLng? initialLocation;
  final Set<Marker> googleMapMarkers = {};

  late Future<List<Marker>> markersFuture;

  late User currentUser;

  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    try {
      currentUser = await ProfileMe.getMyProfile(context);

      setState(() {
        if (currentUser.coordinates.lat.toDouble() == 0.0 ||
            currentUser.coordinates.lon.toDouble() == 0.0) {
          initialLocation = const LatLng(
            45.611590,
            8.901553,
          );
        } else {
          initialLocation = LatLng(
            currentUser.coordinates.lat.toDouble(),
            currentUser.coordinates.lon.toDouble(),
          );
        }

        print(initialLocation);
      });
      markersFuture = loadUserData();
    } catch (e) {
      print('Errore durante la recupero delle coordinate: $e');
    }
  }

  Future<List<Marker>> loadUserData() async {
    List<User> users = await GetListUsers.getUsers(context, 0);

    final List<Partner> partners = await Partnersrequest.getPartners(
      initialLocation!.latitude,
      initialLocation!.longitude,
      context,
    );
    List<Marker> markers = [];

    for (var user in users) {
      LatLng positionUser = LatLng(
        user.coordinates.lat.toDouble(),
        user.coordinates.lon.toDouble(),
      );

      markers.add(
        Marker(
          markerId: MarkerId(user.id),
          position: positionUser,
          onTap: () => showMarkerDialogUser(user),
        ),
      );
    }

    for (var partner in partners) {
      LatLng positionPartner = LatLng(
        partner.coordinates.lat.toDouble(),
        partner.coordinates.lon.toDouble(),
      );

      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/map/marker/marker_partner.png",
      );

      markers.add(
        Marker(
          markerId: MarkerId(partner.id),
          position: positionPartner,
          icon: markerbitmap,
          onTap: () {
            showMarkerDialogPartner(partner);
          },
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          map(),
          /* Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: searchBar(),
            ),
          ), */
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await _handleLocationPermission()) {
            await _getCurrentPosition();
            print('ooooooo');
          }
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.my_location_sharp,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget map() {
    if (initialLocation == null || markersFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return FutureBuilder(
      future: markersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Errore: ${snapshot.error}'),
          );
        } else {
          List<Marker> markers = snapshot.data!;
          googleMapMarkers.addAll(markers);

          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: GoogleMap(
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              buildingsEnabled: false,
              trafficEnabled: false,
              initialCameraPosition: CameraPosition(
                target: initialLocation!,
                zoom: 13,
              ),
              onMapCreated: (controller) async {
                if (!googleMapController.isCompleted) {
                  googleMapController.complete(controller);
                  final style = await rootBundle
                      .loadString('assets/maps_style/maps_style.json');
                  controller.setMapStyle(style);
                }
              },
              markers: googleMapMarkers,
            ),
          );
        }
      },
    );
  }

  void showMarkerDialogUser(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: CardMarkerUser(user),
      ),
    );
  }

  void showMarkerDialogPartner(Partner partner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: CardMarkerPartner(partner),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
  try {
    // Ottenere la posizione corrente
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    // Aggiornare lo stato con la nuova posizione
    setState(() => _currentPosition = position);

    // Stampa la posizione per debug
    print(position);

    // Verifica se il controller della mappa Google è stato completato
    if (googleMapController.isCompleted) {
      final GoogleMapController controller = await googleMapController.future;

      // Aggiorna la posizione della camera sulla mappa
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 13.0,
        ),
      ));
    }
  } catch (e) {
    // Gestione degli errori
    debugPrint("Errore durante la recupero della posizione: $e");
  }
}


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true; // Ritorna true se il permesso è concesso
  }
  /* Widget searchBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
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
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FutureBuilder<String?>(
                future: GetProfilePhoto.fetchProfilePhoto(
                  'userId', //TODO: PASSARE USER ID PER PRENDERE IMMAGINE
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Container(
                      padding: const EdgeInsets.all(1),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Icon(
                          Icons.person,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      padding: const EdgeInsets.all(1),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.file(
                          File(snapshot.data!),
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(1),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Icon(
                          Icons.person,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ); */
}
