class CreateUserModel {
  String name;
  String surname;
  String email;
  String username;
  String password;
  String birthday;

  CreateUserModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.username,
    required this.password,
    required this.birthday,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['birthday'] = this.birthday;
    return data;
  }
}
