import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    //Ad Unit IDs from Google Mobile Ads platform
    if (Platform.isAndroid) {
      return 'ca-app-pub-3152805428748942/3350039103';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3152805428748942/3299397209';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3152805428748942/6333271576';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3152805428748942/8300471970';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
