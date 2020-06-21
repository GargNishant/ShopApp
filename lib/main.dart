import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/routes/product_detail_route.dart';
import 'package:shopapp/routes/product_overview_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // When Initializing a class, use without value, and when using existing
    // instance, use value
    return ChangeNotifierProvider(
        create: (buildContext) => ProductProvider(),
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Lato",
          ),
          initialRoute: "/",
          routes: {
            '/': (ctx) => ProductOverviewRoute(),
            ProductDetailRoute.routeName : (ctx) => ProductDetailRoute(),
          },
        ));
  }
}
