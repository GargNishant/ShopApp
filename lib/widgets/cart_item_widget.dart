import 'package:flutter/material.dart';
import 'package:shopapp/repository/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem _cartItem;

  CartItemWidget(this._cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(child: Text("\$${_cartItem.price}"),),
          title: Text(_cartItem.title),
          subtitle: Text("Total: \$${_cartItem.price * _cartItem.quantity}"),
          trailing: Text("${_cartItem.quantity} x"),
        ),
      ),
    );
  }
}
