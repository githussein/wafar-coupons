import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../widgets/coupon_item.dart';

class CouponsOverviewScreen extends StatelessWidget {
  //A list of pre-loaded coupons
  final List<Coupon> loadedCoupons = [
    Coupon(
      id: "c1",
      title: "Namshi",
      description: "15% discount on all products",
      imageUrl:
          "https://uae.governmentjobs.guru/wp-content/uploads/2020/12/Namashi-Jobs.png",
    ),
    Coupon(
      id: "c2",
      title: "Noon",
      description: "10% discount on all products",
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/projects/404/2c23bd95299963.Y3JvcCw4NDgsNjY0LDE4MCww.jpg",
    ),
    Coupon(
      id: "c3",
      title: "Bath and Body",
      description: "10% discount on selected products",
      imageUrl:
          "https://bestgiftcardmarket.com/wp-content/uploads/2020/06/BATHANDBODYWORKS.jpeg",
    ),
    Coupon(
      id: "c4",
      title: "Max",
      description: "10% discount on all products",
      imageUrl:
          "https://www.centralparkjakarta.com/wp-content/uploads/2018/08/MAX-Fashions-3.png",
    ),
    Coupon(
      id: "c5",
      title: "Carrefour",
      description: "10% discount on all products",
      imageUrl: "https://www.brandslex.de/img/logos/xl/c/logo-carrefour-03.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(
          'Coupons',
        ),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: ListView.builder(
        itemCount: loadedCoupons.length,
        itemBuilder: (context, index) {
          return CouponItem(
            loadedCoupons[index].id,
            loadedCoupons[index].title,
            loadedCoupons[index].description,
            loadedCoupons[index].imageUrl,
          );
        },
      ),
    );
  }
}
