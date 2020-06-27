import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/repository/product.dart';
import 'package:shopapp/repository/product_provider.dart';

class EditProductRoute extends StatefulWidget {
  static const String routeName = "/edit-product-route";

  @override
  _EditProductRouteState createState() => _EditProductRouteState();
}

class _EditProductRouteState extends State<EditProductRoute> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var initialized = false;
  var _editedProduct =
      Product(id: null, title: "", price: 0, imageUrl: "", description: "");

  @override
  void didChangeDependencies() {
    if (!initialized) {
      final _productId = ModalRoute.of(context).settings.arguments as String;
      final _productProvider =
          Provider.of<ProductProvider>(context, listen: false);

      if (_productId != null && _productId.trim().isNotEmpty) {
        _editedProduct = _productProvider.getProduct(_productId);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    initialized = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  void _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      final _productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      if (_editedProduct.id == null)
        _productProvider.addProduct(_editedProduct);
      else
        _productProvider.updateProduct(_editedProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _editedProduct.title,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: (value) => _editedProduct =
                      Product.cloneProductWithTitle(value, _editedProduct),
                  validator: (value) {
                    if (value.isEmpty || value.trim().isEmpty)
                      return "Please Enter valid Title";
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _editedProduct.price == 0
                      ? ""
                      : _editedProduct.price.toString(),
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (value) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                  onSaved: (value) => _editedProduct =
                      Product.cloneProductWithPrice(
                          double.tryParse(value), _editedProduct),
                  validator: (value) {
                    if (value.isEmpty) return "Please Enter a price";
                    if (double.tryParse(value) == null ||
                        double.tryParse(value) < 0)
                      return "Please enter Valid Price";
                    if (double.tryParse(value) == 0)
                      return "Price cannot be zero";
                    return null;
                  },
                ),
                TextFormField(
                    initialValue: _editedProduct.description,
                    decoration: InputDecoration(labelText: "Description"),
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) => _editedProduct =
                        Product.cloneProductWithDescription(
                            value, _editedProduct),
                    validator: (value) {
                      if (value.isEmpty || value.trim().isEmpty)
                        return "Please Enter a Description";
                      return null;
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text("Enter URL")
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Image URL"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm,
                        onSaved: (value) => _editedProduct =
                            Product.cloneProductWithImage(
                                value, _editedProduct),
                        validator: (value) {
                          if (value.isEmpty || value.trim().isEmpty)
                            return "Please enter a URL";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
