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

  Map<String, Object> toJsonMap(){
    Map<String, Object> map = Map();
    map['id'] = this.id;
    map['title'] = this.title;
    map['quantity'] = this.quantity;
    map['price'] = this.price;
    return map;
  }

  static CartItem fromJsonMap(Map<String, dynamic> map){
    final cartItem = CartItem(id: map['id'], price: map['price'], title: map['title'], quantity: map['quantity']);
    return cartItem;
  }
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

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
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

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeSingleItem(String _prodId) {
    if (!_cartItems.containsKey(_prodId)) return;
    if (_cartItems[_prodId].quantity > 1)
      _cartItems.update(
          _prodId,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              title: value.title,
              quantity: value.quantity - 1));
    else
      _cartItems.remove(_prodId);

    notifyListeners();
  }
}
