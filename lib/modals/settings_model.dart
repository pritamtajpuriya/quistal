// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  Settings({
    this.bankName,
    this.bankAccountNumber,
    this.esewaId,
  });

  String bankName;
  String bankAccountNumber;
  String esewaId;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    bankName: json["bank_name"],
    esewaId: json["esewa_id"],
    bankAccountNumber: json["bank_account_number"],
  );

  Map<String, dynamic> toJson() => {
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "esewa_id": esewaId,
  };
}
