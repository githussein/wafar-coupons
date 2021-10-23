import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/locale_provider.dart';
import '../providers/coupons_provider.dart';
import '../providers/offers_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/coupons_listview.dart';
import '../widgets/banner_slider.widget.dart';
import 'categorized_stores_screen.dart';
import '../widgets/language_picker_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/ad_helper.dart';

enum FilterCoupons { Favourites, All }
enum AppLanguage { ARABIC, ENGLISH }
String categoryFilter = "all";

class HomeScreen extends StatefulWidget {
  // static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).home_page),
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

        // actions: <Widget>[
        //   PopupMenuButton(
        //     icon: Icon(Icons.language),
        //     itemBuilder: (_) => [
        //       PopupMenuItem(child: Text('عربي'), value: AppLanguage.ARABIC),
        //       PopupMenuItem(child: Text('English'), value: AppLanguage.ENGLISH),
        //     ],
        //     onSelected: (AppLanguage selectedValue) {
        //       setState(() {
        //         if (selectedValue == AppLanguage.ARABIC) {
        //           final provider =
        //               Provider.of<LocaleProvider>(context, listen: false);
        //           provider.setLocale(provider.locale);
        //         } else if (selectedValue == AppLanguage.ENGLISH) {
        //           final provider =
        //               Provider.of<LocaleProvider>(context, listen: false);
        //           provider.setLocale(provider.locale);
        //         }
        //       });
        //     },
        //   )
        // ],

        actions: [
          LanguagePickerWidget(),
          const SizedBox(width: 12),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
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
