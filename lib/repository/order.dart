
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
  
  void addOrder(List<CartItem> cartProducts, double totalAmount){
    _orders.add(Order(id: DateTime.now().toString(),amount: totalAmount,dateTime: DateTime.now(),products: cartProducts));
    notifyListeners();
  }
}
