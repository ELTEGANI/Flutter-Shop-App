import 'package:flutter/material.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });


}

class Orders extends ChangeNotifier {
   List<OrderItem> _orders = [];
   List<OrderItem> get orders {
     return [..._orders];
   }


   Future <void> fetchAndSetOrders() async {
     final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');
     final response  = await http.post(url);
     final List<OrderItem> loadOrders = [];
     final extractedData = json.decode(response.body) as Map<String,dynamic>;
     if(extractedData == null){
       return;
     }
     extractedData.forEach((orderId,orderData) {
         loadOrders.add(OrderItem(
             id:orderId,
             amount:orderData['amount'],
             dateTime:DateTime.parse(orderData['dateTime']),
             products:(orderData['products'] as List<dynamic>).map((item) =>
                 CartItem(
                     id:item['id'],
                     title:item['title'],
                     quantity:item['quantity'],
                     price:item['price'])
             ).toList()
            )
         );
     });
     _orders = loadOrders.reversed.toList();
     notifyListeners();
   }

   Future <void> addOrder(List<CartItem> cartProducts,double total) async{
     final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json');
     final timeStamp = DateTime.now();
     final response  = await http.post(
       url,body:json.encode({
            'amount':total,
            'dateTime':timeStamp.toIso8601String(),
            'products':cartProducts.map((cp)=>{
              'id':cp.id,
              'title':cp.title,
              'quantity':cp.quantity,
              'price':cp.price
            }).toList()
     }),);
     _orders.insert(
           0,
          OrderItem(
              id:json.decode(response.body)['name'],
              amount: total,
              dateTime:timeStamp,
              products: cartProducts
          ),
      );
      notifyListeners();
   }

}
