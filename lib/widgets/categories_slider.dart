import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupons_provider.dart';

class CategorySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //access the coupon data
    //instance of the coupons provider
    final coupons = Provider.of<CouponsProvider>(context).items;

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          // create: (ctx) => coupons[index],
          value: coupons[index],
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(
                  coupons[index].description,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
