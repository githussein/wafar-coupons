import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/requests_provider.dart';

class AdminRequestItem extends StatelessWidget {
  final String id;
  final String userName;
  final String email;
  final String store;
  final String link;

  AdminRequestItem(this.id, this.userName, this.email, this.store, this.link);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(userName),
          Text(email),
          Text(link),
        ],
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                _openLink(link);
              },
              icon: Icon(Icons.launch),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Remove Request'),
                          content: Text(
                              'Are you sure you want to delete this request?'),
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
                                onPressed: () async {
                                  try {
                                    await Provider.of<RequestsProvider>(context,
                                            listen: false)
                                        .deleteRequest(id);
                                  } catch (error) {
                                    scaffoldMessenger.showSnackBar(SnackBar(
                                        content: Text(
                                      'Failed to delete request!',
                                      textAlign: TextAlign.center,
                                    )));
                                  }
                                  Navigator.of(ctx).pop();
                                }),
                          ],
                        ));
              },
              icon: Icon(Icons.delete),
              color: Colors.red.shade800,
            ),
          ],
        ),
      ),
    );
  }

  void _openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch ';
  }
}
