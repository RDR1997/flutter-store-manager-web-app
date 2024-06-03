// To parse this JSON data, do
//
//     final productImages = productImagesFromJson(jsonString);

import 'dart:convert';

ProductImages productImagesFromJson(String str) =>
    ProductImages.fromJson(json.decode(str));

String productImagesToJson(ProductImages data) => json.encode(data.toJson());

class ProductImages {
  List<ProductImage> productImages;

  ProductImages({
    required this.productImages,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_images":
            List<dynamic>.from(productImages.map((x) => x.toJson())),
      };
}

class ProductImage {
  int id;
  int productId;
  String imageUrl;
  int createdBy;
  DateTime createdDate;
  dynamic modifiedBy;
  dynamic modifiedDate;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
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
