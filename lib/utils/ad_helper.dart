import 'dart:io';

import 'package:whats_for_dinner/utils/hidden.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
      //return BANNER_AD_UNIT;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

//Test Banner Ad Id
//ca-app-pub-3940256099942544/2934735716


