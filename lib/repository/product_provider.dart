import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/repository/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _productList = List();
  Map<String, Product> _idProductMap = Map();

  List<Product> get productList {
    return [..._productList];
  }

  List<Product> get favouritesList {
    return _productList.where((element) => element.isFavourite).toList();
  }

  /// Adding a new Item into the Existing List of products
  /// Calling the NotifyListeners is like calling setValue in Observers. But on all the member variables
  Future<void> addProduct(Product product) async {
    const url = "https://flutter-shop-e0ed8.firebaseio.com/products.json";
    try {
      final result =
          await http.post(url, body: json.encode(product.toJsonMap()));
      final _product = Product(
          title: product.title,
          description: product.description,
          id: json.decode(result.body)['name'],
          imageUrl: product.imageUrl,
          price: product.price,
          isFavourite: product.isFavourite);

      _productList.add(_product);
      _idProductMap[_product.id] = _product;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Product getProduct(String id) {
    if (_idProductMap[id] is Product) return _idProductMap[id];
    return null;
  }

  void updateProduct(Product product) {
    final prodIndex =
        _productList.indexWhere((element) => element.id == product.id);
    if (prodIndex >= 0) {
      _productList[prodIndex] = product;
      _idProductMap[product.id] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _productList.removeWhere((element) => element.id == id);
    _idProductMap.remove(id);
    notifyListeners();
  }

  Future<void> fetchData() async {
    const url = "https://flutter-shop-e0ed8.firebaseio.com/products.json";
    try {
      final _response = await http.get(url);
      print(json.decode(_response.body).runtimeType);
      final extractedData = json.decode(_response.body) as Map<String, dynamic>;
      final List<Product> loadedList = List();
      final Map<String, Product> map = Map();

      extractedData.forEach((prodId, prodData) {
        final product = Product(
        id: prodId,
        title: prodData['title'],
        description: prodData['description'],
        imageUrl: prodData['imageUrl'],
        price: prodData['price'],
        isFavourite: prodData['isFavourite']);

        loadedList.add(product);
        map[prodId] = product;
      });
      _productList.addAll(loadedList);
      _idProductMap.addAll(map);

    } catch (error) {
      throw error;
    }
  }
}
