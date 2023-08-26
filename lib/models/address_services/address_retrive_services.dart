import 'dart:convert';
import 'package:http/http.dart';
import 'dart:io';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  final sessionToken;
  static const String androidKey = 'AIzaSyDJ47mC3lkjmQ_OR73lsu8tg9I3Bb72gBg';
  static const String iosKey = 'AIzaSyDJ47mC3lkjmQ_OR73lsu8tg9I3Bb72gBg';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  PlaceApiProvider(this.sessionToken);

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final requestUri = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken');

    final response = await client.get(requestUri);

    if (response.statusCode != 200) throw Exception('Failed to fetch suggestion');

    final result = json.decode(response.body);
    if (result['status'] == 'OK') {
      return result['predictions']
          .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
          .toList();
    }
    if (result['status'] == 'ZERO_RESULTS') return [];
    throw Exception(result['error_message']);
  }

  Future<PlaceDetail> getPlaceDetailFromId(String placeId) async {
    final requestUri = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(requestUri);

    if (response.statusCode != 200) throw Exception('Failed to fetch place detail');

    final result = json.decode(response.body);
    if (result['status'] == 'OK') {
      final place = result['result'];
      return PlaceDetail(
        name: place['name'],
        address: place['formatted_address'],
        lat: place['geometry']['location']['lat'],
        lng: place['geometry']['location']['lng'],
      );
    }
    throw Exception(result['error_message']);
  }
}

class PlaceDetail {
  final String name;
  final String address;
  final double lat;
  final double lng;

  PlaceDetail({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });
}
