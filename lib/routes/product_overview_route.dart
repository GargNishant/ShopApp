import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/main_drawer.dart';
import 'package:shopapp/repository/cart.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/routes/cart_route.dart';
import 'package:shopapp/widgets/cart_badge.dart';
import 'package:shopapp/widgets/product_widget.dart';

enum FilterOptions { Favourites, All }

class ProductOverviewRoute extends StatefulWidget {
  @override
  _ProductOverviewRouteState createState() => _ProductOverviewRouteState();
}

void _cartRouteNavigation(BuildContext context){
  Navigator.of(context).pushNamed(CartRoute.routeName);
}

class _ProductOverviewRouteState extends State<ProductOverviewRoute> {
  var _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MyShop"),
          actions: <Widget>[
            Consumer<CartProvider>(
              builder: (ctx, cartProvider, childIcon) => CartBadge(
                child: childIcon,
                value: cartProvider.itemCount.toString(),
              ),
              child: IconButton(
                onPressed: () => _cartRouteNavigation(context),
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites)
                    _showFavourites = true;
                  else
                    _showFavourites = false;
                });
              },
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
            ),
          ],
        ),
        body: Consumer<ProductProvider>(
          builder: (ctx, productProvider, child) => GridView.builder(
            itemCount: _showFavourites
                ? productProvider.favouritesList.length
                : productProvider.productList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 16 / 9,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (ctx, index) {
              List<Product> list = _showFavourites
                  ? productProvider.favouritesList
                  : productProvider.productList;
              return ChangeNotifierProvider.value(
                value: list[index],
                child: ProductWidget(),
              );
            },
          ),
        ),
      drawer: MainDrawer(),
    );
  }
}
