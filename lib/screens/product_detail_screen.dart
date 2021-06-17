import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget{
   static const routeName = 'product-detail';
  @override
  Widget build(BuildContext buildContext) {
    final productId = ModalRoute.of(buildContext).settings.arguments as String;
    return Scaffold(
       appBar: AppBar(
         title: Text('title'),
       ),
    );
  }

}