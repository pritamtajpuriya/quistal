import 'dart:convert';

DoctorAppointment appointmentFromJson(String str) => DoctorAppointment.fromJson(json.decode(str));

String appointmentToJson(DoctorAppointment data) => json.encode(data.toJson());


class DoctorAppointment{
  DoctorAppointment({
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
    this.status
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
  String status;

  factory DoctorAppointment.fromJson(Map<String, dynamic> json) => DoctorAppointment(
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
    "status": status,
  };

}