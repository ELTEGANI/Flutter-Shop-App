import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/products_grid.dart';

class ProductOverViewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(title: Text('Shop')
      ),
      body: ProductsGrid(),
    );
  }

}

