import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/main_drawer.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/routes/edit_product_route.dart';
import 'package:shopapp/widgets/user_product_widget.dart';

class UserProductsRoute extends StatelessWidget {
  static const routeName = "/user-product-route";
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    final _productList = _productProvider.productList;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text("Your Products"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductRoute.routeName);
                },
              ),
            ]),
        drawer: MainDrawer(),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _productList.length,
            itemBuilder: (ctx, index) {
              return Column(children: <Widget>[
                UserProductWidget(_productList[index]),
                Divider(),
              ]);
            },
          ),
        ));
  }
}
