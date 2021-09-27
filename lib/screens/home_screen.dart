import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupons_provider.dart';
import '../providers/OffersProvider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/coupons_listview.dart';
import '../widgets/banner_slider.widget.dart';
import 'categorized_stores_screen.dart';

enum FilterCoupons { Favourites, All }
String categoryFilter = "all";

class HomeScreen extends StatefulWidget {
  // static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      //fetch offers and coupons
      Provider.of<CouponsProvider>(context, listen: false)
          .fetchCoupons()
          .then((value) {
        Provider.of<OffersProvider>(context, listen: false).fetchOffers();
      }).then((_) {
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
          'Wafar Cash!',
        ),
        //Favorites Filter
        // actions: <Widget>[
        //   PopupMenuButton(
        //       onSelected: (FilterCoupons selectedValue) {
        //         setState(() {
        //           if (selectedValue == FilterCoupons.Favourites) {
        //             _showOnlyFavorites = true;
        //           } else if (selectedValue == FilterCoupons.All) {
        //             _showOnlyFavorites = false;
        //           }
        //         });
        //       },
        //       icon: Icon(Icons.more_vert),
        //       itemBuilder: (_) => [
        //             PopupMenuItem(
        //                 child: Text('Favorites only'),
        //                 value: FilterCoupons.Favourites),
        //             PopupMenuItem(
        //                 child: Text('Show all'), value: FilterCoupons.All),
        //           ])
        // ],
        // backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   child: Text(
          //     'Top offers',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : BannerSlider(),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   child: Text(
          //     'New Coupons',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //   ),
          // ),
          CategorySlider(),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : CouponsListView(categoryFilter),
        ],
      ),
    );
  }
}

class CategorySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //access the coupon data
    //instance of the coupons provider
    final coupons = Provider.of<CouponsProvider>(context).items;

    //a list of all existing categories
    List<String> _categories = [];
    coupons.forEach((coupon) {
      if (coupon.category != null) {
        _categories.add(coupon.category);
      }
    });

    //filter duplicated categories
    final filteredList = Set();
    _categories.retainWhere((category) => filteredList.add(category));

    print(_categories.length);
    // for (int i = 0; i < _categories.length; i++) {
    //   print(_categories[i]);
    // }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    _categories[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )),
            onTap: () {
              Navigator.of(context).pushNamed(CategorizedStoresScreen.routeName,
                  arguments: _categories[index]);
            },
          );
        },
      ),
    );
  }
}
