import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems;

  CartProvider(){
    _cartItems = Map();
  }

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  List<CartItem> get itemList {
    return [...items.values.toList()];
  }

  List<String> get keyList {
    return [...items.keys.toList()];
  }

  int get itemCount{
    return _cartItems.length;
  }

  double get totalAmount{
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }
}
