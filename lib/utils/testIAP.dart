import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';

class SettingsScreenTest extends StatefulWidget {
  static const routeName = '/SettingsScreen';

  const SettingsScreenTest({Key? key}) : super(key: key);

  @override
  State<SettingsScreenTest> createState() => _SettingsScreenTestState();
}

class _SettingsScreenTestState extends State<SettingsScreenTest> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBanerAdLoaded = false;
  String purchaseLog = 'no purchase';
  bool shouldDisplayPopup = false;
  var shoudlDispose = true;
  bool isPurchasePending = false;

  //final List<String> _productLists = ['com.mikeg.badDateBailOutApp.RemoveAds'];

  void _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) {
    print("beginning _listenToPurchaseUpdated");
    print(purchaseDetailsList);
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        var pStatus = await purchaseDetails.status;
        // setState(() {
        //   purchaseLog = pStatus.toString();
        // });
        print("pStatus: $pStatus");
        if (purchaseDetails.status == PurchaseStatus.canceled) {
          isPurchasePending = false;
          showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                    title: const Text('Oh No!'),
                    content: const Text('The purchase was canceled'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
        }
        if (purchaseDetails.status == PurchaseStatus.pending) {
          isPurchasePending = true;
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            // _handleError(purchaseDetails.error!);
            await _inAppPurchase.completePurchase(purchaseDetails);

            showDialog(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                      title: const Text('Error'),
                      content:
                          const Text('There was an error with your purchase'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ));
          } else if (purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) {
            isPurchasePending = false;

            if (purchaseDetails.status == PurchaseStatus.restored) {
              setState(() {
                shouldDisplayPopup = true;

                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          title: const Text('Success'),
                          content: const Text(
                              'Success. Your Purchase has been restored.'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
              });
            }

            await _inAppPurchase.completePurchase(purchaseDetails);
          }
        }
        //print('test print ----:${purchaseDetails}');
        //purchaseDetails.status = purchaseDetails.status;
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        // await _inAppPurchase.completePurchase(purchaseDetails);
        //}
      },
    );
  }

  void _restorePurchase() async {
    await InAppPurchase.instance.restorePurchases();
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<List<ProductDetails>> _getProductsFunc(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);
    // print(response);
    products = response.productDetails;
    print(response.productDetails);
    return response.productDetails;
  }

  List<ProductDetails> products = [];
  late StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    super.initState();

    shoudlDispose = false;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _getProductsFunc(productIds: {'navi_4_premium_IAP'});
      final Stream purchaseUpdated = _inAppPurchase.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(
          purchaseDetailsList,
        );
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
      print(purchaseUpdated);
      //initPlatformState();
    });
  }

  void _buyInAppPurchase({required ProductDetails product}) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    if (shoudlDispose) {
      print('disposed ad');
      _bottomBannerAd.dispose();
    }
    super.dispose();
  }

  final appURL = 'https://apps.apple.com/us/app/bad-date-bail-out/id1611815991';
  @override
  Widget build(BuildContext context) {
    /*
    if (shouldDisplayPopup) {
                          showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: const Text('Success'),
                        content: const Text(
                            'Success. Your Purchase has been restored.'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              print('pop');
                            },
                          ),
                        ],
                      ),
                      barrierDismissible: true,
                    );
      shouldDisplayPopup = false;
    }

    */

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    var height10 = height / 89.6;

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Center(
            child: Column(
              children: <Widget>[
                /*
                Padding(
                  padding: EdgeInsets.only(
                    left: height * 0.04,
                    right: height * 0.04,
                    bottom: height * 0.01,
                  ),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      'Account Level: ${phoneData.removeAdsPurchased ? 'Ad Free' : 'With Ads'}',
                      style: TextStyle(
                        fontSize: height10 * 2,
                        color: darkBlue,
                      ),
                    ),
                  ),
                ),
                */
                SizedBox(height: height10 * 1.5),
                Padding(
                  padding: EdgeInsets.only(
                    left: height * 0.04,
                    right: height * 0.04,
                  ),
                  child: Container(
                    height: height * 0.075,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: CupertinoButton(
                      child: const Center(
                        child: Text(
                          'Remove Ads',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      onPressed: () {
                        _buyInAppPurchase(product: products[0]);
                        setState(() {
                          //rebuild screen
                        });
                        //_requestPurchase(_items[0]);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: height * 0.04,
                    right: height * 0.04,
                    bottom: height * 0.01,
                  ),
                  //color: Colors.amber,
                  child: Container(
                    width: double.infinity,
                    //color: Colors.redAccent,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Already Paid? Click Here',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: height10 * 1.75,
                        ),
                      ),
                      onPressed: () {
                        _restorePurchase();

                        //_getPurchaseHistory();
                      },
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                isPurchasePending
                    ? Container(
                        height: height * 0.2,
                        child:
                            const Center(child: (CupertinoActivityIndicator())),
                      )
                    : SizedBox(
                        height: height * 0.2,
                      ),
                CupertinoButton(
                  child: Container(
                    height: height * 0.2,
                    width: width * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Center(
                              child: Icon(
                            CupertinoIcons.share,
                            size: 30,
                            color: Colors.blueGrey,
                          )),
                          Text(
                            'Share',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () {
                    Share.share('$appURL \n Download Bad Date Bail for Free!');
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: const Text(
                    'Enjoying the app? Rate Here.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    LaunchReview.launch(iOSAppId: "1611815991");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
