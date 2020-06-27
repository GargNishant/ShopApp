import 'package:flutter/material.dart';
import 'package:shopapp/repository/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _productList = List();
  Map<String, Product> _idProductMap = Map();

  ProductProvider() {
    _productList.add(Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ));
    _productList.add(Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ));
    _productList.add(Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ));
    _productList.add(Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ));
    _idProductMap[_productList[0].id] = _productList[0];
    _idProductMap[_productList[1].id] = _productList[1];
    _idProductMap[_productList[2].id] = _productList[2];
    _idProductMap[_productList[3].id] = _productList[3];
  }

  List<Product> get productList {
    return [..._productList];
  }

  List<Product> get favouritesList {
    return _productList.where((element) => element.isFavourite).toList();
  }

  /// Adding a new Item into the Existing List of products
  /// Calling the NotifyListeners is like calling setValue in Observers. But on all the member variables
  void addProduct(Product product) {
    final _product = Product(
        title: product.title,
        description: product.description,
        id: DateTime.now().toString(),
        imageUrl: product.imageUrl,
        price: product.price,
        isFavourite: product.isFavourite);

    _productList.add(_product);
    _idProductMap[_product.id] = _product;
    notifyListeners();
  }

  Product getProduct(String id) {
    if (_idProductMap[id] is Product) return _idProductMap[id];
    return null;
  }
}
