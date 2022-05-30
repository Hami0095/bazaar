import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _editedProduct = Product(
    id: DateTime.now().toString(),
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
      setState(() {});
    }
  }

  void saveForm() {
    final _isValid = _form.currentState?.validate();
    if (!_isValid!) {
      return;
    }
    _form.currentState?.save();
    print(_editedProduct.id);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
    print(_editedProduct.price);
    print(_editedProduct.title);
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
              onPressed: (() => saveForm()), icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (value) {
                  _editedProduct.title = value!;
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
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _editedProduct.price = value!;
                  }),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                onSaved: (value) {
                  _editedProduct.description = value!;
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
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (val) {
                        _editedProduct.imageUrl = val!;
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        saveForm();
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
