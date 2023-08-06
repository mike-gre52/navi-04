import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  String? name;
  int? time;
  int? rating;
  int? price;
  bool? doesDelivery;
  bool? isFavorite;
  String? phoneNumber;
  String? id;
  String? restaurantUrl;
  List<String>? orders;

  Restaurant({
    required this.name,
    required this.time,
    required this.rating,
    required this.price,
    required this.doesDelivery,
    required this.isFavorite,
    required this.phoneNumber,
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
        "orders": orders,
        "phoneNumber": phoneNumber,
      };

  static Restaurant fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json["name"],
      time: json["time"],
      rating: json["rating"],
      price: json["price"],
      doesDelivery: json["doesDelivery"],
      isFavorite: json["isFavorite"],
      phoneNumber: json["phoneNumber"],
      id: json["id"],
      restaurantUrl: json["restaurantUrl"],
      orders: OrderItem.orderToJson(json),
    );
  }
}

class Order {
  String name;
  List<OrderItem> orderItems;

  Order({
    required this.name,
    required this.orderItems,
  });
}

class OrderItem {
  String? name;
  String item;

  OrderItem({
    required this.name,
    required this.item,
  });

  static List<OrderItem> ordersFromJson(Map<String, dynamic> json) {
    List<OrderItem> orders = [];

    if (json['orders'] != null) {
      json['orders'].forEach((name, item) {
        final newInstruction = OrderItem(name: name, item: item);
        orders.add(newInstruction);
      });
    }

    return orders;
  }

  static List<String> orderToJson(Map<String, dynamic> json) {
    List<String> orders = [];
    if (json["orders"] != null) {
      List<dynamic> rawList = json["orders"];
      for (dynamic rawOrder in rawList) {
        orders.add(rawOrder.toString());
      }
    }

    return orders;
  }
}
