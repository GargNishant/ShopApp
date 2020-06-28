import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/routes/edit_product_route.dart';

class UserProductWidget extends StatelessWidget {
  final Product _product;

  UserProductWidget(this._product);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pushNamed(
                  EditProductRoute.routeName,
                  arguments: _product.id),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async {
                  Provider.of<ProductProvider>(context, listen: false).deleteProduct(_product.id).catchError((error) {
                    scaffold.showSnackBar(
                      SnackBar(
                          content: Text(
                            'Deleting failed!',
                            textAlign: TextAlign.center,
                          )),
                    );
                  });

              },
            ),
          ],
        ),
      ),
    );
  }
}
