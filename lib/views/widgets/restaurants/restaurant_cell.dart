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
          margin: const EdgeInsets.only(left: 30, top: 10, bottom: 0, right: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          restaurant.name.substring(0, 1).toUpperCase() +
                              restaurant.name.substring(1),
                          maxLines: 2,
                          style: TextStyle(
                            height: 0.95,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    /*
                    Wrap(
                      children: List.generate(
                        restaurant.rating,
                        (index) => const Icon(
                          Icons.star_rounded,
                          size: 20,
                          color: Color.fromRGBO(255, 193, 7, 1.0),
                        ),
                      ),
                    ),
                    
                    Text(
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
                    */
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),

              /*
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          restaurant.doesDelivery
                              ? Icons.check_circle_outline
                              : Icons.remove_circle_outline,
                          size: 35,
                          color: restaurant.doesDelivery ? green : red,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 35,
                          color: royalYellow,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${restaurant.time} min',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              */
              const SizedBox(width: 15),
              Expanded(child: Container()),
              Row(
                children: [
                  showCost
                      ? Text(
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
                        )
                      : Container(),
                  showTime
                      ? Container(
                          margin: EdgeInsets.only(left: 0, top: 5),
                          child: Row(
                            children: [
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
                        )
                      : Container(),
                  const SizedBox(width: 15),
                  Transform.translate(
                    offset: Offset(0, -5),
                    child: GestureDetector(
                      onTap: () {
                        //
                        restaurantController.toggleRestaurantFavorite(
                            restaurant.id, restaurant.isFavorite);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
