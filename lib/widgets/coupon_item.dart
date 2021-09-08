import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/coupon_detail_screen.dart';
import '../providers/coupon.dart';

class CouponItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //listen once to the provider to get coupon object
    final coupon = Provider.of<Coupon>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          CouponDetailScreen.routeName,
          arguments: coupon.id,
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            border:
                Border(right: BorderSide(width: 1.0, color: Colors.white24))),
        child: Image.network(
          coupon.imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        coupon.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Text(coupon.description),
      //a listener for this part only
      trailing: Consumer<Coupon>(
        builder: (context, coupon, _) => IconButton(
          onPressed: () {
            coupon.toggleFavoriteStatus();
          },
          icon:
              Icon(coupon.isFavorite ? Icons.favorite : Icons.favorite_border),
          color: Colors.deepOrange,
          iconSize: 30,
        ),
      ),
    );
  }
}
