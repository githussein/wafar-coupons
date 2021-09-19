import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/stores_listview.dart';
import '../providers/coupons_provider.dart';
import '../widgets/app_drawer.dart';

enum FilterCoupons { Favourites, All }

class StoresScreen extends StatefulWidget {
  static const routeName = '/stores';
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  //manage filters
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CouponsProvider>(context, listen: false)
          .fetchCoupons()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          'Stores',
        ),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterCoupons selectedValue) {
                setState(() {
                  if (selectedValue == FilterCoupons.Favourites) {
                    _showOnlyFavorites = true;
                  } else if (selectedValue == FilterCoupons.All) {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text('Favorites only'),
                        value: FilterCoupons.Favourites),
                    PopupMenuItem(
                        child: Text('Show all'), value: FilterCoupons.All),
                  ])
        ],
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : StoresListView(_showOnlyFavorites),
    );
  }
}