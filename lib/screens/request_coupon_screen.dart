import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/request.dart';
import '../providers/requests_provider.dart';
import '../widgets/app_drawer.dart';

class RequestCouponScreen extends StatefulWidget {
  static const routeName = '/request-coupon';

  @override
  _RequestCouponState createState() => _RequestCouponState();
}

class _RequestCouponState extends State<RequestCouponScreen> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _storeFocusNode = FocusNode();
  final _storeLinkFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedRequest = Request(
    id: null,
    userName: '',
    email: '',
    store: '',
    link: '',
  );
  var _initValues = {
    'userName': '',
    'email': '',
    'store': '',
    'link': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final requestId = ModalRoute.of(context).settings.arguments as String;
      if (requestId != null) {
        _editedRequest = Provider.of<RequestsProvider>(context, listen: false)
            .findById(requestId);
        _initValues = {
          'userName': _editedRequest.userName,
          'email': _editedRequest.email,
          'store': _editedRequest.store,
          'link': _editedRequest.link,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _storeFocusNode.dispose();
    _storeLinkFocusNode.dispose();
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
      // if (_editedRequest.id != null) {
      //   try {
      //     //update provider
      //     await Provider.of<RequestsProvider>(context, listen: false)
      //         .updateRequest(_editedRequest.id, _editedRequest);
      //   } catch (error) {
      //     await showDialog(
      //         context: context,
      //         builder: (ctx) => AlertDialog(
      //               title: Text('Error'),
      //               content: Text('Please check your internet connection.'),
      //               actions: [
      //                 MaterialButton(
      //                     child: Text('Okay'),
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     })
      //               ],
      //             ));
      //   }
      // } else {
      //   try {
      //     //update provider
      //     await Provider.of<RequestsProvider>(context, listen: false)
      //         .addRequest(_editedRequest);
      //   } catch (error) {
      //     await showDialog(
      //         context: context,
      //         builder: (ctx) => AlertDialog(
      //               title: Text('Error'),
      //               content: Text('Please check your internet connection.'),
      //               actions: [
      //                 MaterialButton(
      //                     child: Text('Okay'),
      //                     onPressed: () {
      //                       Navigator.of(context).pop();
      //                     })
      //               ],
      //             ));
      //   }
      // }

      print(_editedRequest.toString());

      try {
        //update provider
        await Provider.of<RequestsProvider>(context, listen: false)
            .addRequest(_editedRequest);
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

      setState(() {
        _isLoading = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Your request has been submitted. Thank you!',
          textAlign: TextAlign.center,
        ),
        action: SnackBarAction(
          label: 'Done',
          onPressed: () {},
        ),
      ));

      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a coupon'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      drawer: AppDrawer(),
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
                        initialValue: _initValues['userName'],
                        decoration: InputDecoration(labelText: 'User name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is mandatory';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editedRequest = Request(
                              id: _editedRequest.id,
                              userName: value,
                              email: _editedRequest.email,
                              store: _editedRequest.store,
                              link: _editedRequest.link);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['email'],
                        decoration: InputDecoration(labelText: 'Email address'),
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_storeFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is mandatory';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _editedRequest = Request(
                              id: _editedRequest.id,
                              userName: _editedRequest.userName,
                              email: value,
                              store: _editedRequest.store,
                              link: _editedRequest.link);
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['store'],
                        decoration: InputDecoration(labelText: 'Store name'),
                        textInputAction: TextInputAction.next,
                        focusNode: _storeFocusNode,
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
                          _editedRequest = Request(
                              id: _editedRequest.id,
                              userName: _editedRequest.userName,
                              email: _editedRequest.email,
                              store: value,
                              link: _editedRequest.link);
                        },
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
                          _editedRequest = Request(
                              id: _editedRequest.id,
                              userName: _editedRequest.userName,
                              email: _editedRequest.email,
                              store: _editedRequest.store,
                              link: value);
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
                            child: Text('REQUEST COUPON',
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
