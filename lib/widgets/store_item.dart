import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/coupon_detail_screen.dart';
import '../providers/coupon.dart';

class StoreItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //listen once to the provider to get coupon object
    final coupon = Provider.of<Coupon>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
        color: Colors.white70,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            CouponDetailScreen.routeName,
            arguments: coupon.id,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            Container(
              child: Expanded(
                child: Text(
                  coupon.store,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(coupon.imageUrl),
              minRadius: 20,
              maxRadius: 30,
            ),
          ],
        ),
      ),
    );
  }
}
