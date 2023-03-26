import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String name;
  int time;
  int rating;
  int price;
  bool doesDelivery;
  bool isFavorite;
  String id;
  String restaurantUrl;
  List<Order> orders;

  Restaurant({
    required this.name,
    required this.time,
    required this.rating,
    required this.price,
    required this.doesDelivery,
    required this.isFavorite,
    required this.id,
    required this.restaurantUrl,
    required this.orders,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "rating": rating,
        "price": price,
        "doesDelivery": doesDelivery,
        "isFavorite": isFavorite,
        "id": id,
        "restaurantUrl": restaurantUrl,
        "orders": Order.orderToJson(orders),
      };

  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json["name"],
      time: json["time"],
      rating: json["rating"],
      price: json["price"],
      doesDelivery: json["doesDelivery"],
      isFavorite: json["isFavorite"],
      id: json["id"],
      restaurantUrl: json["restaurantUrl"],
      orders: Order.ordersFromJson(json),
    );
  }
}

class Order {
  String name;
  String item;

  Order({
    required this.name,
    required this.item,
  });

  static List<Order> ordersFromJson(Map<String, dynamic> json) {
    List<Order> orders = [];

    if (json['orders'] != null) {
      json['orders'].forEach((name, item) {
        final newInstruction = Order(name: name, item: item);
        orders.add(newInstruction);
      });
    }

    return orders;
  }

  static Map<String, dynamic> orderToJson(List<Order> orders) {
    Map<String, dynamic> jsonData = {};
    orders.forEach(
      (i) {
        if (i.name == "") {
          jsonData[" "] = i.item;
        } else {
          jsonData[i.name] = i.item;
        }
      },
    );

    return jsonData;
  }
}
