import 'package:cashier_app_ui/model/cart.dart';
import 'package:cashier_app_ui/model/category.dart';
import 'package:cashier_app_ui/model/menu.dart';
import 'package:cashier_app_ui/model/product.dart';
import 'package:cashier_app_ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cashierApp');
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(CartAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainPage(),
    );
  }
}
