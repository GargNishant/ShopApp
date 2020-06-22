import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem _cartItem;
  final String _cartProductId;

  CartItemWidget(this._cartItem, this._cartProductId);

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    return Dismissible(
      key: ValueKey(_cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete_forever,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(_cartProductId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text("\$${_cartItem.price}"),
            ),
            title: Text(_cartItem.title),
            subtitle: Text("Total: \$${_cartItem.price * _cartItem.quantity}"),
            trailing: Text("${_cartItem.quantity} x"),
          ),
        ),
      ),
    );
  }
}
