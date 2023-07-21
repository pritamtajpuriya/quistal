// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.slug,
    this.categoryId,
    this.subCategoryId,
    this.photo,
    this.description,
    this.price,
    this.quantity,
    this.type,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
    this.offeredprice,
  });

  int id;
  String name;
  String slug;
  int categoryId;
  dynamic subCategoryId;
  String photo;
  String description;
  String price;
  int quantity;
  String type;
  DateTime expiryDate;
  DateTime createdAt;
  DateTime updatedAt;
  int offeredprice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    photo: json["photo"],
    description: json["description"],
    price: json["price"],
    quantity: json["quantity"],
    type: json["type"],
    offeredprice: json["offer_price"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "photo": photo,
    "description": description,
    "price": price,
    "quantity": quantity,
    "type": type,
    "expiry_date": expiryDate.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "offer_price": offeredprice,
  };
}
