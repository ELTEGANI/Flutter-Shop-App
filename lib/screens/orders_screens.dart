import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget{
  static const routeName = '/orders';
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
      drawer: AppDrawer(),
      body:FutureBuilder(future:Provider.of<Orders>(buildContext,listen:false).fetchAndSetOrders(),
      builder:(ctx,dataSnapShot){
        if(dataSnapShot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
          if(dataSnapShot.error != null){
            return Center(child: Text('An Error Occurred'),);
          }else{
             return Consumer<Orders>(builder:(ctx,orderData,ch)=>ListView.builder(
               itemCount:orderData.orders.length,
               itemBuilder:(ctx,i) => OrderItem(orderData.orders[i]),
             ),
             );
          }
        }
      },
      )
    );
  }
}