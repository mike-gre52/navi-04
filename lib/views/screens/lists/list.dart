import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/ad_helper.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_bottom_popup.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_column.dart';

import '../../widgets/app/app_header.dart';
import '../../widgets/lists/list_item.dart';

class ListScreen extends StatefulWidget {
  ListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController _itemController = TextEditingController();

  final list = Get.arguments as ListData;

  addItem() {
    if (_itemController.text.trim() != "") {
      listController.addListItem(
        _itemController.text,
        list.id!,
      );
      _itemController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _createBottomBannerAd();
    });
  }

  late BannerAd _bottomBannerAd;
  bool _isBottomBanerAdLoaded = false;
  int numItemsChecked = 0;

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
    _itemController.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(numItemsChecked);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;

    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height35 = screenHeight / 25.6;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    double width75 = screenWidth / 5.52;
    double width275 = screenWidth / 1.505;
    double width5 = screenWidth / 82.8;
    double width15 = screenWidth / 27.6;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    return Scaffold(
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).unfocus();
        }),
        child: Column(
          children: [
            AppHeader(
              headerText: list.name != null ? list.name! : "",
              headerColor: appGreen,
              borderColor: royalYellow,
              textColor: Colors.white,
              dividerColor: Colors.white,
              rightAction: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        //isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(height20),
                          ),
                        ),
                        builder: (context) => ListBottomPopup(list: list),
                      );
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: height35,
                    ),
                  ),
                  SizedBox(width: width5),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            Container(
              margin:
                  EdgeInsets.only(left: width15, right: width15, top: height5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextfield(
                    icon: Icons.add,
                    placeholderText: 'Add item',
                    controller: _itemController,
                    borderColor: appGreen,
                    textfieldWidth: width275,
                    textfieldHeight: height60,
                    borderRadius: height20,
                    onChanged: (_) {},
                    onSubmit: (_) {
                      addItem();
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      addItem();
                    },
                    child: Container(
                      height: height50,
                      width: width75,
                      decoration: BoxDecoration(
                        color: appGreen,
                        borderRadius: BorderRadius.circular(height20),
                      ),
                      child: Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: fontSize18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListColumn(
              list: list,
              isRecentlyDeleted: false,
            ),
          ],
        ),
      ),
    );
  }
}
