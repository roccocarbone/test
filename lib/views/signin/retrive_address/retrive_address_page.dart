import 'package:flutter/material.dart';
import 'package:student_link/models/address_services/address_retrive_services.dart';

class AddressSearch extends SearchDelegate<PlaceDetail?>{
  // Cambia qui
  final PlaceApiProvider apiProvider =
      PlaceApiProvider("AIzaSyDJ47mC3lkjmQ_OR73lsu8tg9I3Bb72gBg");

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query.isEmpty ? null : apiProvider.fetchSuggestions(query, 'it'),
      builder: (context, snapshot) {
        if (query.isEmpty) {
          return Center(child: Text('Inserisci il tuo indirizzo.'));
        }
        if (snapshot.hasError) {
          return Center(child: Text('An error occurred!'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final suggestions = snapshot.data as List<Suggestion>;
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              title: Text(suggestion.description),
              onTap: () async {
                final PlaceDetail placeDetails =
                    await apiProvider.getPlaceDetailFromId(suggestion
                        .placeId); // Assicurati che getPlaceDetailFromId restituisca PlaceDetail
                close(context, placeDetails);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () =>
          close(context, PlaceDetail(name: '', address: '', lat: 0, lng: 0)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }
}
