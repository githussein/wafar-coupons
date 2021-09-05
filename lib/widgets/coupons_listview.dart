import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './coupon_item.dart';
import '../providers/coupons_provider.dart';

class CouponsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //access the coupon data
    final couponsData = Provider.of<CouponsProvider>(
        context); //instance of the coupons provider

    //store the list of coupons
    final coupons = couponsData.items;

    return ListView.builder(
      itemCount: coupons.length,
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (ctx) => coupons[index],
        child: CouponItem(
            // coupons[index].id,
            // coupons[index].title,
            // coupons[index].description,
            // coupons[index].imageUrl,
            ),
      ),
    );
  }
}
