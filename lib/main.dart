import 'package:flutter/material.dart';
import 'package:shopapp/routes/product_overview_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Lato",
      ),
      home: ProductOverviewRoute(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyShop')),
      body: Center(child: Text('Let\'s build a shop!')),
    );
  }
}
