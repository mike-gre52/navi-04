class User {
  String name;
  String profileImage;
  String email;
  String uid;
  String groupId;

  User({
    required this.name,
    required this.profileImage,
    required this.email,
    required this.uid,
    required this.groupId,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profileImage,
        "email": email,
        "uid": uid,
        "groupId": groupId,
      };
}
