// To parse this JSON data, do
//
//     final department = departmentFromMap(jsonString);

import 'dart:convert';

Department departmentFromMap(String str) => Department.fromMap(json.decode(str));

String departmentToMap(Department data) => json.encode(data.toMap());

class Department {
  Department({
    this.id,
    this.slug,
    this.name,
    this.image,
    this.description,
    this.emergencyNo,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.pivot,
    this.doctorsCount

  });

  int id;
  String slug;
  String name;
  String image;
  String description;
  String emergencyNo;
  DateTime createdAt;
  DateTime updatedAt;
  String isDeleted;
  Pivot pivot;
  int doctorsCount;

  factory Department.fromMap(Map<String, dynamic> json) => Department(
    id: json["id"] == null ? null : json["id"],
    slug: json["slug"] == null ? null : json["slug"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
    emergencyNo: json["emergency_no"] == null ? null : json["emergency_no"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
    pivot: json["pivot"] == null ? null : Pivot.fromMap(json["pivot"]),
    doctorsCount: json["doctors_count"] == null ? null : json["doctors_count"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "slug": slug == null ? null : slug,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
    "emergency_no": emergencyNo == null ? null : emergencyNo,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "is_deleted": isDeleted == null ? null : isDeleted,
    "pivot": pivot == null ? null : pivot.toMap(),
    "doctors_count": doctorsCount == null ? null : doctorsCount,
  };
}

class Pivot {
  Pivot({
    this.hospitalId,
    this.departmentId,
  });

  int hospitalId;
  int departmentId;

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
    hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
    departmentId: json["department_id"] == null ? null : json["department_id"],
  );

  Map<String, dynamic> toMap() => {
    "hospital_id": hospitalId == null ? null : hospitalId,
    "department_id": departmentId == null ? null : departmentId,
  };
}
