// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

// Prescription productFromJson(String str) => Prescription.fromJson(json.decode(str));
//
// String productToJson(Prescription data) => json.encode(data.toJson());

class Prescription {
  Prescription({
    this.id,
    this.name,
    this.mobile,
    this.message,
    this.path,
    this.deliveryAddress,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.preptime,
  });

  int id;
  String name;
  String mobile;
  String message;
  String path;
  String deliveryAddress;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String preptime;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        message: json["message"],
        path: json["path"],
        deliveryAddress: json["delivery_address"],
        userId: json["user_id"],
        preptime: json["created_at"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "message": message,
        "path": path,
        "delivery_address": deliveryAddress,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
