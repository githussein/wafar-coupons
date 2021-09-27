import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_offer_screen.dart';
import '../providers/offers_provider.dart';

class AdminOfferItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  AdminOfferItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
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
                  .pushNamed(EditOfferScreen.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text('Remove Offer'),
                        content:
                            Text('Are you sure you want to delete this offer?'),
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
                                  await Provider.of<OffersProvider>(context,
                                          listen: false)
                                      .deleteOffer(id);
                                } catch (error) {
                                  scaffoldMessenger.showSnackBar(SnackBar(
                                      content: Text(
                                    'Failed to delete offer!',
                                    textAlign: TextAlign.center,
                                  )));
                                }
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
