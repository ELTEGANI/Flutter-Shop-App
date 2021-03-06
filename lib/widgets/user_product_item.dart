import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';



class UserProductItem extends StatelessWidget{
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext buildContext) {
    final scaffold = Scaffold.of(buildContext);
    return ListTile(
      title:Text(title),
      leading:CircleAvatar(backgroundImage:NetworkImage(imageUrl)),
      trailing:Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(icon:Icon(Icons.edit),onPressed:(){
           Navigator.of(buildContext).pushNamed(EditProductScreen.routeName
           ,arguments:id);
          },color:Theme.of(buildContext).primaryColor),

          IconButton(icon:Icon(Icons.delete),onPressed:() async{
            try{
             await Provider.of<Products>(buildContext,listen: false).deleteProduct(id);
            }catch(error){
              scaffold.showSnackBar(SnackBar(content:Text('Deleting Failed',textAlign:TextAlign.center,)));
            }
          },color:Theme.of(buildContext).errorColor,)
        ],),
      ),
    );
  }

}