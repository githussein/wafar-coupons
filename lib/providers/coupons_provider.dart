import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'coupon.dart';
import 'package:http/http.dart' as http;

class CouponsProvider with ChangeNotifier {
  //A list of pre-loaded coupons
  List<Coupon> _couponsItems = [
    Coupon(
      id: "c1",
      title: "Namshi",
      description: "15% discount on all products",
      imageUrl:
          "https://uae.governmentjobs.guru/wp-content/uploads/2020/12/Namashi-Jobs.png",
      link: "https://ar-sa.www.namshi.com/",
    ),
    Coupon(
      id: "c2",
      title: "Noon",
      description: "10% discount on all products",
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/projects/404/2c23bd95299963.Y3JvcCw4NDgsNjY0LDE4MCww.jpg",
      link: "https://www.noon.com/saudi-en/",
    ),
    Coupon(
      id: "c3",
      title: "Bath and Body",
      description: "10% discount on selected products",
      imageUrl:
          "https://bestgiftcardmarket.com/wp-content/uploads/2020/06/BATHANDBODYWORKS.jpeg",
      link: "https://www.bathandbodyworks.com.sa/ar/",
    ),
    Coupon(
      id: "c4",
      title: "Max",
      description: "10% discount on all products",
      imageUrl:
          "https://www.centralparkjakarta.com/wp-content/uploads/2018/08/MAX-Fashions-3.png",
      link: "https://www.maxfashion.com/sa/en/",
    ),
    Coupon(
      id: "c5",
      title: "Carrefour",
      description: "10% discount on all products",
      imageUrl: "https://www.brandslex.de/img/logos/xl/c/logo-carrefour-03.png",
      link: "https://www.carrefourksa.com/",
    ),
  ]; //private

  var _showFavoritesOnly = false;

  List<Coupon> get items {
    return [..._couponsItems]; //return a copy
  }

  List<Coupon> get favItems {
    return _couponsItems.where((couponItem) => couponItem.isFavorite).toList();
  }

  //
  Coupon findById(String id) {
    return items.firstWhere((coup) => coup.id == id);
  }

  void addCoupon() {
    notifyListeners();
  }

  Future<void> fetchCoupons() async {
    final url = Uri.parse('https://flutter=update.firebaseio.com/');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Coupon> loadedCoupons = [];
      extractedData.forEach((couponId, couponData) {
        loadedCoupons.add(Coupon(
          id: couponId,
          title: couponData['title'],
          description: couponData['description'],
          imageUrl: couponData['imageUrl'],
          link: couponData['link'],
          isFavorite: couponData['isFavorite'],
        ));
      });
      _couponsItems = loadedCoupons;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
