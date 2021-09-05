import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wafar_cash/providers/coupons_provider.dart';

class CouponDetailScreen extends StatelessWidget {
  static const routeName = '/coupon-details';

  @override
  Widget build(BuildContext context) {
    //extract data of the coupon using th ID
    final String couponId =
        ModalRoute.of(context).settings.arguments as String; //the id

    //access the coupon data, listen only the first time
    final loadedCoupon =
        Provider.of<CouponsProvider>(context, listen: true).findById(couponId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCoupon.title),
      ),
    );
  }
}
