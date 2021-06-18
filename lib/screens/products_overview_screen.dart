import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/products_grid.dart';


enum FilterOptions {
  Favorite,
  All,
}

class ProductOverViewScreen extends StatefulWidget{
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext buildContext) {
    final productContainer = Provider.of<Products>(buildContext,listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Shop'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected:(FilterOptions selected){
            setState(() {
              if(selected == FilterOptions.Favorite){
                _showOnlyFavorite = true;
              }else{
                _showOnlyFavorite = false;
              }
            });
          },
          icon: Icon(Icons.more_vert,),
          itemBuilder:(_) =>[
            PopupMenuItem(child: Text('Only Favorites'),
                value:FilterOptions.Favorite),
            PopupMenuItem(child: Text('Show All'),
                value:FilterOptions.All)
          ],
        )
      ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}

