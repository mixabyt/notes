import 'package:flutter/material.dart';
import '../screen/homepage/homepage.dart';






class AppRoutes {
  static const home = '/';
  static const product = '/product';
  static const cart = '/cart';

  static final routes = <String, WidgetBuilder>{
    home: (context) => const HomePage(),
    // product: (context) => const ProductPage(),
    // cart: (context) => const CartPage(),
  };
}

