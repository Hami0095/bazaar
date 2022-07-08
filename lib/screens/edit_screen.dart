// ignore_for_file: prefer_const_constructors

import 'package:bazaar/Provider/productsProvider.dart';
import 'package:bazaar/Themes/mythemes.dart';
import 'package:bazaar/screens/splash_screen.dart';
import 'package:bazaar/screens/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../Provider/products.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit-screen';
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _priceFocus = FocusNode();
  final _imgController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    description: '',
    price: '',
    imageUrl: '',
    title: '',
  );
  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateImgUrl);
    super.initState();
  }

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'title': '',
    'id': DateTime.now().toString(),
    'price': '',
    'description': '',
    'imgUrl': '',
  };
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findByID(productId);
        _initValues = {
          'title': _editedProduct.title,
          'id': _editedProduct.id,
          'price': _editedProduct.price,
          'description': _editedProduct.description,
          'imgUrl': '',
        };
        _imgController.text = _editedProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descFocusNode.dispose();
    _imgController.dispose();
    _imageUrlFocusNode.removeListener(updateImgUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateImgUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imgController.text.isEmpty ||
          !_imgController.text.startsWith('http') &&
              !_imgController.text.startsWith('https')) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> saveForm() async {
    print('edited product id: ${_editedProduct.id}');
    final _isValid = _form.currentState?.validate();
    if (!_isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != '') {
      // print('Going to update the new product');
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isLoading = true;
      });
      // print('Going to add product');
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Bhai-Error',
            ),
            content: const Text('Something went Wrong bhai'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Okay',
                ),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Your Products',
        ),
        actions: [
          IconButton(
            onPressed: (() => saveForm()),
            icon: const Icon(
              Icons.save_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? SplashScreen(
              route: UserProductScreen(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: const InputDecoration(
                        label: Text(
                          'Title',
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          imageUrl: _editedProduct.imageUrl,
                          title: value!,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                        );
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter value';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: const InputDecoration(
                        label: Text('Price'),
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavourite: _editedProduct.isFavourite,
                          imageUrl: _editedProduct.imageUrl,
                          title: _editedProduct.title,
                          price: value!,
                          description: _editedProduct.description,
                        );
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter some value';
                        } else if (double.parse(v) <= 0) {
                          return 'Please Enter some value greater than 0';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          description: value!,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter some correct value.';
                        } else if (v.length < 10) {
                          return 'Please enter at least 10 characters.';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Container(
                            child: _imgController.text.isEmpty
                                ? const Text('Enter URL')
                                : FittedBox(
                                    child: Image.network(_imgController.text),
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imgController,
                            focusNode: _imageUrlFocusNode,
                            onSaved: (val) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                imageUrl: val!,
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                isFavourite: _editedProduct.isFavourite,
                              );
                            },
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              saveForm();
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Bhai koi kaam tw sahi kr lia kroo.';
                              } else {
                                return null;
                              }
                            },
                          ),
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
