import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_coupon_screen.dart';
import '../providers/coupons_provider.dart';

class AdminCouponItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  AdminCouponItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditCouponScreen.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text('Remove Coupon'),
                        content: Text(
                            'Are you sure you want to delete this coupon?'),
                        actions: [
                          MaterialButton(
                              child: Text(
                                'No',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              }),
                          MaterialButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Provider.of<CouponsProvider>(context,
                                        listen: false)
                                    .deleteCoupon(id);
                                Navigator.of(ctx).pop();
                              }),
                        ],
                      ));
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).primaryColor,
          ),
        ]),
      ),
    );
  }
}
