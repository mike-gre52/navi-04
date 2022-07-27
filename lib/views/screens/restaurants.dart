import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app_header.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/restaurant_cell.dart';
import '../../controllers/restaurant_controller.dart';

import '../../models/user.dart';

class ResturantsScreen extends StatelessWidget {
  const ResturantsScreen({Key? key}) : super(key: key);

  Widget buildRestaurantTile(Restaurant restaurant) => RestaurantCell(
        name: restaurant.name,
        rating: restaurant.rating,
        price: restaurant.price,
        doesDelivery: restaurant.doesDelivery,
        time: restaurant.time,
        isFavorite: restaurant.isFavorite,
      );

  void addRestaurantIconButton() {
    Get.toNamed(RouteHelper.getAddRestaurantRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Restaurant>>(
        stream: restaurantController.getRestuarants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurants = snapshot.data!;
            restaurants.shuffle();
            restaurants.shuffle();
            return Column(
              children: [
                AppHeader(
                  headerText: 'Restaurants',
                  headerColor: appRed,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: const Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  onIconClick: addRestaurantIconButton,
                ),
                Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lightGrey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(),
                  height: 600, // need to calculate available space
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: restaurants.map(buildRestaurantTile).toList(),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
