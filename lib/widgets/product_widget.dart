import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/cart.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/routes/product_detail_route.dart';

class ProductWidget extends StatelessWidget {
  void _navigation(BuildContext context, var _product) {
    Navigator.pushNamed(context, ProductDetailRoute.routeName,
        arguments: _product.id);
  }

  @override
  Widget build(BuildContext context) {
    final _product = Provider.of<Product>(context, listen: false);
    final _cart = Provider.of<CartProvider>(context, listen: false);
    final _scaffold = Scaffold.of(context);

    return GridTile(
      child: GestureDetector(
        onTap: () => _navigation(context, _product),
        child: Image.network(_product.imageUrl),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.blueGrey.withOpacity(0.8),
        title: Text(
          '${_product.title}',
          textAlign: TextAlign.center,
        ),
        leading: Consumer<Product>(
          builder: (ctx, productInstance, child) => IconButton(
            icon: Icon(productInstance.isFavourite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () async {
              try {
                await productInstance.toggleFavoriteStatus();
              } catch (error) {
                print(error.toString());
                _scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Updating failed!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            _cart.addItem(_product.id, _product.price, _product.title);
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("${_product.title} Added"),
              action: SnackBarAction(
                label: "UNDO",
                onPressed: () => _cart.removeSingleItem(_product.id),
              ),
            ));
          },
        ),
      ),
    );
  }
}
