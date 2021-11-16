import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                leading: FaIcon(
                  FontAwesomeIcons.home,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Text(AppLocalizations.of(context).home_page),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              _buildDivider(),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.store,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Text(AppLocalizations.of(context).stores),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(StoresScreen.routeName);
                },
              ),
              _buildDivider(),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.fileContract,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Text(AppLocalizations.of(context).request_coupon),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(RequestCouponScreen.routeName);
                },
              ),
              _buildDivider(),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Text(AppLocalizations.of(context).contact_us),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(ContactUsScreen.routeName);
                },
              ),
              _buildDivider(),
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
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).primaryColorDark,
                        ),
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

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 200,
      height: 1.0,
      color: Colors.grey.shade200,
    );
  }
}
