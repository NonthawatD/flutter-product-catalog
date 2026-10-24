import 'package:flutter/material.dart';
import 'package:product_catalog_application/configs/app_theme.dart';
import 'package:product_catalog_application/features/product/screen/product_list_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatalogX',
      theme: buildAppTheme(),
      home: const ProductListScreen(),
    );
  }
}
