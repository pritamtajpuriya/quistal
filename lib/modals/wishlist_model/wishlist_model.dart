import 'dart:convert';

import 'package:singleclinic/modals/wishlist_model/wishlist_data_model.dart';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
  Wishlist({
    this.status,
    this.data,
  });

  bool status;
  List<WishlistData> data;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        status: json["status"],
        data: List<WishlistData>.from(
            json["data"].map((x) => WishlistData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
