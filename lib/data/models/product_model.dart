// lib/data/models/product_model.dart


import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String title,
    required String description,
    required double price,
    required String image,
  }) : super(
    id: id,
    title: title,
    description: description,
    price: price,
    image: image,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "image": image,
    };
  }
}