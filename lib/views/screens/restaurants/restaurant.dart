import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/utils/helper.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/banner_ad_widget.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/order_cell.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/restaurant_bottom_popup.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

import '../../widgets/lists/list_bottom_popup.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Restaurant restaurant = Get.arguments as Restaurant;

  bool doesDelivery = false;
  int rating = 1;
  int price = -1;

  Object _selectedSegment = 0;

  void setDeliveryStatus(value) {
    if (value == 0) {
      doesDelivery = true;
    } else {
      doesDelivery = false;
    }
  }

  void setPriceStatus(value) {
    setState(() {
      price = value;
    });
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  onUpdateRestaurant(Restaurant newRestaurant) {
    setState(() {
      restaurant = newRestaurant;
    });
  }

  @override
  void initState() {
    setDeliveryStatus(restaurant.doesDelivery);
    if (restaurant.price != null) {
      setPriceStatus(restaurant.price);
    }

    super.initState();
  }

  Widget buildOrderCell(String order) {
    return OrderCell(
      restaurant: restaurant,
      order: order,
      onSubmit: reloadAfterOrderAdded,
    );
  }

  reloadAfterOrderAdded() {
    setState(() {});
  }

  addUrl(String url) {
    restaurantController.updateRestaurantUrl(restaurant.id!, url);
    setState(() {
      restaurant.restaurantUrl = url;
    });
  }

  addPhoneNumber(String phoneNumber) {
    phoneNumber = stripPhoneNumber(phoneNumber);
    if (validatePhoneNumber(phoneNumber)) {
      restaurantController.updateRestaurantPhoneNumber(
          restaurant.id!, phoneNumber);
      setState(() {
        restaurant.phoneNumber = phoneNumber;
      });
    } else {
      //ignore number
    }
  }

  void callRestaurant() async {
    final Uri phoneNumberURI = Uri(
      scheme: 'tel',
      path: restaurant.phoneNumber,
    );
    if (await canLaunchUrl(phoneNumberURI)) {
      launchUrl(phoneNumberURI);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double screenWidth75 = screenWidth * .75;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height20 = screenHeight / 44.8;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height35 = screenHeight / 25.6;
    double height385 = screenHeight / 2.327;
    double height450 = screenHeight / 1.991;
    double width5 = screenWidth / 82.8;
    double width10 = screenWidth / 41.4;
    double width25 = screenWidth / 16.56;
    double width30 = screenWidth / 13.8;
    double fontSize14 = screenHeight / 64;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize24 = screenHeight / 37.333;
    double fontSize28 = screenHeight / 32;
    double fontSize40 = screenHeight / 22.4;

    double iconSize20 = screenHeight / 44.8;

    return Scaffold(
      bottomNavigationBar: BannerAdWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            headerText: "Restaurants",
            headerColor: appRed,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: Row(
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
                      builder: (context) => RestaurantBottomPopup(
                        restaurant: restaurant,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: height35,
                  ),
                ),
                SizedBox(width: height10),
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
          //NEED TO MAKE SURE TIME IS A NUMBER - WILL SET THE KEYBOARD TO NUMPAD BUT STILL NEED TO VERIFY
          Container(
            margin:
                EdgeInsets.only(left: width25, top: height30, right: width25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth75),
                      child: Text(
                        restaurant.name != null && restaurant.name != ""
                            ? restaurant.name!.substring(0, 1).toUpperCase() +
                                restaurant.name!.substring(1)
                            : "Add Name",
                        maxLines: 2,
                        style: TextStyle(
                          color: black,
                          fontSize: fontSize40,
                          height: 1.1,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: width10),
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getViewRestaurants(),
                              arguments: [restaurant, onUpdateRestaurant]);
                        },
                        child: Icon(
                          Icons.edit_note_rounded,
                          size: height25,
                          color: darkGrey,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    restaurant.restaurantUrl != null &&
                            restaurant.restaurantUrl != ""
                        ? GestureDetector(
                            onTap: () {
                              searchUrl(restaurant.restaurantUrl!);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width5),
                              child: Row(
                                children: [
                                  Text(
                                    "Website",
                                    style: TextStyle(
                                      fontSize: fontSize18,
                                      color: darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: width5),
                                  Icon(
                                    CupertinoIcons.globe,
                                    color: darkGrey,
                                    size: iconSize20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper
                                      .getSingleTextfieldAndSubmitScreen(),
                                  arguments: [
                                    appRed,
                                    "Paste a Url below:",
                                    addUrl,
                                    CupertinoIcons.link
                                  ]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width5),
                              child: Text(
                                "add url",
                                style: TextStyle(
                                  fontSize: fontSize14,
                                  color: darkGrey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                    SizedBox(width: width25),
                    restaurant.phoneNumber != null &&
                            restaurant.phoneNumber != ""
                        ? GestureDetector(
                            onTap: () {
                              callRestaurant();
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width5),
                              child: Row(
                                children: [
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                      fontSize: fontSize18,
                                      color: darkGrey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: width5),
                                  Icon(
                                    Icons.call,
                                    color: darkGrey,
                                    size: iconSize20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper
                                      .getSingleTextfieldAndSubmitScreen(),
                                  arguments: [
                                    appRed,
                                    "Add a Phone Number",
                                    addPhoneNumber,
                                    CupertinoIcons.link,
                                    TextInputType.phone,
                                  ]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width5),
                              child: Text(
                                "add phone number",
                                style: TextStyle(
                                    fontSize: fontSize14,
                                    color: darkGrey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: height5),
                SelectRating(
                  rating: restaurant.rating != null ? restaurant.rating! : 1,
                  onTap: newRatingSelected,
                  isTapable: false,
                ),

                restaurant.time != null
                    ? Container(
                        margin: EdgeInsets.only(top: height5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: height30,
                            ),
                            SizedBox(width: width10),
                            Text(
                              restaurant.time.toString() + " min",
                              style: TextStyle(
                                  fontSize: fontSize18,
                                  color: black,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: width10),
                          ],
                        ),
                      )
                    : Container(),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5),
                      child: Text(
                        restaurant.price == 1
                            ? '\$'
                            : restaurant.price == 2
                                ? '\$\$'
                                : restaurant.price == 3
                                    ? '\$\$\$'
                                    : '',
                        style: TextStyle(
                          fontSize: fontSize24,
                          fontWeight: FontWeight.w800,
                          color: appRed,
                        ),
                      ),
                    ),
                    restaurant.doesDelivery != null && restaurant.price != null
                        ? SizedBox(width: width30)
                        : Container(),
                    restaurant.doesDelivery != null
                        ? restaurant.doesDelivery!
                            ? Icon(
                                Icons.delivery_dining_outlined,
                                size: height30,
                                color: green,
                              )
                            : Container()
                        : Container(),
                  ],
                ),
                SizedBox(height: height30),
                //Orders
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favorite Dishes",
                      style: TextStyle(
                        fontSize: fontSize28,
                        color: black,
                        height: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getAddOrderScreen(),
                            arguments: [
                              restaurant,
                              reloadAfterOrderAdded,
                              "",
                              false,
                            ]);
                      },
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        size: height25,
                      ),
                    )
                  ],
                ),
                SizedBox(height: height5),
                SingleChildScrollView(
                  child: Container(
                    //color: Colors.amberAccent,
                    width: double.maxFinite,
                    height: height385,
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.orders != null
                          ? restaurant.orders!.map(buildOrderCell).toList()
                          : [],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
