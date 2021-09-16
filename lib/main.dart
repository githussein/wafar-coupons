import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wafar_cash/providers/OffersProvider.dart';
import 'package:wafar_cash/screens/edit_coupon_screen.dart';
import 'package:wafar_cash/screens/edit_offer_screen.dart';
import 'package:wafar_cash/screens/manage_offers_screen.dart';

import './screens/coupons_overview_screen.dart';
import './screens/coupon_detail_screen.dart';
import './providers/coupons_provider.dart';
import 'screens/manage_coupons_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider of all the coupons
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CouponsProvider()),
        ChangeNotifierProvider(create: (context) => OffersProvider()),
      ],
      child: MaterialApp(
        title: 'Wafar Cash',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.lightBlue,
          fontFamily: 'Lato',
        ),
        home: CouponsOverviewScreen(),
        routes: {
          CouponDetailScreen.routeName: (ctx) => CouponDetailScreen(),
          ManageCouponsScreen.routeName: (ctx) => ManageCouponsScreen(),
          EditCouponScreen.routeName: (ctx) => EditCouponScreen(),
          ManageOffersScreen.routeName: (ctx) => ManageOffersScreen(),
          EditOfferScreen.routeName: (ctx) => EditOfferScreen(),
        },
      ),
    );
  }
}
