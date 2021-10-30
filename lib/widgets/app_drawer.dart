import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/auth.dart';
import '../screens/stores_screen.dart';
import '../screens/contact_us.dart';
import '../screens/request_coupon_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
            elevation: 0,
            title: Text(AppLocalizations.of(context).app_name),
            automaticallyImplyLeading: false //don't display back button
            ),
        Expanded(
          // ListView contains a group of widgets that scroll inside the drawer
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.card_giftcard),
                title: Text(AppLocalizations.of(context).home_page),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              ListTile(
                leading: Icon(Icons.storefront_sharp),
                title: Text(AppLocalizations.of(context).stores),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(StoresScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.send),
                title: Text(AppLocalizations.of(context).request_coupon),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RequestCouponScreen.routeName);
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text(AppLocalizations.of(context).contact_us),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ContactUsScreen.routeName);
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
                      // ListTile(
                      //   leading: Icon(Icons.edit),
                      //   title:
                      //       Text(AppLocalizations.of(context).manage_coupons),
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(ManageCouponsScreen.routeName);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.edit),
                      //   title: Text(AppLocalizations.of(context).manage_offers),
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .pushNamed(ManageOffersScreen.routeName);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.edit),
                      //   title:
                      //       Text(AppLocalizations.of(context).manage_requests),
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .popAndPushNamed(ManageRequestsScreen.routeName);
                      //   },
                      // ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(AppLocalizations.of(context).logout),
                        onTap: () async {
                          //1- close the drawer
                          Navigator.of(context).pop();
                          await context.read<AuthService>().signOut();
                        },
                      ),
                    ],
                  ),
                ))),
      ],
    ));
  }
}
