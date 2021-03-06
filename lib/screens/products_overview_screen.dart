import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState(){
    // Provider.of<Products>(context).fetchAndSetProducts() // not working
    // Future.delayed(Duration.zero).then((value) => { //Working :)
    // Provider.of<Products>(context).fetchAndSetProducts()
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) => {
      setState(() {
        _isLoading = false;
      })
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
        ),
       Consumer<Cart>(builder:(_,cart,ch)=>Badge(
         child:ch,
         value:cart.itemCount.toString(),
        ),
         child: IconButton(
           icon: Icon(Icons.shopping_cart),
           onPressed: (){
             Navigator.of(buildContext).pushNamed(CartScreen.routeName);
           },
         ),
       )
      ],
      ),
      drawer: AppDrawer(),
      body:_isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavorite),
    );
  }
}

