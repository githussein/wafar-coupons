import 'package:flutter/material.dart';
import '../screens/coupon_detail_screen.dart';

class CouponItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  CouponItem(this.id, this.title, this.description, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          CouponDetailScreen.routeName,
          arguments: id,
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            border:
                Border(right: BorderSide(width: 1.0, color: Colors.white24))),
        child: Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
      subtitle: Text(description, style: TextStyle(color: Colors.white)),
    );
  }
}
