//import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAP extends StatefulWidget {
  const IAP({super.key});

  @override
  State<IAP> createState() => _IAPState();
}

class _IAPState extends State<IAP> {
  @override
  String purchaseLog = 'no purchase';
  bool shouldDisplayPopup = false;
  var shoudlDispose = true;
  bool isPurchasePending = false;

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  void _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        var pStatus = await purchaseDetails.status;
        setState(() {
          purchaseLog = pStatus.toString();
        });
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
          print("PurchaseStatus.pending");
          isPurchasePending = true;
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            print("PurchaseStatus.error");
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

            //phoneData.boughtInAppPurchase();
            if (purchaseDetails.status == PurchaseStatus.restored) {
              print("PurchaseStatus.restored");
              //phoneData.boughtInAppPurchase();
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
          print("purchaseDetails.pendingCompletePurchase");
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        await _inAppPurchase.completePurchase(purchaseDetails);
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
    await InAppPurchase.instance.restorePurchases();
  }

  Future<List<ProductDetails>> _getProductsFunc(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);
    // print(response);
    products = response.productDetails;
    return response.productDetails;
  }

  List<ProductDetails> products = [];
  late StreamSubscription<dynamic> _subscription;
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
