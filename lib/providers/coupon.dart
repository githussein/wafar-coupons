import 'package:flutter/foundation.dart';

class Coupon with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  bool isFavorite;

  Coupon({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.link,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
