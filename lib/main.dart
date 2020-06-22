import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/cart.dart';
import 'package:shopapp/repository/product_provider.dart';
import 'package:shopapp/routes/cart_route.dart';
import 'package:shopapp/routes/product_detail_route.dart';
import 'package:shopapp/routes/product_overview_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (buildContext) => ProductProvider()),
        ChangeNotifierProvider(
          create: (buildContext) => CartProvider()),
      ],
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
              CartRoute.routeName: (ctx) => CartRoute(),
            },
          ),
    );
  }
}
