import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/main_drawer.dart';
import 'package:shopapp/repository/order.dart';
import 'package:shopapp/widgets/order_item_widget.dart';

class OrdersRoute extends StatefulWidget {
  static const routeName = "/order-route";

  @override
  _OrdersRouteState createState() => _OrdersRouteState();
}

class _OrdersRouteState extends State<OrdersRoute> {
  var _isInitialized = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      setState(() => _isLoading = true);

      orderProvider.fetchData().then((value) {
        setState(() => _isLoading = false);
      }).catchError((error) {
        setState(() => _isLoading = false);
      });
    }
    _isInitialized = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _orderList = _orderProvider.orders;
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return OrderItemWidget(_orderList[index]);
              },
              itemCount: _orderList.length,
            ),
      drawer: MainDrawer(),
    );
  }
}
