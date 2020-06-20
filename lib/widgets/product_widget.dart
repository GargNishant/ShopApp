import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ProductWidget extends StatelessWidget {
  final Product _product;

  ProductWidget(this._product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(_product.imageUrl),
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
