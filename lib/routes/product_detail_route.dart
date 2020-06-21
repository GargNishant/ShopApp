import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product_provider.dart';

class ProductDetailRoute extends StatelessWidget {
  static const routeName = "/product-detail-route";

  @override
  Widget build(BuildContext context) {
    final _productId = ModalRoute.of(context).settings.arguments as String;

    /* This widget is listening to the Whole List, thus will be rebuild on every changes in List.
    If we do not want to rebuild every time and just want to listen once then turn off, then we can use
    Provider.of<ProductProvider>(context,listen:false). This will make it not to rebuild every time.
    * */
    final _productProvider = Provider.of<ProductProvider>(context);
    final _selectedProduct = _productProvider.getProduct(_productId);

    return Scaffold(
      appBar: AppBar(
        title: Text("${_selectedProduct.title}"),
      ),
    );
  }
}
