import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/cart.dart';
import 'package:shopapp/widgets/cart_item_widget.dart';

class CartRoute extends StatelessWidget {
  static const routeName = "/cart-route";
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    final _cartItemList = _cartProvider.itemList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text("\$${_cartProvider.totalAmount}"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("Order Now"),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cartProvider.itemCount,
              itemBuilder: (context,index) {
                return CartItemWidget(_cartItemList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
