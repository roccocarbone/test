class Note {
  String id;
  Owner owner;
  String title;
  String description;
  String university;
  String courseOfStudy;
  String subject;

  int price;
  bool downloadable;
  int academicYear;
  String noteType;

  Note({
    required this.id,
    required this.owner,
    required this.title,
    required this.description,
    required this.university,
    required this.courseOfStudy,
    required this.subject,
    required this.price,
    required this.downloadable,
    required this.academicYear,
    required this.noteType,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      owner: Owner.fromJson(json['owner']),
      title: json['title'],
      description: json['description'],
      university: json['university'],
      courseOfStudy: json['courseOfStudy'],
      subject: json['subject'],
      price: json['price'],
      downloadable: json['downloadable'],
      academicYear: json['academicYear'],
      noteType: json['noteType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner.toJson(),
      'title': title,
      'description': description,
      'university': university,
      'courseOfStudy': courseOfStudy,
      'subject': subject,
      'price': price,
      'downloadable': downloadable,
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
