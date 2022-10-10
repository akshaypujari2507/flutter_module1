// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

enum Gender { male, female }

enum Status { active, inactive }

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  int? id;
  String name;
  String email;
  String gender;
  String status;
  // final Gender gender;
  // final Status status;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    status: json["status"],
    // gender: enumDecode(_$Gender, json['gender']),
    // status: enumDecode(_$Status, json['status']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "status": status,
  };

  static const _$GenderEnumMap = {
    Gender.male: 'male',
    Gender.female: 'female',
  };

  static const _$StatusEnumMap = {
    Status.active: 'active',
    Status.inactive: 'inactive',
  };

}
