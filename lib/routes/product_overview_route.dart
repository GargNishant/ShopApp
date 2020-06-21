import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/widgets/product_widget.dart';

enum FilterOptions{
  Favourites,
  All
}

class ProductOverviewRoute extends StatefulWidget {
  @override
  _ProductOverviewRouteState createState() => _ProductOverviewRouteState();
}

class _ProductOverviewRouteState extends State<ProductOverviewRoute> {
  var _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MyShop"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites)
                    _showFavourites = true;
                  else
                    _showFavourites = false;
                });

              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                  child: Text("Only Favourites"),
                  value: FilterOptions.Favourites,
                ),
                const PopupMenuItem(
                  child: Text("Show all"),
                  value: FilterOptions.All,
                ),
              ],
            )
          ],
        ),
        body: Consumer<ProductProvider>(
          builder: (ctx, productProvider, child) => GridView.builder(
            itemCount: _showFavourites ? productProvider.favouritesList.length : productProvider.productList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 16 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (ctx, index) {
              List<Product> list = _showFavourites ? productProvider.favouritesList : productProvider.productList;
              /*We are returning Observer for each of product individually. With this the individual Widgets, will
            not be rebuilding in change in some other item changes. Value binds the Notifier with it's values,
            thus recycling it along with widget for List item* */
              return ChangeNotifierProvider.value(
                value: list[index],
                child: ProductWidget(),
              );
            },
          ),
        ));
  }
}
