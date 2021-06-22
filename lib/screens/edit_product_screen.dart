import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';


class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState()=> _EditProductScreenState();
}


 class _EditProductScreenState extends State<EditProductScreen> {
   final _priceFocusNode = FocusNode();
   final _descriptionFocusNode = FocusNode();
   final _imageUrlController = TextEditingController();
   final _imageFocusNode = FocusNode();
   final _form = GlobalKey<FormState>();
   var _editProduct = Product(
       id: null,
       title: '',
       description: '',
       price:0,
       imageUrl: ''
   );

   var _initValues = {
     'title':'',
     'description':'',
     'price':'',
     'imageUrl':'',
   };
   var _isInit = true;
   var _isLoading = false;
   @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title':_editProduct.title,
          'description':_editProduct.description,
          'price':_editProduct.price.toString(),
          'imageUrl':'',
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
   @override
  void dispose() {
     _imageFocusNode.removeListener(_updateImageUrl);
     _priceFocusNode.dispose();
     _descriptionFocusNode.dispose();
     _imageUrlController.dispose();
     _imageFocusNode.dispose();
      super.dispose();
  }

  void _updateImageUrl(){
    if(!_imageFocusNode.hasFocus){
      if((_imageUrlController.text.startsWith('http') &&
          !_imageUrlController.text.startsWith('https')) ||
          !_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg')
          && !_imageUrlController.text.endsWith('jpeg')){
        return ;
      }
       setState(() {});
    }
  }


  Future <void> _saveForm() async{
    final _isValid = _form.currentState.validate();
    if(!_isValid){
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if(_editProduct.id != null){
      await Provider.of<Products>(context,listen: false).updateProduct(_editProduct.id,_editProduct);
    }else{
      try{
        await Provider.of<Products>(context,listen: false)
            .addProduct(_editProduct);
      }catch(error){
        await showDialog(context: context, builder:(ctx) => AlertDialog(title:Text('An error Occurred'),
          content: Text('Something went wrong'),
          actions: <Widget>[
            FlatButton(onPressed:(){
              Navigator.of(context).pop();
            }, child: Text('Okay'))
          ],
          )
        );
      }
      // finally{
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext buildContext) {
     return Scaffold(
         appBar:AppBar(
           title: Text('Edit Product'),
           actions: <Widget>[
             IconButton(
                 onPressed:(){
                   _saveForm();
                 },
                 icon:Icon(Icons.save))
           ],
         ),
       body:_isLoading ? Center(child:CircularProgressIndicator(),) : Padding(
         padding: const EdgeInsets.all(8.0),
         child: Form(
           key: _form,
           child:ListView(children: <Widget>[
            TextFormField(
              initialValue: _initValues['title'],
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted:(_){
                 FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator:(value){
                if(value.isEmpty){
                  return 'Please Provide a value';
                }
                return null;
              },
              onSaved:(value){
                _editProduct = Product(
                    id:_editProduct.id,
                    isFavorite:_editProduct.isFavorite,
                    title: value,
                    description: _editProduct.description,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl
                );
              },
            ),
            TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
               textInputAction: TextInputAction.next,
               keyboardType: TextInputType.number,
               focusNode: _priceFocusNode,
              onFieldSubmitted:(_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator:(value){
                 if(value.isEmpty){
                   return 'Please Enter a price';
                 }
                 if(double.tryParse(value) == null){
                   return 'Please enter a valid Number';
                 }
                 if(double.parse(value) <= 0){
                   return 'Please enter a number greater than zero';
                 }
                 return null;
              },
              onSaved:(value){
                _editProduct = Product(
                    id:_editProduct.id,
                    isFavorite:_editProduct.isFavorite,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    price:double.parse(value),
                    imageUrl: _editProduct.imageUrl
                );
              }
           ),
            TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
               maxLines: 3,
               textInputAction: TextInputAction.next,
               keyboardType: TextInputType.multiline,
               focusNode: _descriptionFocusNode,
               validator:(value){
                 if(value.isEmpty){
                    return 'Please Enter a description';
                 }
                 if(value.length <= 10){
                   return 'Should be at least 10 characters';
                 }
                 return null;
               },
                onSaved:(value){
                  _editProduct = Product(
                      id:_editProduct.id,
                      isFavorite:_editProduct.isFavorite,
                      title: _editProduct.title,
                      description:value,
                      price:_editProduct.price,
                      imageUrl: _editProduct.imageUrl
                  );
                }
             ),
             Row(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: <Widget>[
               Container(
                 width: 100,
                 height: 100,
                 margin: EdgeInsets.only(top: 8,right: 10),
                 decoration: BoxDecoration(
                   border: Border.all(
                     width: 1,
                     color: Colors.grey
                   )
                 ),
                 child: _imageUrlController.text.isEmpty?Text('Enter a Url'):
                 FittedBox(child: Image.network(_imageUrlController.text),fit:BoxFit.cover,),
               ),
               Expanded(
                   child: TextFormField(
                     decoration: InputDecoration(labelText: 'Image URL'),
                     keyboardType: TextInputType.url,
                     textInputAction: TextInputAction.done,
                     controller: _imageUrlController,
                     focusNode: _imageFocusNode,
                     onEditingComplete: () {
                       _saveForm();
                     },
                     validator:(value){
                       if(value.isEmpty){
                         return 'Please Enter an Image Url';
                       }
                       if(!value.startsWith('http') && !value.startsWith('https')){
                         return 'Please Enter a valid URL';
                       }
                       if(!value.endsWith('png') && !value.endsWith('jpg') && !value.endsWith('jpeg')){
                         return 'Please Enter a valid Image URL';
                       }
                       return null;
                     },
                     onSaved:(value){
                         _editProduct = Product(
                             id:_editProduct.id,
                             isFavorite:_editProduct.isFavorite,
                             title: _editProduct.title,
                             description: _editProduct.description,
                             price:_editProduct.price,
                             imageUrl: value
                         );
                       }
                   )
               ),
             ],)
         ],),),
       ),
     );
  }

}