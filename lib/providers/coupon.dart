import 'package:flutter/foundation.dart';

class Coupon with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  bool isFinal;

  Coupon({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    this.isFinal = false,
  });
}
