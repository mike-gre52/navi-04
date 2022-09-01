import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String groupName;
  String groupId;

  Group({
    required this.groupName,
    required this.groupId,
  });

  Group.static({
    this.groupName = '',
    this.groupId = '',
  });

  Group fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    final group = Group(
      groupName: snapshot['groupName'],
      groupId: snapshot['groupId'],
    );

    return group;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupId'] = this.groupId;
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
