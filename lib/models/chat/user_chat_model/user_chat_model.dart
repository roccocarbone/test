class UserModelChat {
  final String id;
  final String name;
  final String surname;
  final String username;

  UserModelChat({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
  });

  factory UserModelChat.fromJson(Map<String, dynamic> json) {
    return UserModelChat(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
    );
  }
}