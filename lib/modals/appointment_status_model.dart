// To parse this JSON data, do
//
//     final apointmentStatus = apointmentStatusFromJson(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/patient_model.dart';

import 'Doctor_model.dart';

ApointmentStatus apointmentStatusFromJson(String str) => ApointmentStatus.fromJson(json.decode(str));

String apointmentStatusToJson(ApointmentStatus data) => json.encode(data.toJson());

class ApointmentStatus {
  ApointmentStatus({
    this.message,
    this.doctor,
    this.patient,
    this.hospital,
  });

  String message;
  Doctor doctor;
  Patient patient;
  dynamic hospital;

  factory ApointmentStatus.fromJson(Map<String, dynamic> json) => ApointmentStatus(
    message: json["message"],
    doctor: Doctor.fromMap(json["doctor"]),
    patient: Patient.fromJson(json["patient"]),
    hospital: json["hospital"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "doctor": doctor.toMap(),
    "patient": patient.toJson(),
    "hospital": hospital,
  };
}


