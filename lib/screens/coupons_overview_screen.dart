import 'package:flutter/material.dart';

import '../widgets/coupons_listview.dart';

enum FilterCoupons { Favourites, All }

class CouponsOverviewScreen extends StatefulWidget {
  @override
  _CouponsOverviewScreenState createState() => _CouponsOverviewScreenState();
}

class _CouponsOverviewScreenState extends State<CouponsOverviewScreen> {
  //manage filters
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          'Coupons',
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
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: CouponsListView(_showOnlyFavorites),
    );
  }
}
