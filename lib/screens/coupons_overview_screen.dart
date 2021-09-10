import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupons_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/coupons_listview.dart';
import '../widgets/banner_slider.widget.dart';

enum FilterCoupons { Favourites, All }

class CouponsOverviewScreen extends StatefulWidget {
  @override
  _CouponsOverviewScreenState createState() => _CouponsOverviewScreenState();
}

class _CouponsOverviewScreenState extends State<CouponsOverviewScreen> {
  static const routName = '/home';
  //manage filters
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<CouponsProvider>(context).fetchCoupons();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   Provider.of<CouponsProvider>(context, listen: false)
    //       .fetchCoupons()
    //       .then((_) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
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
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Top offers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BannerSlider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'New Coupons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CouponsListView(_showOnlyFavorites),
        ],
      ),
    );
  }
}
