import 'package:flutter/material.dart';
import './screens/coupons_overview_screen.dart';
import './screens/coupon_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
