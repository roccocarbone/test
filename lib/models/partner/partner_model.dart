class Partner {
  final String id;
  final String name;
  final String description;
  final Coordinates coordinates;
  final String qrCodeValue;

  Partner({
    required this.id,
    required this.name,
    required this.description,
    required this.coordinates,
    required this.qrCodeValue,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      coordinates: Coordinates.fromJson(json['coordinates']),
      qrCodeValue: json['qrCodeValue'] as String,
    );
  }
}

class Coordinates {
  final double lat;
  final double lon;

  Coordinates({
    required this.lat,
    required this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}
