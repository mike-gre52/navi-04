import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

//Test Banner Ad Id
//ca-app-pub-3940256099942544/2934735716


