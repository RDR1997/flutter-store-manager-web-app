// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  List<Product> products;

  Products({
    required this.products,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  int id;
  String name;
  String otherName;
  int brandId;
  String model;
  int price;
  int quantity;
  int distributorId;
  String note;
  int rackId;
  int rackLevel;
  int createdBy;
  DateTime createdDate;
  dynamic modifiedBy;
  dynamic modifiedDate;
  String brandName;
  String distributorName;
  List<Image> images;

  Product({
    required this.id,
    required this.name,
    required this.otherName,
    required this.brandId,
    required this.model,
    required this.price,
    required this.quantity,
    required this.distributorId,
    required this.note,
    required this.rackId,
    required this.rackLevel,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    required this.brandName,
    required this.distributorName,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        otherName: json["other_name"],
        brandId: json["brand_id"],
        model: json["model"],
        price: json["price"],
        quantity: json["quantity"],
        distributorId: json["distributor_id"],
        note: json["note"],
        rackId: json["rack_id"],
        rackLevel: json["rack_level"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        modifiedBy: json["modified_by"],
        modifiedDate: json["modified_date"],
        brandName: json["brandName"],
        distributorName: json["distributorName"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "other_name": otherName,
        "brand_id": brandId,
        "model": model,
        "price": price,
        "quantity": quantity,
        "distributor_id": distributorId,
        "note": note,
        "rack_id": rackId,
        "rack_level": rackLevel,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "modified_by": modifiedBy,
        "modified_date": modifiedDate,
        "brandName": brandName,
        "distributorName": distributorName,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  int productId;
  String imageUrl;
  int createdBy;
  DateTime createdDate;
  dynamic modifiedBy;
  dynamic modifiedDate;

  Image({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imageUrl: json["image_url"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        modifiedBy: json["modified_by"],
        modifiedDate: json["modified_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_url": imageUrl,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "modified_by": modifiedBy,
        "modified_date": modifiedDate,
      };
}
