class WishlistData {
  WishlistData({
    this.id,
    this.sellerId,
    this.name,
    this.slug,
    this.categoryId,
    this.subCategoryId,
    this.photo,
    this.description,
    this.price,
    this.offerPrice,
    this.quantity,
    this.type,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int sellerId;
  String name;
  String slug;
  int categoryId;
  int subCategoryId;
  String photo;
  String description;
  String price;
  int offerPrice;
  int quantity;
  String type;
  DateTime expiryDate;
  DateTime createdAt;
  DateTime updatedAt;

  factory WishlistData.fromJson(Map<String, dynamic> json) => WishlistData(
        id: json["id"],
        sellerId: json["seller_id"],
        name: json["name"],
        slug: json["slug"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        photo: json["photo"],
        description: json["description"],
        price: json["price"],
        offerPrice: json["offer_price"],
        quantity: json["quantity"],
        type: json["type"],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "slug": slug,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "photo": photo,
        "description": description,
        "price": price,
        "offer_price": offerPrice,
        "quantity": quantity,
        "type": type,
        "expiry_date": expiryDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
