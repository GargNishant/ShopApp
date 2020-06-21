import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/widgets/product_widget.dart';

class ProductOverviewRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: Consumer<ProductProvider>(
        builder: (ctx, productProvider, child) => GridView.builder(
          itemCount: productProvider.productList.length,
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
              value: productProvider.productList[index],
              child: ProductWidget(),
            );
          },
        ),
      )
    );
  }
}
