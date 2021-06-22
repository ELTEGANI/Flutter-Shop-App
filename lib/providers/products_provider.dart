import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier{
  List<Product> _items = [];

  Product findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get favoriteItems{
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Future <void> fetchAndSetProducts() async {
    final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      final List<Product>loadedProducts = [];
      extractedData.forEach((productId,productData) {
          loadedProducts.insert(0,Product(
             id:productId,
             title:productData['title'],
             description:productData['description'],
             price:productData['price'],
             isFavorite:productData['isFavorite'],
             imageUrl:productData['imageUrl']
          ));
      });
      _items = loadedProducts;
      notifyListeners();
    }catch(error){
      throw(error);
    }
  }

  Future<void> addProduct(Product product) async{
    final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/products.json');
    try {
      final response = await http.post(url, body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
      }),
      );
      final newProduct = Product(
        id:json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> updateProduct(String id,Product newProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0){
      final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
      await http.patch(url,body:json.encode({
        'title':newProduct.title,
        'description': newProduct.description,
        'imageUrl':newProduct.imageUrl,
        'price':newProduct.price,
      }));

      _items[prodIndex] = newProduct;
      notifyListeners();
    }else{
      print('.....');
    }
  }

  Future <void> deleteProduct(String id) async{
    final url = Uri.parse('https://test-dawana-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json');
    final existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
      if(response.statusCode >= 400){
        _items.insert(existingProductIndex,existingProduct);
        notifyListeners();
        throw HttpException("Couldn't Delete Product");
      }
        existingProduct = null;
  }

}