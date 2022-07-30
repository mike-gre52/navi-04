import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String groupName;
  String groupId;
  List<String> members;

  Group({
    required this.groupName,
    required this.groupId,
    required this.members,
  });

  static Group fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    final group = Group(
      groupName: snapshot['groupName'],
      groupId: snapshot['groupId'],
      members: snapshot['members'].cast<String>(),
    );
    return group;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['groupId'] = this.groupId;
    data['members'] = this.members;
    return data;
  }
}
