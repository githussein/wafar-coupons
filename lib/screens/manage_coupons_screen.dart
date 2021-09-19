import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_coupon_screen.dart';
import '../providers/coupons_provider.dart';
import '../widgets/admin_coupon_item.dart';
import '../widgets/app_drawer.dart';

class ManageCouponsScreen extends StatelessWidget {
  static const routeName = '/manage-coupons';

  //function to handle Refresh Indicator
  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<CouponsProvider>(ctx, listen: false).fetchCoupons();
  }

  @override
  Widget build(BuildContext context) {
    //Listen to changes in the coupons list
    final couponsData = Provider.of<CouponsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Coupons'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditCouponScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all((10)),
          child: ListView.builder(
            itemCount: couponsData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                AdminCouponItem(
                  couponsData.items[i].id,
                  couponsData.items[i].title,
                  couponsData.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
