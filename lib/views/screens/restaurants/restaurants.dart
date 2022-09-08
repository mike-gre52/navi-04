import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/models/filter.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/restaurant_cell.dart';
import '../../../controllers/restaurant_controller.dart';

import '../../../data/local_data.dart';
import '../../../models/user.dart';

class ResturantsScreen extends StatefulWidget {
  const ResturantsScreen({Key? key}) : super(key: key);

  @override
  State<ResturantsScreen> createState() => _ResturantsScreenState();
}

List<Restaurant> filteredRestaurants = [];

class _ResturantsScreenState extends State<ResturantsScreen> {
  Widget buildRestaurantTile(Restaurant restaurant) => RestaurantCell(
        restaurant: restaurant,
      );

  void addRestaurantIconButton() {
    Get.toNamed(RouteHelper.getAddRestaurantRoute());
  }

  bool isFavoriteSelected = false;
  bool isDeliverySelected = false;
  bool isTopRatedSelected = false;
  int sortCost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Restaurant>>(
        stream: restaurantController.getRestuarants(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurants = snapshot.data!;
            filteredRestaurants = restaurantController.filterRestaurants(
                restaurants, restaurantController.filter);
            filteredRestaurants.shuffle();
            if (sortCost == 1) {
              filteredRestaurants =
                  restaurantController.sortByPrice(filteredRestaurants, true);
            }
            if (sortCost == 2) {
              filteredRestaurants =
                  restaurantController.sortByPrice(filteredRestaurants, false);
            }
            List<CustomChip> chips = [
              CustomChip(
                chipText: '',
                chipIcon: CupertinoIcons.slider_horizontal_3,
                onClick: () {
                  Get.toNamed(RouteHelper.restaurantFilter);
                },
              ),
              CustomChip(
                chipText: 'Favorite',
                chipIcon: Icons.star_rounded,
                isSelected: isFavoriteSelected,
                onClick: () {
                  //Get.toNamed(RouteHelper.restaurantFilter);
                  setState(() {
                    if (isFavoriteSelected) {
                      isFavoriteSelected = false;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    } else {
                      isFavoriteSelected = true;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    }
                  });
                },
              ),
              CustomChip(
                chipText: 'Delivery',
                chipIcon: Icons.delivery_dining,
                isSelected: isDeliverySelected,
                onClick: () {
                  //Get.toNamed(RouteHelper.restaurantFilter);
                  setState(() {
                    if (isDeliverySelected) {
                      print(isFavoriteSelected);
                      isDeliverySelected = false;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    } else {
                      isDeliverySelected = true;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    }
                  });
                },
              ),
              CustomChip(
                chipText: 'Cost',
                chipIcon: Icons.price_change,
                isSelected: sortCost == 1 || sortCost == 2,
                onClick: () {
                  sortCost += 1;
                  if (sortCost > 2) {
                    setState(() {
                      sortCost = 0;
                    });
                  } else {
                    setState(() {
                      sortCost = sortCost;
                    });
                  }
                },
              ),
              CustomChip(
                chipText: 'Time',
                chipIcon: Icons.timer,
                onClick: () {
                  //filter from longest to shortest and vice versa
                },
              ),
              CustomChip(
                chipText: 'Top Rated',
                chipIcon: Icons.star_rounded,
                isSelected: isTopRatedSelected,
                onClick: () {
                  setState(() {
                    if (isTopRatedSelected) {
                      isTopRatedSelected = false;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    } else {
                      isTopRatedSelected = true;
                      restaurantController.setfilter(
                        Filter(
                          maxTime: 0,
                          minRating: isTopRatedSelected ? 4 : 1,
                          maxPrice: 3,
                          onlyDelivery: isDeliverySelected,
                          onlyFavorite: isFavoriteSelected,
                          useFilter: true,
                          useTime: false,
                        ),
                      );
                    }
                  });
                },
              ),
              CustomChip(
                chipText: 'Clear',
                chipIcon: Icons.clear,
                onClick: () {
                  setState(() {
                    isDeliverySelected = false;
                    isFavoriteSelected = false;
                    isTopRatedSelected = false;
                    restaurantController.setfilter(
                      Filter(
                        maxTime: 0,
                        minRating: 1,
                        maxPrice: 3,
                        onlyDelivery: false,
                        onlyFavorite: false,
                        useFilter: false,
                        useTime: false,
                      ),
                    );
                  });
                },
              ),
            ];
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: chips,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children:
                          filteredRestaurants.map(buildRestaurantTile).toList(),
                    ),
                  ),
                ),
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

class CustomChip extends StatelessWidget {
  String chipText;
  IconData chipIcon;
  Function onClick;
  bool isSelected;
  CustomChip({
    Key? key,
    required this.chipText,
    required this.chipIcon,
    required this.onClick,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Chip(
          elevation: 3,
          backgroundColor: isSelected
              ? const Color.fromRGBO(121, 32, 27, 0.2)
              : Colors.white,
          label: Row(
            children: [
              Icon(chipIcon),
              Text(chipText),
            ],
          ),
        ),
      ),
    );
  }
}
