import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shopapp/repository/cart.dart';

class Order with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class OrderProvider with ChangeNotifier {
  List<Order> _orders;
  
  OrderProvider(){
    _orders = List();
  }
  
  List<Order> get orders{
    return [..._orders];
  }
  
  Future<void> addOrder(List<CartItem> cartProducts, double totalAmount) async{
    final url = "https://flutter-shop-e0ed8.firebaseio.com/orders.json";
    final timeStamp = DateTime.now();
    final _response = await http.post(url,body: json.encode({
      "dateTime": timeStamp.toIso8601String(),
      "amount" : totalAmount,
      "products": cartProducts.map((item) => item.toJsonMap()).toList(),
    }));
    _orders.add(Order(id: json.decode(_response.body)['name'],amount: totalAmount,dateTime: timeStamp,products: cartProducts));
    notifyListeners();
  }
}
