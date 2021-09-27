import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../providers/coupon.dart';
import '../providers/coupons_provider.dart';
import '../screens/coupon_detail_screen.dart';

class StoreCouponsListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //extract data of the coupon using th store name
    final String storeName =
        ModalRoute.of(context).settings.arguments as String; //the store name

    //access the coupon data
    //instance of the coupons provider
    final couponsData = Provider.of<CouponsProvider>(context);

    //store the list of coupons
    final coupons =
        couponsData.items.where((coup) => coup.store == storeName).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: coupons.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (ctx) => coupons[index],
        value: coupons[index],
        child: CouponItem(coupons[index].store),
      ),
    );
  }
}

class CouponItem extends StatelessWidget {
  final storeName;
  CouponItem(this.storeName);
  @override
  Widget build(BuildContext context) {
    //listen once to the provider to get coupon object
    final coupon = Provider.of<Coupon>(context, listen: false);
    return Card(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      elevation: 2,
      child: ListTile(
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
            width: 70,
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
            onPressed: () async {
              // coupon.toggleFavoriteStatus();
              await Share.share('كوبون خصم ' +
                  coupon.title +
                  '\n' +
                  'استخدم الكود التالي من وفر كاش ' +
                  '\n' +
                  coupon.code);
            },
            icon: Icon(Icons.share_outlined
                // coupon.isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
