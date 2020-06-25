import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/main_drawer.dart';
import 'package:shopapp/repository/order.dart';
import 'package:shopapp/widgets/order_item_widget.dart';

class OrdersRoute extends StatelessWidget {
  static const routeName = "/order-route";

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _orderList = _orderProvider.orders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return OrderItemWidget(_orderList[index]);
        },
        itemCount: _orderList.length,
      ),
      drawer: MainDrawer(),
    );
  }
}
