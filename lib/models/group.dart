import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String groupName;
  String groupId;
  List members;
  List<String> categories;

  Group({
    required this.groupName,
    required this.groupId,
    required this.members,
    required this.categories,
  });

  Group.static({
    this.groupName = '',
    this.groupId = '',
    this.members = const [],
    this.categories = const [],
  });

  static categoriesJsonToString(Map<String, dynamic> json) {
    List<String> categories = [];
    if (json["categories"] != null) {
      List jsonCategories = json["categories"];
      for (dynamic categorie in jsonCategories) {
        categories.add(categorie.toString());
      }
    }
    return categories;
  }

  Group fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    final group = Group(
      groupName: snapshot['groupName'],
      groupId: snapshot['groupId'],
      members: snapshot['members'],
      categories: categoriesJsonToString(snapshot),
    );
    return group;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupId'] = this.groupId;
    data['members'] = this.members;
    data['categories'] = this.categories;
    return data;
  }
}

class Member {
  String name;
  String color;
  String id;

  Member({
    required this.name,
    required this.color,
    required this.id,
  });

  Member.static({
    this.name = '',
    this.color = '',
    this.id = '',
  });

  static Member fromJson(Map<String, dynamic> json) {
    final members = Member(
      name: json['name'],
      color: json['color'],
      id: json['id'],
    );

    return members;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['id'] = this.id;
    return data;
  }
}
