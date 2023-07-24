class NewsModel {
  String id;
  AuthorModel author;
  String title;
  String body;
  String category;
  String tag;
  String timestamp;

  NewsModel({
    required this.id,
    required this.author,
    required this.title,
    required this.body,
    required this.category,
    required this.tag,
    required this.timestamp,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      author: AuthorModel.fromJson(json['author']),
      title: json['title'],
      body: json['body'],
      category: json['category'],
      tag: json['tag'],
      timestamp: json['timestamp'],
    );
  }
}

class AuthorModel {
  String id;
  String name;
  String description;

  AuthorModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
