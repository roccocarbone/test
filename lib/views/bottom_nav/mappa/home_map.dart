import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_link/models/partner/partner_model.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/map/partners_map/request_partners_map.dart';
import 'package:student_link/services/map/users_map/request/request_users_map.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/user/card_marker_user.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  State<HomeMap> createState() => HomeMapState();
}

class HomeMapState extends State<HomeMap> {
  final Completer<GoogleMapController> googleMapController = Completer();
  LatLng initialLocation = const LatLng(
    45.481923821080535,
    9.143707528710365,
  ); //TODO:RECUPERARE COORDINATE DI DOVE MI TROVO, Se posizione attiva recuparare giuste, sennò passare default?
  final Set<Marker> googleMapMarkers = {};

  late Future<List<Marker>> markersFuture;

  @override
  void initState() {
    super.initState();
    markersFuture = loadUserData();
  }

  Future<List<Marker>> loadUserData() async {
    final List<User> users = await RequestUsersMap.getUsers(
      initialLocation.latitude,
      initialLocation.longitude,
      context,
    );

    final List<Partner> partners = await Partnersrequest.getPartners(
      initialLocation.latitude,
      initialLocation.longitude,
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
            //TODO: CARD PARTNER
            // Qui dovresti avere un metodo simile a showMarkerDialogUser ma per i partner
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
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: searchBar(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.my_location_sharp,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget map() => FutureBuilder(
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
          }
        },
      );

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

  Widget searchBar() => Container(
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
      );
}
