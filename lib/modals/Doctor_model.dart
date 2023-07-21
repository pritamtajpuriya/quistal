// To parse this JSON data, do
//
//     final doctor = doctorFromMap(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/department_model.dart';

Doctor doctorFromMap(String str) => Doctor.fromMap(json.decode(str));

String doctorToMap(Doctor data) => json.encode(data.toMap());

class Doctor {
  Doctor({
    this.id,
    this.userId,
    this.departmentId,
    this.hospitalId,
    this.name,
    this.email,
    this.password,
    this.phoneNo,
    this.nmc,
    this.workType,
    this.qualification,
    this.appointmentFee,
    this.experience,
    this.workingHour,
    this.aboutUs,
    this.service,
    this.image,
    this.facebookId,
    this.twitterId,
    this.googleId,
    this.instagramId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.todayAvailableTimes,
    this.tomorrowAvailableTimes,
    this.dayAfterTomorrowAvailableTimes,
    this.department
  });

  int id;
  int userId;
  int departmentId;
  int hospitalId;
  String name;
  String email;
  String password;
  String phoneNo;
  dynamic nmc;
  dynamic workType;
  dynamic qualification;
  int appointmentFee;
  String experience;
  dynamic workingHour;
  String aboutUs;
  String service;
  String image;
  String facebookId;
  String twitterId;
  String googleId;
  String instagramId;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  AvailableTimes todayAvailableTimes;
  AvailableTimes tomorrowAvailableTimes;
  AvailableTimes dayAfterTomorrowAvailableTimes;
  Department department;
  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    departmentId: json["department_id"] == null ? null : json["department_id"],
    hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    phoneNo: json["phone_no"] == null ? null : json["phone_no"],
    nmc: json["nmc"],
    workType: json["work_type"],
    qualification: json["qualification"],
    appointmentFee: json["appointment_fee"] == null ? null : json["appointment_fee"],
    experience: json["experience"] == null ? null : json["experience"],
    workingHour: json["working_hour"],
    aboutUs: json["about_us"] == null ? null : json["about_us"],
    service: json["service"] == null ? null : json["service"],
    image: json["image"] == null ? null : json["image"],
    facebookId: json["facebook_id"] == null ? null : json["facebook_id"],
    twitterId: json["twitter_id"] == null ? null : json["twitter_id"],
    googleId: json["google_id"] == null ? null : json["google_id"],
    instagramId: json["instagram_id"] == null ? null : json["instagram_id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    todayAvailableTimes: json["todayAvailableTimes"] == null ? null : AvailableTimes.fromMap(json["todayAvailableTimes"]),
    tomorrowAvailableTimes: json["tomorrowAvailableTimes"] == null ? null : AvailableTimes.fromMap(json["tomorrowAvailableTimes"]),
    dayAfterTomorrowAvailableTimes: json["dayAfterTomorrowAvailableTimes"] == null ? null : AvailableTimes.fromMap(json["dayAfterTomorrowAvailableTimes"]),
    department: json["department"] == null ? null :Department.fromMap(json['department']),
  
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "department_id": departmentId == null ? null : departmentId,
    "hospital_id": hospitalId == null ? null : hospitalId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "phone_no": phoneNo == null ? null : phoneNo,
    "nmc": nmc,
    "work_type": workType,
    "qualification": qualification,
    "appointment_fee": appointmentFee == null ? null : appointmentFee,
    "experience": experience == null ? null : experience,
    "working_hour": workingHour,
    "about_us": aboutUs == null ? null : aboutUs,
    "service": service == null ? null : service,
    "image": image == null ? null : image,
    "facebook_id": facebookId == null ? null : facebookId,
    "twitter_id": twitterId == null ? null : twitterId,
    "google_id": googleId == null ? null : googleId,
    "instagram_id": instagramId == null ? null : instagramId,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "todayAvailableTimes": todayAvailableTimes == null ? null : todayAvailableTimes.toMap(),
    "tomorrowAvailableTimes": tomorrowAvailableTimes == null ? null : tomorrowAvailableTimes.toMap(),
    "dayAfterTomorrowAvailableTimes": dayAfterTomorrowAvailableTimes == null ? null : dayAfterTomorrowAvailableTimes.toMap(),
    "department": department == null ? null : department.toMap(),

  };
}

class AvailableTimes {
  AvailableTimes({
    this.date,
    this.from,
    this.to,
    this.availableTimes,
    this.token
  });

  DateTime date;
  String from;
  String to;
  List<String> availableTimes;
  int token;

  factory AvailableTimes.fromMap(Map<String, dynamic> json) => AvailableTimes(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
    token: json["to"] == null ? null : json["token"],

    availableTimes: json["availableTimes"] == null ? null : List<String>.from(json["availableTimes"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "from": from == null ? null : from,
    "to": to == null ? null : to,
    "availableTimes": availableTimes == null ? null : List<dynamic>.from(availableTimes.map((x) => x)),
  };
}
