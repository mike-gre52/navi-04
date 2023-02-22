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
    double screenWidth75 = screenWidth * .75;
    print("build");
    //set data
    print(restaurant.rating);
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
            rightAction: const Text(
              'Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              Navigator.pop(context);
            },
          ),
          //NEED TO MAKE SURE TIME IS A NUMBER - WILL SET THE KEYBOARD TO NUMPAD BUT STILL NEED TO VERIFY
          Container(
            margin: const EdgeInsets.only(left: 25, top: 30, right: 25),
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
                          fontSize: 45,
                          height: 1,
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Align(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getViewRestaurants(),
                              arguments: [restaurant, onUpdateRestaurant]);
                        },
                        child: Icon(
                          Icons.edit_note_rounded,
                          size: 26,
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
                          margin: const EdgeInsets.only(left: 5),
                          child: Text(
                            trimSourceUrl(restaurant.restaurantUrl),
                            style: TextStyle(
                                fontSize: 18,
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
                  margin: EdgeInsets.only(left: 0, top: 5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        restaurant.time.toString() + " min",
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 0),
                      child: Text(
                        restaurant.price == 1
                            ? '\$'
                            : restaurant.price == 2
                                ? '\$\$'
                                : restaurant.price == 3
                                    ? '\$\$\$'
                                    : '\$\$\$',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: appRed,
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    restaurant.doesDelivery
                        ? Icon(
                            Icons.delivery_dining_outlined,
                            size: 30,
                            color: green,
                          )
                        : Container(),
                  ],
                ),
                SizedBox(height: 30),
                //Orders
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Orders",
                      style: TextStyle(
                        fontSize: 28,
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
                      child: const Icon(
                        Icons.add_circle_outline_rounded,
                        size: 26,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    height: 450,
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
