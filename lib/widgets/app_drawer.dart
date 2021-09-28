import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/manage_coupons_screen.dart';
import '../screens/manage_offers_screen.dart';
import '../services/auth.dart';
import '../screens/stores_screen.dart';
import '../screens/contact_us.dart';
import '../screens/request_coupon_screen.dart';
import '../screens/manage_requests_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
            elevation: 0,
            title: Text('Wafar Cash'),
            automaticallyImplyLeading: false //don't display back button
            ),
        Expanded(
          // ListView contains a group of widgets that scroll inside the drawer
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text('Home Page'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              ListTile(
                leading: Icon(Icons.storefront_sharp),
                title: Text('Stores'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(StoresScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Request a coupon'),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RequestCouponScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Contact us'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ContactUsScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Manage Coupons'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ManageCouponsScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Manage Offers'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ManageOffersScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Manage Requests'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ManageRequestsScreen.routeName);
                },
              ),
            ],
          ),
        ),
        Container(
            // This align moves the children to the bottom
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Log out'),
                      onTap: () async {
                        //1- close the drawer
                        Navigator.of(context).pop();
                        await context.read<AuthService>().signOut();
                      },
                    ),
                  ],
                )))),
      ],
    ));
  }
}
