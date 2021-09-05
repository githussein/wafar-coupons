import 'package:flutter/material.dart';
import '../widgets/coupons_list.dart';

class CouponsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          'Coupons',
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: CouponsList(),
    );
  }
}
