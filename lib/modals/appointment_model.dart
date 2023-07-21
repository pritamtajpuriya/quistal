// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/patient_model.dart';

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));

String appointmentToJson(Appointment data) => json.encode(data.toJson());

class Appointment {
  Appointment({
    this.id,
    this.departmentId,
    this.docId,
    this.serviceId,
    this.userId,
    this.patientId,
    this.name,
    this.phoneNo,
    this.date,
    this.time,
    this.messages,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.department,
    this.patient
  });

  int id;
  int departmentId;
  int docId;
  int serviceId;
  int userId;
  int patientId;
  String name;
  String phoneNo;
  DateTime date;
  String time;
  dynamic messages;
  DateTime createdAt;
  DateTime updatedAt;
  String status;
  Department department;
  Patient patient;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      id: json["id"],
      departmentId: json["department_id"],
      docId: json["doc_id"],
      serviceId: json["service_id"],
      userId: json["user_id"],
      patientId: json["patient_id"],
      name: json["name"],
      phoneNo: json["phone_no"],
      time: json["time"],
      messages: json["messages"],
      status: json["status"],
      department: Department.fromMap(json['department']),
      patient: Patient.fromJson(json['patient'])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "department_id": departmentId,
    "doc_id": docId,
    "service_id": serviceId,
    "user_id": userId,
    "patient_id": patientId,
    "name": name,
    "phone_no": phoneNo,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "messages": messages,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
  };
}
