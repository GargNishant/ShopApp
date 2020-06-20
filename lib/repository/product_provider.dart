
import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';


class ProductProvider with ChangeNotifier{
  List<Product> _productList = List();

  List<Product> get productList{
    return [..._productList];
  }

  /// Adding a new Item into the Existing List of products
  /// Calling the NotifyListeners is like calling setValue in Observers. But on all the member variables
  void addProduct(Product product){
//    _productList.add(product);
    notifyListeners();
  }

}