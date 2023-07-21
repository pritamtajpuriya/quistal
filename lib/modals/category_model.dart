// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.subCategories
  });

  int id;
  String name;
  String image;
  String slug;
  List<SubCategory> subCategories;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    slug: json["slug"] == null ? null : json["slug"],
    subCategories: json["sub_category"] == null
        ? null
        : List<SubCategory>.from(
        json["sub_category"].map((x) => SubCategory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "slug": slug == null ? null : slug,
    "sub_category": subCategories == null
        ? null
        : List<SubCategory>.from(subCategories.map((x) => x.toMap())),
  };
}

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.slug,
  });

  int id;
  String name;
  String image;
  int categoryId;
  String slug;

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    image: json["image"] == null ? null : json["image"],
    slug: json["slug"] == null ? null : json["slug"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "category_id": categoryId == null ? null : categoryId,
    "image": image == null ? null : image,
    "slug": slug == null ? null : slug,
  };
}

