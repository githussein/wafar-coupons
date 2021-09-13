import 'package:flutter/material.dart';
import 'package:wafar_cash/screens/edit_coupon_screen.dart';

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
            color: Theme.of(context).errorColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            color: Theme.of(context).primaryColor,
          ),
        ]),
      ),
    );
  }
}
