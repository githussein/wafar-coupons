import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Offer.dart';
import '../providers/OffersProvider.dart';

class EditOfferScreen extends StatefulWidget {
  static const routeName = '/edit-offer';

  @override
  _EditOfferScreenState createState() => _EditOfferScreenState();
}

class _EditOfferScreenState extends State<EditOfferScreen> {
  final _codeFocusNode = FocusNode();
  final _storeLinkFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageLinkController = TextEditingController();
  final _imageLinkFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editedOffer = Offer(
    id: null,
    title: '',
    imageUrl: '',
    link: '',
  );
  var _initValues = {
    'title': '',
    'imageUrl': '',
    'link': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final offerId = ModalRoute.of(context).settings.arguments as String;
      if (offerId != null) {
        _editedOffer = Provider.of<OffersProvider>(context, listen: false)
            .findById(offerId);
        _initValues = {
          'title': _editedOffer.title,
          'imageUrl': '',
          'link': _editedOffer.link,
        };
        _imageLinkController.text = _editedOffer.imageUrl;
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
      if (_editedOffer.id != null) {
        try {
          //update provider
          await Provider.of<OffersProvider>(context, listen: false)
              .updateOffer(_editedOffer.id, _editedOffer);
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
          await Provider.of<OffersProvider>(context, listen: false)
              .addOffer(_editedOffer);
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
        title: Text('Edit Offer'),
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
                          _editedOffer = Offer(
                              id: _editedOffer.id,
                              title: value,
                              imageUrl: _editedOffer.imageUrl,
                              link: _editedOffer.link);
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
                                _editedOffer = Offer(
                                    id: _editedOffer.id,
                                    title: _editedOffer.title,
                                    imageUrl: value,
                                    link: _editedOffer.link);
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
                          _editedOffer = Offer(
                              id: _editedOffer.id,
                              title: _editedOffer.title,
                              imageUrl: _editedOffer.imageUrl,
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
