import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget{


  @override
  Widget build(BuildContext buildContext) {
    final product = Provider.of<Product>(buildContext,listen: false);
    final cart = Provider.of<Cart>(buildContext,listen: false);
    final authData = Provider.of<Auth>(buildContext,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
    child:GridTile(
    child:GestureDetector(
    onTap: (){
    Navigator.of(buildContext).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
    },
    child: Image.network(product.imageUrl,fit: BoxFit.cover),
    ),
    footer:GridTileBar(
    backgroundColor:Colors.black87,
    leading: Consumer<Product>(
    builder:(ctx,product,child)=>IconButton(icon:Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
    onPressed: () {
    product.toggleFavorite(authData.token,authData.userId);
    },
    color: Theme.of(buildContext).accentColor),
    ),title: Text(product.title,textAlign:TextAlign.center),
    trailing:IconButton(icon: Icon(Icons.shopping_cart),
    onPressed: () {
      cart.addItem(product.id,product.price,product.title);
      ScaffoldMessenger.of(buildContext).hideCurrentSnackBar();
      ScaffoldMessenger.of(buildContext).showSnackBar(
          SnackBar(
              content:Text('Added item To Card',),
              duration:Duration(seconds:2),
              action:SnackBarAction(label:'UNDO', onPressed:(){
                cart.removeSingleItem(product.id);
              }),
          )
      );
    },
    color: Theme.of(buildContext).accentColor),
    ),
    )
    );
  }

}