import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/routes/product_detail_route.dart';

class ProductWidget extends StatelessWidget {
  final Product _product;

  ProductWidget(this._product);

  void _navigation(BuildContext context){
    Navigator.pushNamed(context, ProductDetailRoute.routeName,arguments: _product.id);
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () => _navigation(context),
        child: Image.network(_product.imageUrl),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.blueGrey.withOpacity(0.8),
        title: Text(
          '${_product.title}',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
