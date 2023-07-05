import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/utils/ad_helper.dart';

class BannerAdWidget extends StatefulWidget {
  bool addMargin;
  BannerAdWidget({
    super.key,
    this.addMargin = false,
  });

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    if (!isPremium) {
      print("Loading ad");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _createBottomBannerAd();
      });
    }

    //reloadAd();
  }

/*
  bool inForeground = true;
  reloadAd() {
    int resetAdDuration = 45;
    Timer.periodic(Duration(seconds: resetAdDuration), (timer) {
      if (mounted && inForeground) {
        //print("reset ad");
        _createBottomBannerAd();
      } else {
        //print("timer cancled");
        timer.cancel();
      }
    });
  }
*/
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

  /*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print(state);
    if (state != AppLifecycleState.resumed) {
      // in background
      //print("stop ad");
      //inForeground = false;
    }
    if (state == AppLifecycleState.resumed) {
      //inForeground = true;
      //print("restart ad");
      //reloadAd();
    }
  }
  */

  @override
  void dispose() {
    super.dispose();
    if (!isPremium) {
      _bottomBannerAd.dispose();
    }

    //WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return !isPremium
        ? _isBottomBanerAdLoaded
            ? Container(
                margin: EdgeInsets.only(bottom: widget.addMargin ? 10 : 0),
                width: _bottomBannerAd.size.width.toDouble(),
                height: _bottomBannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bottomBannerAd),
              )
            : Container(
                height: 0,
              )
        : Container(
            height: 0,
          );
  }
}
