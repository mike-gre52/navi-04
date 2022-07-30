import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/screens/add_restaurant.dart';

import '../models/restaurant.dart';

class RestaurantController extends GetxController {
  static RestaurantController instance = Get.find();

  Stream<List<Restaurant>> getRestuarants() {
    Stream<List<Restaurant>> data =
        firestore.collection('restaurants').snapshots().map(
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
      Restaurant restaurant = Restaurant(
        name: name,
        time: time,
        rating: rating,
        price: price,
        doesDelivery: doesDelivery,
        isFavorite: isFavorite,
        notes: notes,
      );

      await firestore
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
