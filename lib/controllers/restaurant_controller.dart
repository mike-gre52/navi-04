import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/filter.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/restaurants/add_restaurant.dart';

import '../models/restaurant.dart';

class RestaurantController extends GetxController {
  static RestaurantController instance = Get.find();

  RestaurantFilter _filterData = RestaurantFilter(
    maxTime: 0,
    minRating: 1,
    maxPrice: 3,
    onlyDelivery: false,
    onlyFavorite: false,
    useFilter: false,
    useTime: false,
  );

  RestaurantFilter setfilter(RestaurantFilter newFilter) {
    _filterData = newFilter;
    return newFilter;
  }

  RestaurantFilter get filter => _filterData;

  List<Restaurant> filterRestaurants(
      List<Restaurant> restaurants, RestaurantFilter filterData) {
    List<Restaurant> filteredList = [];
    List<Restaurant> nullList = [];
    if (filterData.useFilter) {
      for (var i = 0; i < restaurants.length; i++) {
        var currentRestaurant = restaurants[i];
        if (currentRestaurant.price != null &&
            currentRestaurant.rating != null &&
            currentRestaurant.doesDelivery != null &&
            currentRestaurant.isFavorite != null) {
          //current resturant has a value for price

          if (filterData.useTime) {
            if (filterData.maxTime > currentRestaurant.price!) {
              if (currentRestaurant.rating! >= filterData.minRating) {
                //filter Price
                if (currentRestaurant.price! <= filterData.maxPrice) {
                  //filter Delivery

                  if (filterData.onlyDelivery) {
                    if (currentRestaurant.doesDelivery!) {
                      if (filterData.onlyFavorite) {
                        if (currentRestaurant.isFavorite!) {
                          filteredList.add(currentRestaurant);
                        }
                      } else {
                        filteredList.add(currentRestaurant);
                      }
                    }
                  } else {
                    if (filterData.onlyFavorite) {
                      if (currentRestaurant.isFavorite!) {
                        filteredList.add(currentRestaurant);
                      }
                    } else {
                      filteredList.add(currentRestaurant);
                    }
                  }
                }
              }
            }
          } else {
            if (currentRestaurant.rating! >= filterData.minRating) {
              //filter Price

              if (currentRestaurant.price! <= filterData.maxPrice) {
                //filter Delivery

                if (filterData.onlyDelivery) {
                  if (currentRestaurant.doesDelivery!) {
                    if (filterData.onlyFavorite) {
                      if (currentRestaurant.isFavorite!) {
                        filteredList.add(currentRestaurant);
                      }
                    } else {
                      filteredList.add(currentRestaurant);
                    }
                  }
                } else {
                  if (filterData.onlyFavorite) {
                    if (currentRestaurant.isFavorite!) {
                      filteredList.add(currentRestaurant);
                    }
                  } else {
                    filteredList.add(currentRestaurant);
                  }
                }
              }
            }
          }
        } else {
          //current resturant doesnt have a price
          nullList.add(currentRestaurant);
          continue;
        }

        //filter Rating
      }

      for (var i = 0; i < nullList.length; i++) {
        // if (filterData.onlyDelivery && nullList[i].doesDelivery) {
        //   filteredList.add(nullList[i]);
        // } else if (filterData.onlyFavorite && nullList[i].isFavorite) {
        //   filteredList.add(nullList[i]);
        // }
      }
    } else {
      return restaurants;
    }

    return filteredList;
  }

  Stream<List<Restaurant>> getRestuarants() {
    Stream<List<Restaurant>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('restaurants')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Restaurant.fromJson(doc.data()))
              .where((restaurant) {
            return restaurant.id != null && restaurant.id != "";
          }).toList(),
        );

    return data;
  }

  addRestaurant(Restaurant restaurant) async {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurant.id)
          .set(restaurant.toJson());
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
  }

  addOrder(Restaurant restaurant, String order) {
    List<String> orders = [];
    if (restaurant.orders != null) {
      orders = restaurant.orders!;
    }
    orders.add(order);
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('restaurants')
        .doc(restaurant.id)
        .update({"orders": orders});
  }

  editOrder(Restaurant restaurant, String oldOrder, String newOrder) {
    deleteOrder(restaurant, oldOrder);
    addOrder(restaurant, newOrder);
  }

  updateRestaurant(
    Restaurant restaurant,
  ) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurant.id)
          .update(restaurant.toJson());
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
  }

  void deleteRestaurant(Restaurant restaurant) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurant.id)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting Restaurant',
        '$e',
      );
    }
  }

  void deleteOrder(Restaurant restaurant, String order) {
    List<String> orders = [];
    if (restaurant.orders != null) {
      orders = restaurant.orders!;
    }
    orders.remove(order);
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurant.id)
          .update({"orders": orders});
    } catch (e) {
      Get.snackbar(
        'Error Deleting Order',
        '$e',
      );
    }
  }

  toggleRestaurantFavorite(String restaurantId, bool isFavorite) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurantId)
          .update({'isFavorite': !isFavorite});
    } catch (e) {
      Get.snackbar(
        'Error Accessing Server',
        '$e',
      );
    }
  }

  updateRestaurantUrl(String restaurantId, String url) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurantId)
          .update({'restaurantUrl': url});
    } catch (e) {
      //
    }
  }

  updateRestaurantPhoneNumber(String restaurantId, String phoneNumber) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurantId)
          .update({'phoneNumber': phoneNumber});
    } catch (e) {
      //
    }
  }

  List<Restaurant> sortByPrice(
      List<Restaurant> restaurants, bool expensiveFirst) {
    List<Restaurant> orderedList = [];

    List<Restaurant> onePriceList = [];
    List<Restaurant> twoPriceList = [];
    List<Restaurant> threePriceList = [];

    for (var i = 0; i < restaurants.length; i++) {
      final restaurant = restaurants[i];
      if (restaurant.price == 1) {
        onePriceList.add(restaurant);
      } else if (restaurant.price == 2) {
        twoPriceList.add(restaurant);
      } else if (restaurant.price == 3) {
        threePriceList.add(restaurant);
      }
      if (expensiveFirst) {
        orderedList = threePriceList + twoPriceList + onePriceList;
      } else {
        orderedList = onePriceList + twoPriceList + threePriceList;
      }
    }

    return orderedList;
  }

  List<Restaurant> sortRestaurantFromSlowestToFastest(
      List<Restaurant> restaurants) {
    List<Restaurant> orderedList = [];
    for (var i = 0; i < restaurants.length; i++) {
      final currentRestaurant = restaurants[i];
      final currentTime;
      if (currentRestaurant.time != null) {
        currentTime = currentRestaurant.time;
      } else {
        //orderedList.insert(orderedList.length, currentRestaurant);
        continue;
      }

      if (orderedList.isEmpty) {
        orderedList.insert(i, currentRestaurant);
      } else {
        for (var y = 0; y < orderedList.length; y++) {
          if (orderedList[y].time != null) {
            if (currentTime <= orderedList[y].time) {
              orderedList.insert(y, currentRestaurant);
              break;
            }
          }

          if (y == orderedList.length - 1) {
            orderedList.insert(y + 1, currentRestaurant);
            break;
          }
        }
      }
    }

    print(orderedList.length);
    return orderedList;
  }
}
