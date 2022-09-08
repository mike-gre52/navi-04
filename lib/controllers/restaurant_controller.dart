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

  Filter _filterData = Filter(
    maxTime: 0,
    minRating: 1,
    maxPrice: 3,
    onlyDelivery: false,
    onlyFavorite: false,
    useFilter: false,
    useTime: false,
  );

  void setfilter(Filter newFilter) {
    _filterData = newFilter;
  }

  Filter get filter => _filterData;

  List<Restaurant> filterRestaurants(
      List<Restaurant> restaurants, Filter filterData) {
    List<Restaurant> filteredList = [];
    if (filterData.useFilter) {
      for (var i = 0; i < restaurants.length; i++) {
        var currentRestaurant = restaurants[i];

        if (filterData.useTime) {
          if (filterData.maxTime > currentRestaurant.price) {
            if (currentRestaurant.rating >= filterData.minRating) {
              //filter Price
              if (currentRestaurant.price <= filterData.maxPrice) {
                //filter Delivery

                if (filterData.onlyDelivery) {
                  if (currentRestaurant.doesDelivery) {
                    if (filterData.onlyFavorite) {
                      if (currentRestaurant.isFavorite) {
                        filteredList.add(currentRestaurant);
                      }
                    } else {
                      filteredList.add(currentRestaurant);
                    }
                  }
                } else {
                  if (filterData.onlyFavorite) {
                    if (currentRestaurant.isFavorite) {
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
          if (currentRestaurant.rating >= filterData.minRating) {
            //filter Price

            if (currentRestaurant.price <= filterData.maxPrice) {
              //filter Delivery

              if (filterData.onlyDelivery) {
                if (currentRestaurant.doesDelivery) {
                  if (filterData.onlyFavorite) {
                    if (currentRestaurant.isFavorite) {
                      filteredList.add(currentRestaurant);
                    }
                  } else {
                    filteredList.add(currentRestaurant);
                  }
                }
              } else {
                if (filterData.onlyFavorite) {
                  if (currentRestaurant.isFavorite) {
                    filteredList.add(currentRestaurant);
                  }
                } else {
                  filteredList.add(currentRestaurant);
                }
              }
            }
          }
        }

        //filter Rating

      }
    } else {
      print('no filter on');
      return restaurants;
    }

    return filteredList;
  }

  Stream<List<Restaurant>> getRestuarants() {
    print(globalGroupId);
    Stream<List<Restaurant>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('restaurants')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Restaurant.fromJson(doc.data()))
              .toList(),
        );
    return data;
  }

  addRestaurant(
    String name,
    int time,
    int rating,
    int price,
    bool doesDelivery,
    String notes,
    bool isFavorite,
  ) async {
    try {
      final restaurantId = DateTime.now().toString();
      Restaurant restaurant = Restaurant(
        name: name,
        time: time,
        rating: rating,
        price: price,
        doesDelivery: doesDelivery,
        isFavorite: isFavorite,
        notes: notes,
        id: restaurantId,
      );

      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurantId)
          .set(restaurant.toJson());
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
  }

  toggleRestaurantFavorite(String restaurantId, bool isFavorite) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('restaurants')
        .doc(restaurantId)
        .update({'isFavorite': !isFavorite});
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
      final restaurant = restaurants[i];
      final time = restaurant.time;
      if (orderedList.isEmpty) {
        orderedList.add(restaurant);
      } else if (orderedList.length == 1) {
        if (orderedList[0].time < time) {
          orderedList.insert(1, restaurant);
        } else {
          orderedList.insert(0, restaurant);
        }
      } else {
        print('after 2');
        bool addedValue = false;
        for (var z = 0; z < orderedList.length; z++) {
          if (orderedList[z].time > time) {
            orderedList.insert(z, restaurant);
            addedValue = true;
          }
        }
        if (addedValue == false) {
          orderedList.insert(orderedList.length - 1, restaurant);
        }
      }
    }
    return orderedList;
  }
}
