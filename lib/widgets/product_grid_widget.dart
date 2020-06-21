import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/widgets/product_widget.dart';

class ProductGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    final _productList = _productProvider.productList;
    return GridView.builder(
      itemCount: _productList.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) {
        /*We are returning Observer for each of product individually. With this the individual Widgets, will
        not be rebuilding in change in some other item changes. Value binds the Notifier with it's values,
        thus recycling it along with widget for List item* */
        return ChangeNotifierProvider.value(
          value: _productList[index],
          child: ProductWidget(),
        );
      },
    );
  }
}
