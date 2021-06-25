import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import '../screens/orders_screens.dart';
import '../screens/user_product_screen.dart';



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
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title:Text('Mange Products'),
          onTap: (){
            Navigator.of(buildContext).pushReplacementNamed(UserProductsScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title:Text('Logout'),
          onTap: (){
            Navigator.of(buildContext).pushReplacementNamed('/');
            Provider.of<Auth>(buildContext,listen: false).logout();
          },
        )
      ],
    ),
    );
  }

}