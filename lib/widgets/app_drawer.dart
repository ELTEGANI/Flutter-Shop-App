import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screens.dart';



class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext buildContext) {
    return Drawer(child: Column(
      children: <Widget>[
        AppBar(title:Text('Hi World'),automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title:Text('Shop'),
          onTap: (){
            Navigator.of(buildContext).pushReplacementNamed('/');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title:Text('Orders'),
          onTap: (){
            Navigator.of(buildContext).pushReplacementNamed(OrdersScreen.routeName);
          },
        )
      ],
    ),
    );
  }

}