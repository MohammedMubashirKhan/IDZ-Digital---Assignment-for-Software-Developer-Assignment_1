import 'dart:convert';

class User {
  String name;
  String birthDate;
  String email;
  User({
    required this.name,
    required this.birthDate,
    required this.email,
  });
  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      name: jsonData['name'],
      birthDate: jsonData['birthDate'],
      email: jsonData['email'],
    );
  }

  static Map<String, dynamic> toMap(User user) => {
        "name": user.name,
        "birthDate": user.birthDate,
        "email": user.email,
      };

  static String encode(List<User> users) => json.encode(
        users.map<Map<String, dynamic>>((user) => User.toMap(user)).toList(),
      );

  static List<User> decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
}
