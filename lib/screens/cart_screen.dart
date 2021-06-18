import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget{
  static const routeName = '/cart';
  @override
  Widget build(BuildContext buildContext) {
    final cart = Provider.of<Cart>(buildContext);
    return Scaffold(
         appBar: AppBar(title: Text('Your Cart')),
      body:Column(children: <Widget>[
         Card(margin: EdgeInsets.all(15),child:Padding(
           padding: EdgeInsets.all(8),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text('Total',style:TextStyle(fontSize:20),),
               Spacer(),
               Chip(label:
                   Text('${cart.totalAmount}',
                   style: TextStyle(color:Theme.of(buildContext).primaryTextTheme.headline6.color),),
                   backgroundColor:Theme.of(buildContext).primaryColor
               ),
               // ignore: deprecated_member_use
               FlatButton(
                   onPressed:(){},
                   child: Text('ORDER NOW'),
                   textColor: Theme.of(buildContext).primaryColor,)
             ],
           ),
         ),
         ),
        SizedBox(height: 10),
        Expanded(child: ListView.builder(itemCount:cart.items.length,
        itemBuilder:(ctx,i)=> CartItem(
            cart.items.values.toList()[i].id,
            cart.items.values.toList()[i].price,
            cart.items.values.toList()[i].quantity,
            cart.items.values.toList()[i].title)
        )
        )
       ],
      ),
    );
  }

}