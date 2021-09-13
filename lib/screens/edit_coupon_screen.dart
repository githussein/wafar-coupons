import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupon.dart';
import '../providers/coupons_provider.dart';

class EditCouponScreen extends StatefulWidget {
  static const routeName = '/edit-coupon';

  @override
  _EditCouponScreenState createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  final _codeFocusNode = FocusNode();
  final _storeLinkFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageLinkController = TextEditingController();
  final _imageLinkFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedCoupon = Coupon(
    id: null,
    title: '',
    code: '',
    description: '',
    imageUrl: '',
    link: '',
  );

  @override
  void initState() {
    _imageLinkFocusNode.addListener(_updateImageLink);
    super.initState();
  }

  void _updateImageLink() {
    if (!_imageLinkFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageLinkFocusNode.removeListener(_updateImageLink);
    _codeFocusNode.dispose();
    _storeLinkFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageLinkController.dispose();
    _imageLinkFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      //all fields are filled
      _formKey.currentState.save(); //execute every onSaved function
      //update provider
      Provider.of<CouponsProvider>(context, listen: false)
          .addCoupon(_editedCoupon);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Coupon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_codeFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is mandatory';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedCoupon = Coupon(
                        id: _editedCoupon.id,
                        title: value,
                        code: _editedCoupon.code,
                        description: _editedCoupon.description,
                        imageUrl: _editedCoupon.imageUrl,
                        link: _editedCoupon.link);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'code'),
                  textInputAction: TextInputAction.next,
                  focusNode: _codeFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is mandatory';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedCoupon = Coupon(
                        id: _editedCoupon.id,
                        title: _editedCoupon.title,
                        code: value,
                        description: _editedCoupon.description,
                        imageUrl: _editedCoupon.imageUrl,
                        link: _editedCoupon.link);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value.length < 5) {
                      return 'At least 5 characters long.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedCoupon = Coupon(
                        id: _editedCoupon.id,
                        title: _editedCoupon.title,
                        code: _editedCoupon.code,
                        description: value,
                        imageUrl: _editedCoupon.imageUrl,
                        link: _editedCoupon.link);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Store link'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.url,
                  focusNode: _storeLinkFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_imageLinkFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field is mandatory';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _editedCoupon = Coupon(
                        id: _editedCoupon.id,
                        title: _editedCoupon.title,
                        code: _editedCoupon.code,
                        description: _editedCoupon.description,
                        imageUrl: _editedCoupon.imageUrl,
                        link: value);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageLinkController.text.isEmpty
                          ? Text('Image preview')
                          : FittedBox(
                              child: Image.network(_imageLinkController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image link'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageLinkController,
                        focusNode: _imageLinkFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is mandatory';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editedCoupon = Coupon(
                              id: _editedCoupon.id,
                              title: _editedCoupon.title,
                              code: _editedCoupon.code,
                              description: _editedCoupon.description,
                              imageUrl: value,
                              link: _editedCoupon.link);
                        },
                      ),
                    ),
                  ],
                ),
                Divider(height: 20),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      onPressed: () {
                        _saveForm();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text("Add Coupon",
                          style: TextStyle(color: Colors.white)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
