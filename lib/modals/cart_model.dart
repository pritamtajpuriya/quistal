// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/product_model.dart';

Cart castFromJson(String str) => Cart.fromJson(json.decode(str));

String castToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart(
      {this.id,
      this.cartId,
      this.userId,
      this.productId,
      this.quantity,
      this.amount,
      this.status,
      this.price,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.product});

  int id;
  int cartId;
  int userId;
  int productId;
  //dynamic subCategoryId;
  int quantity;
  String amount;
  String status;
  String price;

  String type;

  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      id: json["id"],
      cartId: json["cart_id"],
      userId: json["user_id"],
      productId: json["product_id"],
      quantity: json["quantity"],
      amount: json["amount"],
      status: json["status"],
      price: json["price"],
      type: json["type"],
      product: Product.fromJson(json["product"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "user_id": userId,
        "product_id": productId,
        "quantity": quantity,
        "amount": amount,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson()
      };
}


// "id": 6,
//             "cart_id": 4,
//             "user_id": 64,
//             "product_id": 2,
//             "quantity": 2,
//             "amount": "200.00",
//             "status": "Pending",
//             "created_at": "2022-10-18T06:48:26.000000Z",
//             "updated_at": "2022-10-18T10:35:25.000000Z",
//             "product
