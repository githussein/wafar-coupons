import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/app_drawer.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).contact_us)),
      drawer: AppDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      AppLocalizations.of(context).contact_us_message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.smileBeam,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    // AppLocalizations.of(context).contact_us_message,
                  ),
                ),
                const SizedBox(height: 16.0),
                Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.edgeLegacy,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(AppLocalizations.of(context).website),
                          trailing: FaIcon(
                            FontAwesomeIcons.externalLinkSquareAlt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () async {
                            await _openLink('https://wafarcash.com');
                          }),
                      _buildDivider(),
                      ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(AppLocalizations.of(context).facebook),
                          trailing: FaIcon(
                            FontAwesomeIcons.externalLinkSquareAlt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () async {
                            await _openLink(
                                'https://www.facebook.com/wafarcashcom');
                          }),
                      _buildDivider(),
                      ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(AppLocalizations.of(context).instagram),
                          trailing: FaIcon(
                            FontAwesomeIcons.externalLinkSquareAlt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () async {
                            await _openLink(
                                'https://www.instagram.com/wafarcashofficial');
                          }),
                      _buildDivider(),
                      ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(AppLocalizations.of(context).twitter),
                          trailing: FaIcon(
                            FontAwesomeIcons.externalLinkSquareAlt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () async {
                            await _openLink('https://twitter.com/wafarcash');
                          }),
                      _buildDivider(),
                      ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(AppLocalizations.of(context).email),
                          trailing: FaIcon(
                            FontAwesomeIcons.externalLinkSquareAlt,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () => _sendEmail()),
                      _buildDivider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }

  Future<void> _openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendEmail() async {
    {
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'Info@wafarcash.com',
      );
      String url = params.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    }
  }
}
