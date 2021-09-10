import 'package:flutter/material.dart';
import 'package:wafar_cash/screens/manage_coupons_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Text('Wafar Cash'),
          automaticallyImplyLeading: false, //don't display back button
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Coupons & Offers'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.storefront_sharp),
          title: Text('Stores'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Contact us'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(ManageCouponsScreen.routeName);
          },
        ),
      ],
    ));
  }
}
