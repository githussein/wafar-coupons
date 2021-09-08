import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './coupon_item.dart';
import '../providers/coupons_provider.dart';

class CouponsListView extends StatelessWidget {
  final bool showFavorites;

  CouponsListView(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    //access the coupon data
    //instance of the coupons provider
    final couponsData = Provider.of<CouponsProvider>(context);

    //store the list of coupons
    final coupons = showFavorites ? couponsData.favItems : couponsData.items;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          // create: (ctx) => coupons[index],
          value: coupons[index],
          child: CouponItem(),
        ),
      ),
    );
  }
}
