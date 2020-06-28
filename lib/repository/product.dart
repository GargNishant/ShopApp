import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  static Product cloneProductWithDescription(String description, Product product) {
    return Product(
        id: product.id,
        price: product.price,
        imageUrl: product.imageUrl,
        description: description,
        title: product.title,
        isFavourite: product.isFavourite);
  }

  static Product cloneProductWithTitle(String title, Product product) {
    return Product(
        id: product.id,
        price: product.price,
        imageUrl: product.imageUrl,
        description: product.description,
        title: title,
        isFavourite: product.isFavourite);
  }

  static Product cloneProductWithPrice(double price, Product product) {
    return Product(
        id: product.id,
        price: price,
        imageUrl: product.imageUrl,
        description: product.description,
        title: product.title,
        isFavourite: product.isFavourite);
  }

  static Product cloneProductWithImage(String imageUrl, Product product) {
    return Product(
        id: product.id,
        price: product.price,
        imageUrl: imageUrl,
        description: product.description,
        title: product.title,
        isFavourite: product.isFavourite);
  }

  void toggleFavoriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  Map<String,Object> toJsonMap() {
    Map<String, Object> map = Map();
    map["title"] = this.title;
    map["price"] = this.price;
    map['description'] = this.description;
    map['isFavourite'] = this.isFavourite;
    map['imageUrl'] = this.imageUrl;
    map['id'] = this.id;
    return map;
  }
}
