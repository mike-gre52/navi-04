import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

class ViewRestaurant extends StatefulWidget {
  const ViewRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewRestaurant> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurant> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  final data = Get.arguments as List;
  late Restaurant restaurant;
  late Function onSubmit;

  bool doesDelivery = false;
  int rating = 1;
  int price = 1;
  String restaurantUrl = "";

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
    print("in set delivery status");
    print(doesDelivery);
  }

  void setPriceStatus(value) {
    print(value);
    setState(() {
      price = value;
    });
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  addUrl(String url) {
    setState(() {
      restaurantUrl = url;
    });
  }

  @override
  void initState() {
    restaurant = data[0];
    onSubmit = data[1];
    if (restaurant.name != null) {
      _nameController.text = restaurant.name!;
    }
    if (restaurant.time != null) {
      _timeController.text = restaurant.time.toString();
    }
    if (restaurant.rating != null) {
      rating = restaurant.rating!;
    }
    if (restaurant.price != null) {
      setPriceStatus(restaurant.price);
    }
    if (restaurant.restaurantUrl != null) {
      restaurantUrl = restaurant.restaurantUrl!;
    }
    if (restaurant.doesDelivery != null) {
      doesDelivery = restaurant.doesDelivery!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    double height65 = screenHeight / 13.784;
    double width5 = screenWidth / 82.8;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.14;
    double width350 = screenWidth / 1.182;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            headerText: restaurant.name != null && restaurant.name != ""
                ? restaurant.name!.length <= 12
                    ? restaurant.name![0].toUpperCase() +
                        restaurant.name!.substring(1)
                    : "${restaurant.name![0].toUpperCase()}${restaurant.name!.substring(1, 12)}..."
                : "",
            headerColor: appRed,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: Text(
              'Cancel',
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
            margin: EdgeInsets.only(left: width30, top: height30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: width5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: fontSize18,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: CustomTextfield(
                    icon: Icons.person,
                    placeholderText: '',
                    controller: _nameController,
                    borderColor: appRed,
                    showIcon: false,
                    textfieldWidth: width350,
                    textfieldHeight: height65,
                    borderRadius: height10,
                    onSubmit: (_) {},
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSingleTextfieldAndSubmitScreen(),
                  arguments: [
                    appRed,
                    "Paste a Url below:",
                    addUrl,
                    CupertinoIcons.link
                  ]);
            },
            child: Container(
              margin: EdgeInsets.only(left: width30, top: 5),
              child: Text(
                restaurantUrl.trim() == "" ? "Add Url" : "Change Url",
                style: TextStyle(color: appRed, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5, top: height30),
                      child: Text(
                        'Time',
                        style: TextStyle(
                          fontSize: fontSize18,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      child: CustomTextfield(
                        icon: Icons.timer,
                        placeholderText: '',
                        controller: _timeController,
                        borderColor: appRed,
                        textfieldWidth: width100,
                        showIcon: false,
                        textfieldHeight: height50,
                        borderRadius: height10,
                        onSubmit: (_) {},
                        onChanged: (_) {},
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5, top: height30),
                      child: Text(
                        'Rating',
                        style: TextStyle(
                          fontSize: fontSize18,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SelectRating(
                      rating: rating,
                      onTap: newRatingSelected,
                      isTapable: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5, top: height30),
                      child: Text(
                        'Price',
                        style: TextStyle(
                          fontSize: fontSize18,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    PriceSegmentedControll(
                      setPriceStatus: setPriceStatus,
                      initialValue: price,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5, top: height30),
                      child: Text(
                        'Delivery',
                        style: TextStyle(
                            fontSize: fontSize18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    DeliverySegmentedControll(
                      setDeliveryStatus: setDeliveryStatus,
                      initialValue: restaurant.doesDelivery != null
                          ? restaurant.doesDelivery!
                              ? 0
                              : 1
                          : 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height30),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                Restaurant updatedRestaurant = Restaurant(
                  name: _nameController.text,
                  time: int.parse(_timeController.text),
                  rating: rating,
                  price: price,
                  doesDelivery: doesDelivery,
                  isFavorite: restaurant.isFavorite,
                  id: restaurant.id,
                  restaurantUrl: restaurantUrl,
                  orders: restaurant.orders,
                );

                await restaurantController.updateRestaurant(updatedRestaurant);
                Navigator.pop(context);
                onSubmit(updatedRestaurant);
              },
              child: Container(
                height: height60,
                width: width100,
                margin: EdgeInsets.only(
                  top: height30,
                ),
                decoration: BoxDecoration(
                  color: appRed,
                  borderRadius: BorderRadius.circular(height15),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontSize: fontSize18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
