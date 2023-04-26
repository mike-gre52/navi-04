import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/filter.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/routes/routes.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/create_or_join_banner.dart';
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
bool shouldShuffle = true;

class _ResturantsScreenState extends State<ResturantsScreen> {
  Widget buildRestaurantTile(
    Restaurant restaurant,
  ) =>
      RestaurantCell(
        restaurant: restaurant,
        showCost: sortCost > 0,
        showTime: sortTime > 0,
      );

  void addRestaurantIconButton() {
    Get.toNamed(RouteHelper.getAddRestaurantRoute());
  }

  updateUI() {
    setState(() {});
  }

  bool isFavoriteSelected = false;
  bool isDeliverySelected = false;
  bool isTopRatedSelected = false;
  int sortTime = 0;
  int sortCost = 0;
  late Filter filter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('reset filter');
    filter = Filter(
      maxTime: 0,
      minRating: isTopRatedSelected ? 4 : 1,
      maxPrice: 1,
      onlyDelivery: isDeliverySelected,
      onlyFavorite: isFavoriteSelected,
      useFilter: true,
      useTime: false,
    );
  }

  setFilterState(Filter updatedFilter) {
    filter = updatedFilter;
    setState(() {
      restaurantController.setfilter(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double height15 = screenHeight / 59.733;
    double height40 = screenHeight / 22.4;
    double height50 = screenHeight / 17.92;

    return Scaffold(
      body: inGroup
          ? StreamBuilder<List<Restaurant>>(
              stream: restaurantController.getRestuarants(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final restaurants = snapshot.data!;

                  filteredRestaurants = restaurantController.filterRestaurants(
                      restaurants, restaurantController.filter);
                  if (shouldShuffle) {
                    filteredRestaurants.shuffle();
                    shouldShuffle = false;
                  }

                  if (sortCost == 1) {
                    filteredRestaurants = restaurantController.sortByPrice(
                        filteredRestaurants, true);
                  }
                  if (sortCost == 2) {
                    filteredRestaurants = restaurantController.sortByPrice(
                        filteredRestaurants, false);
                  }
                  if (sortTime == 1) {
                    filteredRestaurants =
                        restaurantController.sortRestaurantFromSlowestToFastest(
                            filteredRestaurants);
                  }
                  if (sortTime == 2) {
                    filteredRestaurants = restaurantController
                        .sortRestaurantFromSlowestToFastest(filteredRestaurants)
                        .reversed
                        .toList();
                  }

                  List<CustomChip> chips = [
                    CustomChip(
                      chipText: '',
                      chipIcon: CupertinoIcons.slider_horizontal_3,
                      onClick: () {
                        Get.toNamed(RouteHelper.restaurantFilter,
                            arguments: [filter, setFilterState]);
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
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
                          } else {
                            isFavoriteSelected = true;
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
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
                            isDeliverySelected = false;
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
                          } else {
                            isDeliverySelected = true;
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
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
                        sortTime = 0;
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
                      isSelected: sortTime == 1 || sortTime == 2,
                      onClick: () {
                        //filter from longest to shortest and vice versa
                        sortTime += 1;
                        sortCost = 0;
                        if (sortTime > 2) {
                          setState(() {
                            sortTime = 0;
                          });
                        } else {
                          setState(() {
                            sortTime = sortTime;
                          });
                        }
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
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
                          } else {
                            isTopRatedSelected = true;
                            filter = Filter(
                              maxTime: 0,
                              minRating: isTopRatedSelected ? 4 : 1,
                              maxPrice: 3,
                              onlyDelivery: isDeliverySelected,
                              onlyFavorite: isFavoriteSelected,
                              useFilter: true,
                              useTime: false,
                            );
                            restaurantController.setfilter(filter);
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
                          sortTime = 0;
                          sortCost = 0;
                          filter = Filter(
                            maxTime: 0,
                            minRating: 1,
                            maxPrice: 3,
                            onlyDelivery: false,
                            onlyFavorite: false,
                            useFilter: false,
                            useTime: false,
                          );
                          restaurantController.setfilter(filter);
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
                        rightAction: Icon(
                          Icons.add_rounded,
                          size: height40,
                          color: Colors.white,
                        ),
                        onIconClick: addRestaurantIconButton,
                      ),
                      Container(
                        height: height50,
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
                            children: filteredRestaurants
                                .map(buildRestaurantTile)
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: height15,
                        color: appRed,
                        animating: true,
                      ),
                    ),
                  );
                }
              },
            )
          : Column(
              children: [
                AppHeader(
                  headerText: 'Restaurants',
                  headerColor: appRed,
                  borderColor: royalYellow,
                  textColor: Colors.white,
                  dividerColor: Colors.white,
                  rightAction: Container(),
                  onIconClick: () {},
                ),
                Expanded(
                  child: Center(
                    child: CreateOrJoinBanner(
                      onCreateGroup: updateUI,
                      color: appRed,
                      item: "restaurant",
                    ),
                  ),
                ),
              ],
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenWidth = mediaQuery.size.width;
    double width10 = screenWidth / 41.4;

    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: EdgeInsets.only(left: width10),
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
