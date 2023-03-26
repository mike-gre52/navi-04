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

  Filter setfilter(Filter newFilter) {
    _filterData = newFilter;
    return newFilter;
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
    bool isFavorite,
    String restaurantUrl,
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
        id: restaurantId,
        restaurantUrl: restaurantUrl,
        orders: [],
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

  addOrder(Restaurant restaurant, Order order) {
    print("in add order 1");
    List<Order> orders = restaurant.orders;
    orders.add(order);
    print("in add order 2");
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('restaurants')
        .doc(restaurant.id)
        .update({"orders": Order.orderToJson(orders)});
    print("in add order 3");
  }

  editOrder(Restaurant restaurant, Order oldOrder, Order newOrder) {
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

  deleteOrder(Restaurant restaurant, Order order) {
    List<Order> orders = restaurant.orders;
    orders.remove(order);
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc(restaurant.id)
          .update({"orders": Order.orderToJson(orders)});
    } catch (e) {
      Get.snackbar(
        'Error Deleting Order',
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
    print('filter');
    List<Restaurant> orderedList = [];
    for (var i = 0; i < restaurants.length; i++) {
      final currentRestaurant = restaurants[i];
      final currentTime = currentRestaurant.time;
      if (orderedList.isEmpty) {
        orderedList.insert(i, currentRestaurant);
      } else {
        for (var y = 0; y < orderedList.length; y++) {
          print(currentTime);
          if (currentTime <= orderedList[y].time) {
            orderedList.insert(y, currentRestaurant);
            break;
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
