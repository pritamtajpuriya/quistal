// To parse this JSON data, do
//
//     final hospital = hospitalFromMap(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/department_model.dart';

Hospital hospitalFromMap(String str) => Hospital.fromMap(json.decode(str));

String hospitalToMap(Hospital data) => json.encode(data.toMap());

class Hospital {
  Hospital({
    this.id,
    this.userId,
    this.slug,
    this.name,
    this.firstName,
    this.lastName,
    this.subTitle,
    this.cityId,
    this.departmentIds,
    this.facilityIds,
    this.appointmentFee,
    this.type,
    this.logo,
    this.phone,
    this.address,
    this.email,
    this.detail,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.partnerType,
    this.document,
    this.status,
    this.departments,
    this.city
  });

  int id;
  int userId;
  String slug;
  String name;
  String firstName;
  dynamic lastName;
  dynamic subTitle;
  int cityId;
  String departmentIds;
  List<Department> departments;
  String facilityIds;
  int appointmentFee;
  String type;
  String logo;
  String phone;
  String address;
  String email;
  String detail;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic partnerType;
  dynamic document;
  String status;
  City city;

  factory Hospital.fromMap(Map<String, dynamic> json) => Hospital(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    slug: json["slug"] == null ? null : json["slug"],
    name: json["name"] == null ? null : json["name"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"],
    subTitle: json["sub_title"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    departmentIds: json["department_ids"] == null ? null : json["department_ids"],
    facilityIds: json["facility_ids"] == null ? null : json["facility_ids"],
    appointmentFee: json["appointment_fee"] == null ? null : json["appointment_fee"],
    type: json["type"] == null ? null : json["type"],
    logo: json["logo"] == null ? null : json["logo"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    email: json["email"] == null ? null : json["email"],
    detail: json["detail"] == null ? null : json["detail"],
    password: json["password"] == null ? null : json["password"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    partnerType: json["partner_type"],
    document: json["document"],
    departments: json["departments"] == null ? null : List<Department>.from(json["departments"].map((x) => Department.fromMap(x))),
    status: json["status"] == null ? null : json["status"],
    city: City.fromMap(json['city']),
 
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "slug": slug == null ? null : slug,
    "name": name == null ? null : name,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName,
    "sub_title": subTitle,
    "city_id": cityId == null ? null : cityId,
    "department_ids": departmentIds == null ? null : departmentIds,
    "facility_ids": facilityIds == null ? null : facilityIds,
    "appointment_fee": appointmentFee == null ? null : appointmentFee,
    "type": type == null ? null : type,
    "logo": logo == null ? null : logo,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "email": email == null ? null : email,
    "detail": detail == null ? null : detail,
    "password": password == null ? null : password,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "partner_type": partnerType,
    "document": document,
    "status": status == null ? null : status,
  };
}

class City {
  int id;
  String name;

  City({
    this.id,
    this.name
  });

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,

  };

}
