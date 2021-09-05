import 'package:flutter/cupertino.dart';
import 'coupon.dart';

class CouponsProvider with ChangeNotifier {
  //A list of pre-loaded coupons
  List<Coupon> _items = [
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
  ]; //private

  List<Coupon> get items {
    return [..._items]; //return a copy
  }

  //
  Coupon findById(String id) {
    return items.firstWhere((coup) => coup.id == id);
  }

  void addCoupon() {
    notifyListeners();
  }
}
