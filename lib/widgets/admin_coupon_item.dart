import 'package:flutter/material.dart';

class AdminCouponItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  AdminCouponItem(this.title, this.imageUrl);

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
            onPressed: () {},
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
