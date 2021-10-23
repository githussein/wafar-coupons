import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../providers/coupons_provider.dart';
import '../screens/coupon_detail_screen.dart';
import '../providers/coupon.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/ad_helper.dart';

class CouponsListView extends StatelessWidget {
  // final bool showFavorites;
  final String categoryFilter;

  CouponsListView(this.categoryFilter);

  @override
  Widget build(BuildContext context) {
    //access the coupon data
    //instance of the coupons provider
    final couponsData = Provider.of<CouponsProvider>(context);

    //store the list of coupons
    final coupons = couponsData.items;

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: coupons.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (ctx) => coupons[index],
        value: coupons[index],
        child: CouponItem(),
      ),
    );
  }
}

class CouponItem extends StatelessWidget {
  // ===== Google Mobile Ads =====
  static int count = 3;
  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  @override
  Widget build(BuildContext context) {
    void _loadInterstitialAd(String couponId) {
      InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this._interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                Navigator.of(context).pushNamed(
                  CouponDetailScreen.routeName,
                  arguments: couponId,
                );
              },
            );

            _isInterstitialAdReady = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            _isInterstitialAdReady = false;
          },
        ),
      );
    }

    //listen once to the provider to get coupon object
    final coupon = Provider.of<Coupon>(context, listen: false);

    _loadInterstitialAd(coupon.id);

    return Card(
      margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
      elevation: 2,
      child: ListTile(
        onTap: () {
          if (_isInterstitialAdReady && ((count * 3) % 4 == 0)) {
            _interstitialAd?.show();
          } else {
            Navigator.of(context).pushNamed(
              CouponDetailScreen.routeName,
              arguments: coupon.id,
            );
          }
          print('count = $count, (count * 3) % 4 = ${(count * 3) % 4}');
          count++;
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Image.network(
            coupon.imageUrl,
            width: 70,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          coupon.store,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
        subtitle: Text(
          coupon.description,
          maxLines: 2,
        ),
        //a listener for this part only
        trailing: Consumer<Coupon>(
          builder: (context, coupon, _) => IconButton(
            onPressed: () async {
              // coupon.toggleFavoriteStatus();
              await Share.share('كوبون خصم ' +
                  coupon.title +
                  '\n' +
                  'استخدم الكود التالي من وفر كاش ' +
                  '\n' +
                  coupon.code);
            },
            icon: Icon(Icons.share_outlined
                // coupon.isFavorite ? Icons.favorite : Icons.favorite_border),
                ),
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            iconSize: 30,
          ),
        ),
      ),
    );
  }
}
