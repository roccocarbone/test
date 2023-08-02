import 'package:student_link/models/notes/note.dart';

class RequestNote {
  String id;
  Note note;
  Claimer claimer;
  String status;
  String comment;

  RequestNote({
    required this.id,
    required this.note,
    required this.claimer,
    required this.status,
    required this.comment,
  });

  factory RequestNote.fromJson(Map<String, dynamic> json) {
    return RequestNote(
      id: json['id'],
      note: Note.fromJson(json['note']),
      claimer: Claimer.fromJson(json['claimer']),
      status: json['status'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note.toJson(),
      'claimer': claimer.toJson(),
      'status': status,
      'comment': comment,
    };
  }
}

class Owner {
  String id;
  String name;
  String surname;
  String username;

  Owner({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
    };
  }
}

class Claimer {
  String id;
  String name;
  String surname;
  String bio;
  String username;
  String university;
  String courseOfStudy;
  String positionType;
  dynamic coordinates;
  bool isVisible;
  dynamic services;
  dynamic social;

  Claimer({
    required this.id,
    required this.name,
    required this.surname,
    required this.bio,
    required this.username,
    required this.university,
    required this.courseOfStudy,
    required this.positionType,
    required this.coordinates,
    required this.isVisible,
    required this.services,
    required this.social,
  });

  factory Claimer.fromJson(Map<String, dynamic> json) {
    return Claimer(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      bio: json['bio'],
      username: json['username'],
      university: json['university'],
      courseOfStudy: json['courseOfStudy'],
      positionType: json['positionType'],
      coordinates: json['coordinates'],
      isVisible: json['isVisible'],
      services: json['services'],
      social: json['social'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'bio': bio,
      'username': username,
      'university': university,
      'courseOfStudy': courseOfStudy,
      'positionType': positionType,
      'coordinates': coordinates,
      'isVisible': isVisible,
      'services': services,
      'social': social,
    };
  }
}
