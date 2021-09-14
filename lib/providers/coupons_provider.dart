import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'coupon.dart';
import '../models/http_exception.dart';

class CouponsProvider with ChangeNotifier {
  //A list of pre-loaded coupons
  List<Coupon> _couponsItems = [
    // Coupon(
    //   id: "c1",
    //   title: "Namshi",
    //   code: "AH5",
    //   description: "15% discount on all products",
    //   imageUrl:
    //       "https://uae.governmentjobs.guru/wp-content/uploads/2020/12/Namashi-Jobs.png",
    //   link: "https://ar-sa.www.namshi.com/",
    // ),
    // Coupon(
    //   id: "c2",
    //   title: "Noon",
    //   code: "AH5",
    //   description: "10% discount on all products",
    //   imageUrl:
    //       "https://mir-s3-cdn-cf.behance.net/projects/404/2c23bd95299963.Y3JvcCw4NDgsNjY0LDE4MCww.jpg",
    //   link: "https://www.noon.com/saudi-en/",
    // ),
    // Coupon(
    //   id: "c3",
    //   title: "Bath and Body",
    //   code: "AH5",
    //   description: "10% discount on selected products",
    //   imageUrl:
    //       "https://bestgiftcardmarket.com/wp-content/uploads/2020/06/BATHANDBODYWORKS.jpeg",
    //   link: "https://www.bathandbodyworks.com.sa/ar/",
    // ),
    // Coupon(
    //   id: "c4",
    //   title: "Max",
    //   code: "AH5",
    //   description: "10% discount on all products",
    //   imageUrl:
    //       "https://www.centralparkjakarta.com/wp-content/uploads/2018/08/MAX-Fashions-3.png",
    //   link: "https://www.maxfashion.com/sa/en/",
    // ),
    // Coupon(
    //   id: "c5",
    //   title: "Carrefour",
    //   code: "AH5",
    //   description: "10% discount on all products",
    //   imageUrl: "https://www.brandslex.de/img/logos/xl/c/logo-carrefour-03.png",
    //   link: "https://www.carrefourksa.com/",
    // ),
  ]; //private

  // var _showFavoritesOnly = false;

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

  Future<void> addCoupon(Coupon coupon) async {
    //Send data to the server
    final url = Uri.parse(
        'https://wafar-cash-demo-default-rtdb.europe-west1.firebasedatabase.app/coupons.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': coupon.title,
          'code': coupon.code,
          'description': coupon.description,
          'imageUrl': coupon.imageUrl,
          'link': coupon.link,
          'isFavorite': coupon.isFavorite,
        }),
      );
      //This will only runs after the previous block
      //It is invisibly wrapped in a "then" block
      final newCoupon = Coupon(
          //Use theunique id generated by Flutter
          id: json.decode(response.body)['name'],
          title: coupon.title,
          code: coupon.code,
          description: coupon.description,
          imageUrl: coupon.imageUrl,
          link: coupon.link);
      //add the coupon to the local list on top
      _couponsItems.insert(0, newCoupon);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateCoupon(String id, Coupon newCoupon) async {
    final url = Uri.parse(
        'https://wafar-cash-demo-default-rtdb.europe-west1.firebasedatabase.app/coupons/$id.json');
    final coupIndex = _couponsItems.indexWhere((coup) => coup.id == id);

    if (coupIndex >= 0) {
      try {
        await http.patch(url,
            body: json.encode({
              'title': newCoupon.title,
              'code': newCoupon.code,
              'description': newCoupon.description,
              'imageUrl': newCoupon.imageUrl,
              'link': newCoupon.link,
              // 'isFavorite': newCoupon.isFavorite,
            }));
      } catch (error) {
        throw error;
      }

      _couponsItems[coupIndex] = newCoupon;
      notifyListeners();
    }
  }

  Future<void> deleteCoupon(String id) async {
    final url = Uri.parse(
        'https://wafar-cash-demo-default-rtdb.europe-west1.firebasedatabase.app/coupons/$id.json');

    //perform Optimistic Updating
    final existingCouponIndex =
        _couponsItems.indexWhere((coup) => coup.id == id);
    var existingCoupon = _couponsItems[existingCouponIndex]; //store a copy
    _couponsItems.removeAt(existingCouponIndex); //immediately delete
    notifyListeners();

    //Delete on the server and check errors
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _couponsItems.insert(existingCouponIndex, existingCoupon);
      notifyListeners();
      throw HttpException('Could not delete coupon'); //return
    }

    //if no problems occurred
    existingCoupon = null; //remove it from memory
  }

  Future<void> fetchCoupons() async {
    final url = Uri.parse(
        'https://wafar-cash-demo-default-rtdb.europe-west1.firebasedatabase.app/coupons.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Coupon> loadedCouponsList = [];

      extractedData.forEach((couponId, couponData) {
        loadedCouponsList.add(Coupon(
          id: couponId,
          title: couponData['title'],
          code: couponData['code'],
          description: couponData['description'],
          imageUrl: couponData['imageUrl'],
          link: couponData['link'],
          isFavorite: couponData['isFavorite'],
        ));
      });
      _couponsItems = loadedCouponsList;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
