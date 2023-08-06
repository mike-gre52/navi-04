import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';

class RestaurantCell extends StatelessWidget {
  Restaurant restaurant;
  bool showTime;
  bool showCost;
  RestaurantCell({
    required this.restaurant,
    required this.showTime,
    required this.showCost,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double screenHeight = mediaQuery.size.height;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height35 = screenHeight / 25.6;
    double height60 = screenHeight / 14.933;
    double width5 = screenWidth / 82.8;
    double width10 = screenWidth / 41.4;
    double width40 = screenWidth / 10.35;
    double width75 = screenWidth / 5.52;
    double width110 = screenWidth / 3.7636;
    double width235 = screenWidth / 1.7617;
    double width275 = screenWidth / 1.505;
    double width380 = screenWidth / 1.0894;
    double fontSize16 = screenHeight / 56;
    double fontSize20 = screenHeight / 44.8;
    double fontSize30 = screenHeight / 29.866;

    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getRestaurant(), arguments: restaurant);
      },
      child: Container(
        margin: EdgeInsets.only(
            top: height5, left: width10, right: width10, bottom: height5),
        height: height60,
        width: width380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 176, 176, 176),
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: width10,
            top: height10,
            bottom: height10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  //
                  if (restaurant.isFavorite != null) {
                    restaurantController.toggleRestaurantFavorite(
                        restaurant.id!, restaurant.isFavorite!);
                  } else {
                    restaurantController.toggleRestaurantFavorite(
                        restaurant.id!, false);
                  }
                },
                child: Container(
                  width: width40,
                  //margin: EdgeInsets.only(right: 10),
                  child: restaurant.isFavorite != null
                      ? restaurant.isFavorite!
                          ? Icon(
                              Icons.star_rounded,
                              size: height35,
                              color: appRed,
                            )
                          : Icon(
                              Icons.star_outline_rounded,
                              size: height35,
                              color: appRed,
                            )
                      : Icon(
                          Icons.star_outline_rounded,
                          size: height35,
                          color: appRed,
                        ),
                ),
              ),
              Container(
                width: width235,
                child: Text(
                  restaurant.name != null && restaurant.name != ""
                      ? restaurant.name!.substring(0, 1).toUpperCase() +
                          restaurant.name!.substring(1)
                      : "",
                  //maxLines: 2,
                  style: TextStyle(
                    //height: 1,
                    fontSize: fontSize30,
                    fontWeight: FontWeight.w700,
                    color: black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                width: width75,
                margin: EdgeInsets.only(right: width5),
                child: showCost
                    ? Container(
                        width: width75,
                        child: Center(
                          child: Text(
                            restaurant.price == 1
                                ? '\$'
                                : restaurant.price == 2
                                    ? '\$\$'
                                    : restaurant.price == 3
                                        ? '\$\$\$'
                                        : '\$\$\$',
                            style: TextStyle(
                              fontSize: fontSize20,
                              fontWeight: FontWeight.w800,
                              color: appRed,
                            ),
                          ),
                        ),
                      )
                    : showTime
                        ? Container(
                            width: width75,
                            child: Center(
                              child: Text(
                                restaurant.time.toString() + " min",
                                style: TextStyle(
                                    fontSize: fontSize16,
                                    color: black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Container(),
                //const SizedBox(width: 15),
                //Star
                /*
                    GestureDetector(
                      onTap: () {
                        //
                        restaurantController.toggleRestaurantFavorite(
                            restaurant.id, restaurant.isFavorite);
                      },
                      child: Container(
                        //margin: EdgeInsets.only(right: 10),
                        child: restaurant.isFavorite
                            ? Icon(
                                Icons.star_rounded,
                                size: height35,
                                color: appRed,
                              )
                            : Icon(
                                Icons.star_outline_rounded,
                                size: height35,
                                color: appRed,
                              ),
                      ),
                    ),
                    */
              )
            ],
          ),
        ),
      ),
    );
  }
}
