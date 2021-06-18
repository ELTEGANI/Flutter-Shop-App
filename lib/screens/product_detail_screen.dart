import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget{
   static const routeName = 'product-detail';
  @override
  Widget build(BuildContext buildContext) {
    final productId = ModalRoute.of(buildContext).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(buildContext).findById(productId);
    return Scaffold(
       appBar: AppBar(
         title: Text(loadedProduct.title),
       ),
    );
  }

}