import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/coupons_overview_screen.dart';
import './screens/coupon_detail_screen.dart';
import './providers/coupons_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider of all the coupons
    return ChangeNotifierProvider(
      create: (context) => CouponsProvider(),
      child: MaterialApp(
        title: 'Wafar Cash',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
        ),
        home: CouponsOverviewScreen(),
        routes: {
          CouponDetailScreen.routeName: (ctx) => CouponDetailScreen(),
        },
      ),
    );
  }
}
