import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whats_for_dinner/utils/ad_helper.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _createBottomBannerAd();
    });
    //reset ad
    /*
    Future.delayed(Duration(seconds: 3)).then((value) {
      _createBottomBannerAd();
      print("reset ad");
    });
    */
  }

  late BannerAd _bottomBannerAd;
  bool _isBottomBanerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBottomBanerAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        //print('Ad failed to load');
        ad.dispose();
      }),
      request: const AdRequest(),
    );
    _bottomBannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isBottomBanerAdLoaded
        ? SizedBox(
            width: _bottomBannerAd.size.width.toDouble(),
            height: _bottomBannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bottomBannerAd),
          )
        : Container();
  }
}
