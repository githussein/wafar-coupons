import 'package:flutter/cupertino.dart';
import 'Offer.dart';

class OffersProvider with ChangeNotifier {
  //A list of pre-loaded coupons
  List<Offer> _offersItems = [
    Offer(
        id: "o1",
        imageUrl:
            "https://image.shutterstock.com/image-vector/summer-sale-template-banner-vector-260nw-656471581.jpg",
        link: "https://islamway.net"),
    Offer(
        id: "o2",
        imageUrl:
            "https://cdn3.vectorstock.com/i/1000x1000/93/42/biggest-sale-offers-and-discount-banner-template-vector-14299342.jpg",
        link: "https://islamway.net"),
    Offer(
        id: "o3",
        imageUrl:
            "https://media.istockphoto.com/vectors/flash-sale-banner-lightning-sales-poster-fast-offer-discount-and-only-vector-id1145641382",
        link: "https://islamway.net"),
  ];

  List<Offer> get items {
    return [..._offersItems];
  }

  Offer findById(String id) {
    return items.firstWhere((offer) => offer.id == id);
  }
}
