import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/app_drawer.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).contact_us)),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).contact_us,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              child: Text('.'),
            ),
            Container(
              child: Text('.'),
            ),
            Container(
              child: Text('.'),
            ),
            Container(
              child: Text('.'),
            ),
            Container(
              child: Text('.'),
            ),
            MaterialButton(
                child: Text(
                  'Facebook',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  _openLink("https://www.facebook.com/");
                }),
            Divider(),
            MaterialButton(
                child: Text(
                  'Twitter',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  _openLink("https://www.twitter.com/");
                }),
            Divider(),
            MaterialButton(
                child: Text(
                  'Instagram',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  _openLink("https://www.instagram.com/");
                }),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch ';
  }
}
