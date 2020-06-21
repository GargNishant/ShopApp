
import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';


class ProductProvider with ChangeNotifier{
  List<Product> _productList = List();
  Map<String, Product> _idProductMap = Map();


  List<Product> get productList{
    return [..._productList];
  }

  /// Adding a new Item into the Existing List of products
  /// Calling the NotifyListeners is like calling setValue in Observers. But on all the member variables
  void addProduct(Product product){

    notifyListeners();
  }

  Product getProduct(String id){
    if(_idProductMap[id] is Product)
      return _idProductMap[id];
    return null;
  }

}