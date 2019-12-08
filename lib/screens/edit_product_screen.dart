import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageurl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageurl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageurl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg') &&
              !_imageUrlController.text.contains('image'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isvalid = _form.currentState.validate();
    if (isvalid) {
      _form.currentState.save();
      Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.white,
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (v) {
                  _editedProduct = Product(
                    title: v,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                    id: null,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (v) {
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                    price: double.parse(v),
                  );
                },
                validator: (value){
                  if (value.isEmpty) {
                    return 'Please Enter Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a Valid Number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please Enter A Price Greater Than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 5,
                maxLength: 700,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (v) {
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: v,
                    imageUrl: _editedProduct.imageUrl,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter a Description';
                  }
                  if (value.length < 10) {
                    return 'Please Enter Description Greater than 10';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image Url'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageUrlController,
                focusNode: _imageUrlFocusNode,
                onSaved: (v) {
                  _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    imageUrl: v,
                    price: _editedProduct.price,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter A Url';
                  }
                  if (!value.startsWith('http') && !value.startsWith('https')) {
                    return 'Please Enter a Valid Url';
                  }
                  if (!value.endsWith('.jpg') &&
                      !value.endsWith('.png') &&
                      !value.endsWith('.jpeg') &&
                      !value.contains('image')) {
                    return 'Please Enter a Valid Image Url';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 350,
                    height: 300,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blueGrey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Container(
                            alignment: Alignment.center,
                            color: Colors.white54,
                            child: Text(
                              'Enter Url',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    elevation: 3,
                    onPressed: _saveForm,
                    color: Theme.of(context).accentColor,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
