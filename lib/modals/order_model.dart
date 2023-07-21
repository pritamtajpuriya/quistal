// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:singleclinic/modals/product_model.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  int id;
  int userId;
  String products;
  String totalPrice;
  String paymentMethod;
  String status;
  String address;
  String city;
  String zipCode;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderDetail> orderDetail;

  Order(
      {this.id,
      this.userId,
      this.products,
      this.totalPrice,
      this.paymentMethod,
      this.status,
      this.address,
      this.city,
      this.zipCode,
      this.createdAt,
      this.updatedAt,
      this.orderDetail});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    products = json['products'];
    totalPrice = json['total_price'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    address = json['address'];
    city = json['city'];
    zipCode = json['zip_code'];
    createdAt =
        json['created_at'] == null ? null : DateTime.parse(json['created_at']);
    updatedAt =
        json['updated_at'] == null ? null : DateTime.parse(json['updated_at']);
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetail>[];
      json['order_detail'].forEach((v) {
        orderDetail.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['products'] = this.products;
    data['total_price'] = this.totalPrice;
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['created_at'] =
        createdAt == null ? null : this.createdAt.toIso8601String();
    data['updated_at'] =
        updatedAt == null ? null : this.updatedAt.toIso8601String();
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  int id;
  int orderId;
  int userId;
  int productId;
  int quantity;
  String amount;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  OrderDetail(
      {this.id,
      this.orderId,
      this.userId,
      this.productId,
      this.quantity,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    amount = json['amount'];
    status = json['status'];
    createdAt =
        json['created_at'] == null ? null : DateTime.parse(json['created_at']);
    updatedAt =
        json['updated_at'] == null ? null : DateTime.parse(json['updated_at']);
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] =
        createdAt == null ? null : this.createdAt.toIso8601String();
    data['updated_at'] =
        updatedAt == null ? null : this.updatedAt.toIso8601String();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}
