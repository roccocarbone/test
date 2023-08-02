import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final String bio;
  final String username;
  final String university;
  final String courseOfStudy;
  final String positionType;
  final Coordinates coordinates;
  final bool? isVisible;
  final Services services;
  final Social? social;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.bio,
    required this.username,
    required this.university,
    required this.courseOfStudy,
    required this.positionType,
    required this.coordinates,
    this.isVisible,
    required this.services,
    this.social,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        bio: json['bio'],
        username: json['username'],
        university: json['university'],
        courseOfStudy: json['courseOfStudy'],
        positionType: json['positionType'],
        coordinates: Coordinates.fromJson(json['coordinates']),
        isVisible: json['isVisible'],
        services: Services.fromJson(json['services']),
        social: Social.fromJson(json['social']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'bio': bio,
        'username': username,
        'university': university,
        'courseOfStudy': courseOfStudy,
        'positionType': positionType,
        'coordinates': coordinates.toJson(),
        'isVisible': isVisible,
        'services': services.toJson(),
        'social': social!.toJson(),
      };
}

class Coordinates {
  final double lat;
  final double lon;

  Coordinates({required this.lat, required this.lon});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: (json['lat'] as num).toDouble(),
        lon: (json['lon'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };
}

class Services {
  final bool carSharing;
  final bool tutoring;
  final bool repetitions;

  Services(
      {required this.carSharing,
      required this.tutoring,
      required this.repetitions});

  factory Services.fromJson(Map<String, dynamic> json) => Services(
        carSharing: json['carSharing'],
        tutoring: json['tutoring'],
        repetitions: json['repetitions'],
      );

  Map<String, dynamic> toJson() => {
        'carSharing': carSharing,
        'tutoring': tutoring,
        'repetitions': repetitions,
      };
}

class Social {
  final String? email;
  final String? whatsapp;
  final String? facebook;
  final String? instagram;

  Social({this.email, this.whatsapp, this.facebook, this.instagram});

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        email: json['email'],
        whatsapp: json['whatsapp'],
        facebook: json['facebook'],
        instagram: json['instagram'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'whatsapp': whatsapp,
        'facebook': facebook,
        'instagram': instagram,
      };
}
