// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.age,
    this.dob,
    this.gender,
    this.location,
    this.relation,
    this.phone,
    this.email,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String firstName;
  String lastName;
  int age;
  DateTime dob;
  String gender;
  String location;
  String relation;
  String phone;
  String email;
  String address;
  DateTime createdAt;
  DateTime updatedAt;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    age: json["age"],
    dob: json["dob"]!=null?DateTime.parse(json["dob"]):null,
    gender: json["gender"],
    location: json["location"],
    relation: json["relation"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "age": age,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "location": location,
    "relation": relation,
    "phone": phone,
    "email": email,
    "address": address,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
