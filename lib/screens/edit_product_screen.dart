import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/my_appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editProducts';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _productFocusNode = FocusNode();
  final _detailsFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  var _isInit = true;
  var _initValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final editProductId = ModalRoute.of(context).settings.arguments as String;

      if (editProductId != null) {
        _editedProduct = Provider.of<Products>(context).findById(editProductId);

        _initValue = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _productFocusNode.dispose();
    _detailsFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          !_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      if (_editedProduct.id != null) {
        Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Edit Product',
            leading: Icons.arrow_back,
            leadingOnTap: () {
              Navigator.of(context).pop();
            },
            isCart: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initValue['title'],
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_productFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Provide Title';
                          } else if (value.length > 40) {
                            return 'Please Provide short title';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: value,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        initialValue: _initValue['price'],
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_detailsFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _productFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter price.';
                          } else if (double.tryParse(value) == null) {
                            return 'Please enter valid price.';
                          } else if (double.parse(value) <= 0) {
                            return 'Please enter number greater than zero.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: int.parse(value),
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        initialValue: _initValue['description'],
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        focusNode: _detailsFocusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter description.';
                          } else if (value.length < 15) {
                            return 'Please enter more than 15 letters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              description: value,
                              price: _editedProduct.price,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                              imageUrl: _editedProduct.imageUrl);
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 100,
                            margin: EdgeInsets.only(top: 5, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? Center(child: Text('Enter Image Url'))
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Image Url',
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter image url.';
                                } else if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter Valid Url.';
                                } else if (!value.endsWith('png') &&
                                    !value.endsWith('jpg') &&
                                    !value.endsWith('jpeg')) {
                                  return 'Please enter valid Url.';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedProduct = Product(
                                    title: _editedProduct.title,
                                    description: _editedProduct.description,
                                    price: _editedProduct.price,
                                    id: _editedProduct.id,
                                    isFavorite: _editedProduct.isFavorite,
                                    imageUrl: value);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
