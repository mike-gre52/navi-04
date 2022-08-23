import 'package:cloud_firestore/cloud_firestore.dart';

class ListData {
  String name;
  String id;
  int itemCount;

  ListData({
    required this.name,
    required this.id,
    required this.itemCount,
  });

  ListData.static({
    this.name = '',
    this.id = '',
    this.itemCount = 0,
  });

  ListData fromJson(Map<String, dynamic> json) {
    final listData = ListData(
      name: json['name'],
      id: json['id'],
      itemCount: json['itemCount'],
    );
    return listData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['itemCount'] = this.itemCount;
    return data;
  }
}

class Item {
  String name;
  String id;
  bool isChecked;

  Item({
    required this.name,
    required this.id,
    required this.isChecked,
  });

  Item.static({
    this.name = '',
    this.id = '',
    this.isChecked = false,
  });

  Item fromJson(Map<String, dynamic> json) {
    final item = Item(
      name: json['name'],
      id: json['id'],
      isChecked: json['isChecked'],
    );
    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['isChecked'] = this.isChecked;
    return data;
  }
}
