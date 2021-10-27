import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../main.dart';
import '../providers/locale_provider.dart';
import '../providers/coupons_provider.dart';
import '../providers/offers_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/coupons_listview.dart';
import '../widgets/banner_slider.widget.dart';
import 'categorized_stores_screen.dart';
import '../widgets/language_picker_widget.dart';
import 'package:wafar_cash/screens/coupon_detail_screen.dart';
import '../models/ad_helper.dart';

enum FilterCoupons { Favourites, All }
enum AppLanguage { ARABIC, ENGLISH }
String categoryFilter = "all";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  print("Handling a background message: ${event.messageId}");

  Navigator.of(navigatorKey.currentContext)
      .pushNamed(CouponDetailScreen.routeName, arguments: event.data['coupId']);
}

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
    // ===== PUSH NOTIFICATIONS =====
    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;

    //Request permission for iOS devices
    if (Platform.isIOS) {
      messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    messaging.getToken().then((value) {
      print('Device token: ' + value);
    });

    //Handle notifications in different scenarios
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
      print("onMessageOpenedApp: $event");

      if (event.data['coupId'] != null) {
        Navigator.of(context).pushNamed(CouponDetailScreen.routeName,
            arguments: event.data['coupId']);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('message new received: ' + event.data['coupId']);

      if (event.data['coupId'] != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(event.notification.title),
                content: Text(event.notification.body),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          CouponDetailScreen.routeName,
                          arguments: event.data['coupId']);
                    },
                    child: Text('تصفح الكوبون'),
                  )
                ],
              );
            });
      }
    });

    // ===== GOOGLE MOBILE ADS =====
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

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

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
