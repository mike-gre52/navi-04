import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String name;
  int time;
  int rating;
  int price;
  bool doesDelivery;
  bool isFavorite;
  String notes;

  Restaurant({
    required this.name,
    required this.time,
    required this.rating,
    required this.price,
    required this.doesDelivery,
    required this.isFavorite,
    required this.notes,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "rating": rating,
        "price": price,
        "doesDelivery": doesDelivery,
        "isFavorite": isFavorite,
        "notes": notes,
      };

  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
        name: json["name"],
        time: json["time"],
        rating: json["rating"],
        price: json["price"],
        doesDelivery: json["doesDelivery"],
        isFavorite: json["isFavorite"],
        notes: json["notes"]);
  }
}
