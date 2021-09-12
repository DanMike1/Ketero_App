import 'dart:convert';

class User {
  String email;
  String password;
  String? username;
  String? first_name;
  String? last_name;
  User(
      {required this.email,
      required this.password,
      this.username,
      this.first_name,
      this.last_name});

  User copyWith({
    String? email,
    String? password,
    String? username,
    String? first_name,
    String? last_name,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'first_name': first_name,
      'last_name': last_name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      password: map['password'],
      username: map['username'],
      first_name: map['first_name'],
      last_name: map['last_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'].toString(),
        password: json['password'].toString()
        // target_date: DateTime.parse(json['target_date']));
        );
  }

  @override
  String toString() {
    return 'User(email: $email, password: $password, username: $username,first_name: $first_name, last_name: $last_name)';
    //
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.password == password &&
        other.username == username &&
        other.first_name == first_name &&
        other.last_name == last_name;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        username.hashCode ^
        first_name.hashCode ^
        last_name.hashCode;
  }
}
