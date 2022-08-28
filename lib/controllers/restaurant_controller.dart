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
            print('looped price ${currentRestaurant.price}');
            print('filter price ${filterData.maxPrice}');
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

  addRestaurant(String name, int time, int rating, int price, bool doesDelivery,
      String notes, bool isFavorite) async {
    try {
      Restaurant restaurant = Restaurant(
        name: name,
        time: time,
        rating: rating,
        price: price,
        doesDelivery: doesDelivery,
        isFavorite: isFavorite,
        notes: notes,
      );

      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('restaurants')
          .doc('${DateTime.now()}')
          .set(restaurant.toJson());
    } catch (e) {
      Get.snackbar(
        'Error Adding Restaurant',
        '$e',
      );
    }
  }
}
