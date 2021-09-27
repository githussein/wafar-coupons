import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/coupon.dart';
import '../providers/coupons_provider.dart';
import '../screens/store_coupons_screen.dart';

class StoresListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String storeName =
        ModalRoute.of(context).settings.arguments as String; //the store name

    //access the coupon data
    //instance of the coupons provider
    final couponsData = Provider.of<CouponsProvider>(context);

    //list of all coupons
    final coupons = couponsData.items;
    //Remove duplications in the list, filter by store name
    final filteredList = Set();
    coupons.retainWhere((coup) => filteredList.add(coup.store));

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: coupons.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (ctx) => coupons[index],
        value: coupons[index],
        child: StoreItem(),
      ),
    );
  }
}

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
            StoreCouponsScreen.routeName,
            arguments: coupon.store,
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
