import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/stores_listview.dart';
import '../providers/coupons_provider.dart';
import '../widgets/app_drawer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/ad_helper.dart';

enum FilterCoupons { Favourites, All }

class StoresScreen extends StatefulWidget {
  static const routeName = '/stores';
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  // ===== Google Mobile Ads =====
  // InterstitialAd _interstitialAd;
  // bool _isInterstitialAdReady = false;
  //
  // void _loadInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: AdHelper.interstitialAdUnitId,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         this._interstitialAd = ad;
  //
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             Navigator.pop(context);
  //           },
  //         );
  //
  //         _isInterstitialAdReady = true;
  //       },
  //       onAdFailedToLoad: (err) {
  //         print('Failed to load an interstitial ad: ${err.message}');
  //         _isInterstitialAdReady = false;
  //       },
  //     ),
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   _interstitialAd.dispose();
  //   super.dispose();
  // }

  //manage state
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   _loadInterstitialAd();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CouponsProvider>(context, listen: false)
          .fetchCoupons() //fetch coupons data
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).stores,
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : StoresListView(),
    );
  }
}
