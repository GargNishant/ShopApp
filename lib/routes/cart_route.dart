import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/cart.dart';
import 'package:shopapp/repository/order.dart';
import 'package:shopapp/widgets/cart_item_widget.dart';

class CartRoute extends StatelessWidget {
  static const routeName = "/cart-route";
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    final _cartItemList = _cartProvider.itemList;
    final _cartProdIdList = _cartProvider.keyList;
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
                  Text("Total", style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(
                    label: Text("\$${_cartProvider.totalAmount}"),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartItemList: _cartItemList, cartProvider: _cartProvider)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _cartProvider.itemCount,
              itemBuilder: (context, index) {
                return CartItemWidget(
                    _cartItemList[index], _cartProdIdList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required List<CartItem> cartItemList,
    @required CartProvider cartProvider,
  })  : _cartItemList = cartItemList,
        _cartProvider = cartProvider,
        super(key: key);

  final List<CartItem> _cartItemList;
  final CartProvider _cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() :Text("Order Now"),
      onPressed: (widget._cartItemList.length <= 0 || _isLoading)
          ? null
          : () async {
              setState(() => _isLoading = true);
              await Provider.of<OrderProvider>(context, listen: false).addOrder(
                  widget._cartItemList, widget._cartProvider.totalAmount);
              widget._cartProvider.clearCart();
              setState(() => _isLoading = false);
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
