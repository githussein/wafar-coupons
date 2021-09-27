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
    store: '',
    title: '',
    code: '',
    description: '',
    imageUrl: '',
    link: '',
    category: 'all',
  );
  var _initValues = {
    'title': '',
    'store': '',
    'code': '',
    'description': '',
    'imageUrl': '',
    'link': '',
    'category': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final couponId = ModalRoute.of(context).settings.arguments as String;
      if (couponId != null) {
        _editedCoupon = Provider.of<CouponsProvider>(context, listen: false)
            .findById(couponId);
        _initValues = {
          'title': _editedCoupon.title,
          'store': _editedCoupon.store,
          'code': _editedCoupon.code,
          'description': _editedCoupon.description,
          // 'imageUrl': '_editedCoupon.imageUrl',
          'imageUrl': '',
          'link': _editedCoupon.link,
        };
        _imageLinkController.text = _editedCoupon.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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

  Future<void> _saveForm() async {
    if (_formKey.currentState.validate()) {
      //all fields are filled
      _formKey.currentState.save(); //execute every onSaved function

      //to show loading indicator
      setState(() {
        _isLoading = true;
      });

      //check weather to edit or add a new coupon
      if (_editedCoupon.id != null) {
        try {
          //update provider
          await Provider.of<CouponsProvider>(context, listen: false)
              .updateCoupon(_editedCoupon.id, _editedCoupon);
        } catch (error) {
          await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Please check your internet connection.'),
                    actions: [
                      MaterialButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  ));
        }
      } else {
        try {
          //update provider
          await Provider.of<CouponsProvider>(context, listen: false)
              .addCoupon(_editedCoupon);
        } catch (error) {
          await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Please check your internet connection.'),
                    actions: [
                      MaterialButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  ));
        }
      }

      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Coupon'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
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
                              store: _editedCoupon.store,
                              title: value,
                              code: _editedCoupon.code,
                              description: _editedCoupon.description,
                              imageUrl: _editedCoupon.imageUrl,
                              link: _editedCoupon.link,
                              category: _editedCoupon.category,
                              isFavorite: _editedCoupon.isFavorite);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['code'],
                        decoration: InputDecoration(labelText: 'code'),
                        textInputAction: TextInputAction.next,
                        focusNode: _codeFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
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
                              store: _editedCoupon.store,
                              title: _editedCoupon.title,
                              code: value,
                              description: _editedCoupon.description,
                              imageUrl: _editedCoupon.imageUrl,
                              link: _editedCoupon.link,
                              category: _editedCoupon.category,
                              isFavorite: _editedCoupon.isFavorite);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
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
                              store: _editedCoupon.store,
                              title: _editedCoupon.title,
                              code: _editedCoupon.code,
                              description: value,
                              imageUrl: _editedCoupon.imageUrl,
                              link: _editedCoupon.link,
                              category: _editedCoupon.category,
                              isFavorite: _editedCoupon.isFavorite);
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
                                    child: Image.network(
                                        _imageLinkController.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // initialValue: _initValues['imageUrl'],
                              decoration:
                                  InputDecoration(labelText: 'Image link'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                              controller: _imageLinkController,
                              focusNode: _imageLinkFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_storeLinkFocusNode);
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
                                    store: _editedCoupon.store,
                                    title: _editedCoupon.title,
                                    code: _editedCoupon.code,
                                    description: _editedCoupon.description,
                                    imageUrl: value,
                                    link: _editedCoupon.link,
                                    category: _editedCoupon.category,
                                    isFavorite: _editedCoupon.isFavorite);
                              },
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: _initValues['link'],
                        decoration: InputDecoration(labelText: 'Store link'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        focusNode: _storeLinkFocusNode,
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
                              store: _editedCoupon.store,
                              title: _editedCoupon.title,
                              code: _editedCoupon.code,
                              description: _editedCoupon.description,
                              imageUrl: _editedCoupon.imageUrl,
                              link: value,
                              category: _editedCoupon.category,
                              isFavorite: _editedCoupon.isFavorite);
                        },
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
                            child: Text("Save changes",
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
