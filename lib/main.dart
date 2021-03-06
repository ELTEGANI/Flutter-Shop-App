import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screens.dart';
import './screens/product_detail_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_product_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
      ChangeNotifierProvider(create:(ctx)=>Auth()),
      ChangeNotifierProxyProvider<Auth,Products>(
        update:(ctx,auth,previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items)
       ),
      ChangeNotifierProvider(
        create:(ctx) => Cart()
      ),
      ChangeNotifierProxyProvider<Auth,Orders>(
        update:(ctx,auth,previousOrder) => Orders(
            auth.token,
            auth.userId,
            previousOrder == null ? [] :
            previousOrder.orders)
      ),
    ],
      child: Consumer<Auth>(builder:(ctx,auth,child)=>
          MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'
            ),
            home:auth.isAuth ? ProductOverViewScreen() : FutureBuilder(
              future:auth.tryAutoLogin(),
              builder:
            (ctx,authResultSnapShot) => authResultSnapShot.connectionState == ConnectionState.waiting
               ? SplashScreen()
               : AuthScreen(),) ,
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName:(ctx) => CartScreen(),
              OrdersScreen.routeName:(ctx) => OrdersScreen(),
              UserProductsScreen.routeName:(ctx) => UserProductsScreen(),
              EditProductScreen.routeName:(ctx)=> EditProductScreen()
            },
          )
      )
    );
  }
}

