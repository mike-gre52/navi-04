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
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getRestaurant(), arguments: restaurant);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: 60,
        width: 380,
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
          margin: const EdgeInsets.only(
            left: 10,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                width: 275,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      restaurant.name.substring(0, 1).toUpperCase() +
                          restaurant.name.substring(1),
                      //maxLines: 2,
                      style: TextStyle(
                        height: 1,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 110,
                margin: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    showCost
                        ? Container(
                            width: 75,
                            child: Text(
                              restaurant.price == 1
                                  ? '\$'
                                  : restaurant.price == 2
                                      ? '\$\$'
                                      : restaurant.price == 3
                                          ? '\$\$\$'
                                          : '\$\$\$',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: appRed,
                              ),
                            ),
                          )
                        : Container(),
                    showTime
                        ? Container(
                            width: 75,
                            child: Row(
                              children: [
                                Text(
                                  restaurant.time.toString() + " min",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    //const SizedBox(width: 15),
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
                                size: 35,
                                color: appRed,
                              )
                            : Icon(
                                Icons.star_outline_rounded,
                                size: 35,
                                color: appRed,
                              ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
