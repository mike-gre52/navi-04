import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/filter.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

class FilterRestaurantScreens extends StatefulWidget {
  const FilterRestaurantScreens({Key? key}) : super(key: key);

  @override
  State<FilterRestaurantScreens> createState() =>
      _FilterRestaurantScreensState();
}

class _FilterRestaurantScreensState extends State<FilterRestaurantScreens> {
  TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timeController.dispose();
  }

  List data = Get.arguments as List;

  late bool onlyDelivery;
  late bool onlyFavorite;
  late int rating;
  late Filter filter;
  late Function setFilterState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filter = data[0] as Filter;
    setFilterState = data[1] as Function;
    onlyDelivery = filter.onlyDelivery;
    onlyFavorite = filter.onlyFavorite;
    rating = filter.minRating;
  }

  //int rating = 1;
  int price = 3;

  void setDeliveryStatus(value) {
    if (value == 0) {
      onlyDelivery = true;
    } else {
      onlyDelivery = false;
    }
  }

  void setPriceStatus(value) {
    price = value;
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height40 = screenHeight / 22.4;
    double width5 = screenWidth / 82.8;
    double width15 = screenWidth / 27.6;
    double width30 = screenWidth / 13.8;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            headerText: 'Filter',
            headerColor: Colors.white,
            borderColor: appRed,
            textColor: black,
            dividerColor: appRed,
            rightAction: Text(
              'Done',
              style: TextStyle(
                color: black,
                fontSize: fontSize20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              int maxTime;
              bool useTime;
              if (_timeController.text == '') {
                maxTime = 0;
                useTime = false;
              } else {
                maxTime = int.parse(_timeController.text);
                useTime = true;
              }

              final filter = Filter(
                maxTime: maxTime,
                minRating: rating,
                maxPrice: price,
                onlyDelivery: onlyDelivery,
                onlyFavorite: onlyFavorite,
                useFilter: true,
                useTime: useTime,
              );
              restaurantController.setfilter(filter);
              Navigator.pop(context);
              setFilterState(filter);
            },
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
                        'Max Price?',
                        style: TextStyle(
                            fontSize: fontSize18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    PriceSegmentedControll(
                      setPriceStatus: setPriceStatus,
                      initialValue: filter.maxPrice,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width5, top: height30),
                      child: Text(
                        'Only Delivery?',
                        style: TextStyle(
                            fontSize: fontSize18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    DeliverySegmentedControll(
                      setDeliveryStatus: setDeliveryStatus,
                      initialValue: onlyDelivery ? 0 : 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width5, top: height30),
                                  child: Text(
                                    'Min Rating',
                                    style: TextStyle(
                                      fontSize: fontSize18,
                                      color: black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SelectRating(
                            rating: rating,
                            onTap: newRatingSelected,
                            isTapable: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width30, top: height20),
                      child: Text(
                        'Favorite',
                        style: TextStyle(
                            fontSize: fontSize18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          onlyFavorite = !onlyFavorite;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: width15, top: height20),
                        child: Icon(
                          onlyFavorite
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: height40,
                          color: appRed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
