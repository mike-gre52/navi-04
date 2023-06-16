import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class PremiumUpgradeScreen extends StatefulWidget {
  const PremiumUpgradeScreen({super.key});

  @override
  State<PremiumUpgradeScreen> createState() => _PremiumUpgradeScreenState();
}

class _PremiumUpgradeScreenState extends State<PremiumUpgradeScreen> {
  String purchaseLog = 'no purchase';
  bool shouldDisplayPopup = false;
  var shoudlDispose = true;
  bool isPurchasePending = false;
  List<ProductDetails> products = [];
  late StreamSubscription<dynamic> _subscription;
  String debugString = "";

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  void _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) {
    print("beginning _listenTOPurchaseUpdated");
    print(purchaseDetailsList);

    //
    //
    debugString += "          purchaseDetailsList: $purchaseDetailsList";
    uUI();
    //
    //

    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        var pStatus = await purchaseDetails.status;
        print("pStatus: $pStatus");

        //
        //
        debugString += "          pStatus: $pStatus";
        uUI();
        //
        //

        //setState(() {
        //  purchaseLog = pStatus.toString();
        //});
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
            //await _inAppPurchase.completePurchase(purchaseDetails);
            print("error in purchaseDetails: $purchaseDetails.error");
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

            //Update Firebase to set as premium user
            //userController.premiumIAPPurchased();
            //will have to update UI

            if (purchaseDetails.status == PurchaseStatus.restored) {
              //Update Firebase to set as premium user
              //userController.premiumIAPPurchased();
              //will have to update UI

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
            print("before complete");
            await _inAppPurchase.completePurchase(purchaseDetails);
            print("after complete");
          }
        }
        //print('test print ----:${purchaseDetails}');
        //purchaseDetails.status = purchaseDetails.status;
        if (purchaseDetails.pendingCompletePurchase) {
          print("purchaseDetails.pendingCompletePurchase");
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        print("right before last complete Purchase");
        //await _inAppPurchase.completePurchase(purchaseDetails);
        //}
      },
    );
  }

  void _buyInAppPurchase({required ProductDetails product}) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  void _restorePurchase() async {
    setState(() {
      isPurchasePending = true;
    });

    await InAppPurchase.instance.restorePurchases();
    setState(() {
      isPurchasePending = false;
    });
  }

  void uUI() {
    setState(() {});
  }

  Future<List<ProductDetails>> _getProductsFunc(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);
    print(response.productDetails);
    products = response.productDetails;
    return response.productDetails;
  }

  @override
  void initState() {
    super.initState();
    print("init state");
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

    //initPlatformState();
  }

  @override
  dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.866;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double width30 = screenWidth / 13.8;
    double width300 = screenWidth / 1.38;
    double fontSize15 = screenHeight / 59.733;
    double fontSize18 = screenHeight / 49.777;
    double fontSize25 = screenHeight / 35.84;
    double fontSize35 = screenHeight / 25.6;
    double premiumPrice = 1.99;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close_rounded,
                      size: height30,
                    ),
                  ),
                ),
                SizedBox(height: height25),
                Align(
                  alignment: Alignment.center,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [royalYellow, lightYellow],
                    ).createShader(bounds),
                    child: Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: height40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height25),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width30),
                  child: Column(
                    children: [
                      IAPFeature(feature: "Remove Ads"),
                      IAPFeature(feature: "Add photos to list items"),
                      IAPFeature(feature: "Unlimted Group Members"),
                      IAPFeature(feature: "Unlimted Recipe Imports"),
                    ],
                  ),
                ),
                SizedBox(height: height40),
                isPurchasePending
                    ? Container(
                        height: height15,
                        child: CupertinoActivityIndicator(
                          radius: height15,
                          color: royalYellow,
                        ),
                      )
                    : SizedBox(
                        height: height15,
                      ),
                SizedBox(height: height20),
                Text(
                  "Only \$$premiumPrice",
                  style: TextStyle(
                    fontSize: fontSize15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height5),
                GestureDetector(
                  onTap: () {
                    //
                    _buyInAppPurchase(product: products[0]);
                  },
                  child: Container(
                    height: height50,
                    width: width300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: const [0, 1],
                        colors: [royalYellow, lightYellow],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.amber,
                    ),
                    child: Center(
                      child: Text(
                        "Upgrade",
                        style: TextStyle(
                          fontSize: fontSize25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height10),
                GestureDetector(
                  onTap: () {
                    _restorePurchase();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Alrady Paid?',
                          style: TextStyle(
                            fontSize: fontSize18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: ' Restore Purchase',
                          style: TextStyle(
                            fontSize: fontSize18,
                            fontWeight: FontWeight.w400,
                            color: royalYellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(debugString),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IAPFeature extends StatelessWidget {
  String feature;
  IAPFeature({required this.feature, super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height2 = screenHeight / 448;
    double height12 = screenHeight / 74.667;
    double width10 = screenHeight / 41.4;
    double fontSize18 = screenHeight / 49.777;

    return Container(
      child: Row(
        children: [
          Container(
            height: height12,
            width: height12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height2),
              color: lightYellow,
            ),
          ),
          SizedBox(width: width10),
          Text(
            feature,
            style: TextStyle(color: black, fontSize: fontSize18),
          ),
        ],
      ),
    );
  }
}
