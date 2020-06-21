import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/routes/product_detail_route.dart';

class ProductWidget extends StatelessWidget {

  void _navigation(BuildContext context, var _product){
    Navigator.pushNamed(context, ProductDetailRoute.routeName,arguments: _product.id);
  }

  @override
  Widget build(BuildContext context) {
    //Listening to the Provider of this product only
    final _product = Provider.of<Product>(context);

    return GridTile(
      child: GestureDetector(
        onTap: () => _navigation(context,_product),
        child: Image.network(_product.imageUrl),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.blueGrey.withOpacity(0.8),
        title: Text(
          '${_product.title}',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(_product.isFavourite ? Icons.favorite : Icons.favorite_border),
          onPressed: _product.toggleFavoriteStatus,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
