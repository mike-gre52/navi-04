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
  RestaurantCell({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.viewRestaurant, arguments: restaurant);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        height: 110,
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant.name,
                      maxLines: 2,
                      style: TextStyle(
                        height: 0.95,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
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
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  //
                  restaurantController.toggleRestaurantFavorite(
                      restaurant.id, restaurant.isFavorite);
                },
                child: Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
