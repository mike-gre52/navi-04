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
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/order_cell.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  Restaurant restaurant = Get.arguments as Restaurant;

  bool doesDelivery = false;
  int rating = 1;
  int price = 3;

  Object _selectedSegment = 0;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _notesController.dispose();
  }

  void setDeliveryStatus(value) {
    if (value == 0) {
      doesDelivery = true;
    } else {
      doesDelivery = false;
    }
  }

  void setPriceStatus(value) {
    price = value;
    print(price);
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  onUpdateRestaurant(Restaurant newRestaurant) {
    setState(() {
      print(restaurant.rating);
      print(newRestaurant.rating);
      restaurant = newRestaurant;
      print(restaurant.rating);
    });
  }

  @override
  void initState() {
    _nameController.text = restaurant.name;
    _timeController.text = restaurant.time.toString();
    setDeliveryStatus(restaurant.doesDelivery);
    setPriceStatus(restaurant.price);
    super.initState();
  }

  Widget buildOrderCell(Order order) {
    return OrderCell(
      restaurant: restaurant,
      order: order,
      onSubmit: reloadAfterOrderAdded,
    );
  }

  reloadAfterOrderAdded() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double screenWidth75 = screenWidth * .75;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    double height65 = screenHeight / 13.784;
    double height200 = screenHeight / 4.48;
    double height250 = screenHeight / 3.584;
    double fontSize35 = screenHeight / 25.6;
    double height205 = screenHeight / 4.3707;
    double height450 = screenHeight / 1.991;
    double width5 = screenWidth / 82.8;
    double width10 = screenWidth / 41.4;
    double width15 = screenWidth / 27.6;
    double width25 = screenWidth / 16.56;
    double width30 = screenWidth / 13.8;
    double width80 = screenWidth / 5.175;
    double width100 = screenWidth / 4.14;
    double width200 = screenWidth / 2.07;
    double width350 = screenWidth / 1.182;
    double fontSize14 = screenHeight / 64;
    double fontSize16 = screenHeight / 56;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    double fontSize22 = screenHeight / 40.727;
    double fontSize24 = screenHeight / 37.333;
    double fontSize28 = screenHeight / 32;
    double fontSize40 = screenHeight / 22.4;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            headerText: "Restaurants",
            headerColor: appRed,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize20,
                fontWeight: FontWeight.w600,
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth75),
                      child: Text(
                        restaurant.name.substring(0, 1).toUpperCase() +
                            restaurant.name.substring(1),
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
                restaurant.restaurantUrl != ""
                    ? GestureDetector(
                        onTap: () {
                          searchUrl(restaurant.restaurantUrl);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width5),
                          child: Text(
                            trimSourceUrl(restaurant.restaurantUrl),
                            style: TextStyle(
                                fontSize: fontSize18,
                                color: darkGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : Container(),
                SelectRating(
                  rating: restaurant.rating,
                  onTap: newRatingSelected,
                  isTapable: false,
                ),
                Container(
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
                ),
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
                                    : '\$\$\$',
                        style: TextStyle(
                          fontSize: fontSize24,
                          fontWeight: FontWeight.w800,
                          color: appRed,
                        ),
                      ),
                    ),
                    SizedBox(width: width30),
                    restaurant.doesDelivery
                        ? Icon(
                            Icons.delivery_dining_outlined,
                            size: height30,
                            color: green,
                          )
                        : Container(),
                  ],
                ),
                SizedBox(height: height30),
                //Orders
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Orders",
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
                              Order(name: "", item: ""),
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
                    width: double.maxFinite,
                    height: height450,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: restaurant.orders.map(buildOrderCell).toList(),
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
