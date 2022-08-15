import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profileImage;
  String email;
  String uid;
  String groupId;
  bool inGroup;
  String color;

  User({
    required this.name,
    required this.profileImage,
    required this.email,
    required this.uid,
    required this.groupId,
    required this.inGroup,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profileImage,
        "email": email,
        "uid": uid,
        "groupId": groupId,
        "inGroup": inGroup,
        "color": color,
      };

  static User fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      profileImage: snapshot['profilePhoto'],
      groupId: snapshot['groupId'],
      inGroup: (snapshot['inGroup']),
      color: snapshot["color"],
    );
  }
}
