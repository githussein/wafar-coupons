import 'package:flutter/material.dart';

class CouponDetailScreen extends StatelessWidget {
  static const routeName = '/coupon-details';

  @override
  Widget build(BuildContext context) {
    //extract data of the coupon using th ID
    final String CouponId =
        ModalRoute.of(context).settings.arguments as String; //the id

    return Scaffold(
      appBar: AppBar(),
    );
  }
}
