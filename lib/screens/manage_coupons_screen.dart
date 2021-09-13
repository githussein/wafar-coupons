import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wafar_cash/screens/edit_coupon_screen.dart';
import 'package:wafar_cash/widgets/coupon_item.dart';

import '../providers/coupons_provider.dart';
import '../widgets/admin_coupon_item.dart';
import '../widgets/app_drawer.dart';

class ManageCouponsScreen extends StatelessWidget {
  static const routeName = '/manage-coupons';

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.all(
          (10),
        ),
        child: ListView.builder(
          itemCount: couponsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              AdminCouponItem(
                couponsData.items[i].title,
                couponsData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
