import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier{
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Swarovski',
      description: 'My heart is a world and you always live in the center of it. You are the one and only, and my world moves around you.',
      price: 57.18,
      imageUrl:
      'https://m.media-amazon.com/images/I/31sshePpktS._AC_SR160,160_.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Adidas Mens Run It',
      description: 'adidas Mens Design 2 Move Solid T-Shirt',
      price: 101.99,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/31HXc7t4isL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p3',
      title: 'adidas Unisex',
      description: 'adidas Unisex Legend Ink Dad Cap (One Size For Men)',
      price: 75.99,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/41P-wRi+ZDL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'adidas Unisex',
      description: 'adidas Unisex Pink Graphic Cap (One Size For Men)',
      price: 64.99,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/41VQeoNJQEL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Michael Kors',
      description: 'Michael Kors Womens Stainless Steel Band',
      price: 696.00,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/41LFHX3xbGL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p7',
      title: 'DKNY Bryant Coated Logo Dome Crossbody- Mocha',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 352.00,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/51sOs79nPEL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Swarovski',
      description: 'Swarovski Elements 925 Sterling Silver Crystal Studs Earrings for Females Women Ladies Girl friend Gift J.Rosée Jewelry JR905',
      price: 56.99,
      imageUrl:
      'https://images-eu.ssl-images-amazon.com/images/I/41ji-amBdrL._AC_SX184_.jpg',
    ),
    Product(
      id: 'p9',
      title: 'Warm and cozy',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p10',
      title: 'adidas Unisexs',
      description: 'adidas Unisexs 3S ORGANIZER, black-Black-White, NS',
      price: 49.00,
      imageUrl:
      'https://m.media-amazon.com/images/I/41NUB024pnL._AC_SR160,200_.jpg',
    ),
    Product(
      id: 'p11',
      title: 'Warm and cozy',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://m.media-amazon.com/images/I/41js4jVJeXL.jpg',
    ),
    Product(
      id: 'p12',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p13',
      title: 'Summer thin',
      description: 'Summer thin three-quarter sleeve nightdress female modal sexy pajamas simple cardigan home clothing',
      price: 19.99,
      imageUrl:
      'https://m.media-amazon.com/images/I/31hcWIl7DsL._AC_UL320_.jpg',
    ),
    Product(
      id: 'p14',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p15',
      title: 'Girls Puma',
      description: 'Girls Puma Phase Small Phase Small Backpack',
      price: 19.99,
      imageUrl:
      'https://m.media-amazon.com/images/I/91pUl1usmcL._AC_UL320_.jpg',
    ),
    Product(
      id: 'p16',
      title: 'A Pan',
      description: 'PUMA Mens Puma Phase Ii Phase Ii Backpack',
      price: 49.99,
      imageUrl:
      'https://m.media-amazon.com/images/I/91GbAeJd3tL._AC_UL320_.jpg',
    ),
  ];

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
      print(json.decode(response.body));
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

  void updateProduct(String id,Product newProduct){
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0){
      _items[prodIndex] = newProduct;
      notifyListeners();
    }else{
      print('.....');
    }
  }

  void deleteProduct(String id){
     _items.removeWhere((element) => element.id == id);
     notifyListeners();
  }

}