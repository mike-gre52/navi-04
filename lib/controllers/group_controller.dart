import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/group.dart';

import '../utils/constants.dart';

class GroupController extends GetxController {
  static GroupController instance = Get.find();

  var groupInstance = Group.static();

  Stream<Group> getGroupData() {
    Stream<Group> data =
        firestore.collection('groups').doc(globalGroupId).snapshots().map(
      (snapshot) {
        Group group = groupInstance.fromJson(snapshot);
        return group;
      },
    );
    return data;
  }

  Future<Group> getGroupCall(String groupID) async {
    final data = await firestore.collection('groups').doc(globalGroupId).get();

    Group group = Group.static().fromJson(data);

    return group;
  }

  // Future<List<String>> getGroupCategories() async {
  //   final recipeData =
  //       firestore.collection('groups').doc(globalGroupId).collection('recipes');

  //   QuerySnapshot<Object?> data = await recipeData.get();

  //   List<Recipe> recipes = [];

  //   data.docs.forEach((element) {
  //     Map<String, dynamic> data = element.data() as Map<String, dynamic>;
  //     recipes.add(Recipe.static().fromJson(data));
  //   });
  //   recipes.forEach((element) {
  //     print(element.name);
  //   });
  //   return recipes;
  // }

  Stream<List<Member>> getGroupMembers() {
    //print("inside get Group Members $globalGroupId");
    Stream<List<Member>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('members')
        .snapshots()
        .map(
      (snapshot) {
        List<Member> members =
            snapshot.docs.map((doc) => Member.fromJson(doc.data())).toList();
        return members;
      },
    );
    return data;
  }

  Future<void> leaveGroup(Group group) async {
    final username = globalUsername;
    final color = globalColor;
    categories = [];
    /*
    final member = Member(
      name: username,
      color: color,
      id: firebaseAuth.currentUser!.uid,
    );
    firestore.collection('groups').doc(globalGroupId).update({
      'members': FieldValue.arrayRemove([member.toJson()])
    });
    */
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('members')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
    } catch (e) {}

    removeIdFromMembers(group.members);
    setUserGroupId(firebaseAuth.currentUser!.uid);
    setUserInGroupStatusFalse();
  }

  setUserGroupId(newGroupId) {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"groupId": newGroupId});
    globalGroupId = newGroupId;
  }

  setUserInGroupStatusTrue() {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"inGroup": true});
    inGroup = true;
  }

  setUserInGroupStatusFalse() {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"inGroup": false});
    inGroup = false;
  }

  removeIdFromMembers(List members) {
    members.remove(firebaseAuth.currentUser!.uid);
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .update({'members': members});
  }

  addIdToMembers(String groupId) {
    firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
    });
  }

  void setUserRecipeCategories() async {
    List<String> fetchedCategories =
        await recipeController.getRecipeCategories();
    categories = fetchedCategories;
  }

  String generateUniqueId() {
    String newGroupId = '';
    for (var i = 0; i < 4; i++) {
      final uniqueId = UniqueKey().toString();
      final shortedId = uniqueId.substring(2, uniqueId.length - 1);
      if (i == 0) {
        newGroupId = shortedId;
      } else {
        newGroupId = newGroupId + '-' + shortedId;
      }
    }
    return newGroupId;
  }

  Future<void> createGroupDocInFirebase(Group group) async {
    await firestore.collection('groups').doc(globalGroupId).set(group.toJson());
  }

  Future<void> setGroupMembersAfterGroupIsCreated(Member member) async {
    await firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('members')
        .doc(firebaseAuth.currentUser!.uid)
        .set(member.toJson());
  }

  createGroup(String groupName) async {
    final username = globalUsername;
    final color = globalColor;

    String newGroupId = generateUniqueId();

    globalGroupId = newGroupId;
    final group = Group(
        groupName: groupName,
        groupId: newGroupId,
        members: [firebaseAuth.currentUser!.uid],
        categories: []);

    final member = Member(
      name: username,
      color: color,
      id: '${firebaseAuth.currentUser!.uid}',
    );

    //creates group in group collection
    await createGroupDocInFirebase(group);

    //add user to group
    await setGroupMembersAfterGroupIsCreated(member);

    //print("Old Group ID: $globalGroupId");
    setUserGroupId(globalGroupId);
    //print("Creating new group: - new group ID : $globalGroupId");
    setUserInGroupStatusTrue();
  }

  Future<bool> addGroupMember(String groupId, Member member) async {
    //returns true if the user is succesfully added to the group

    //check if group exists----

    try {
      //will try to add user to group - will throw if the group does not exist
      /*
      await firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion(
          [member.toJson()],
        )
      });
      */

      final snap = await firestore.collection('groups').doc(groupId).get();
      if (snap.exists) {
        //group id valid
        await addIdToMembers(groupId);
        await firestore
            .collection('groups')
            .doc(groupId)
            .collection('members')
            .doc(firebaseAuth.currentUser!.uid)
            .set(member.toJson());
        //updates users group id
        setUserGroupId(groupId);
        setUserInGroupStatusTrue();
        //update categories
        setUserRecipeCategories();
        print("+++++++++++++++ categories: $categories");

        Get.snackbar(
          'Success',
          'You have succesfully joined!',
          onTap: (snack) {
            print('hello');
          },
        );
        return true;
      } else {
        //group id invalid
        Get.snackbar(
          'Invalid Group Id',
          'The group Id \'$groupId\' is not valid.',
        );
      }
      return false;
    } catch (e) {
      print(e);
      Get.snackbar(
        'Invalid Group Id',
        'The group Id \'$groupId\' is not valid.',
      );
    }
    return false;
  }

  setFirebaseUserColorInGroup(String newColor) async {
    await firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('members')
        .doc(firebaseAuth.currentUser!.uid)
        .update({'color': newColor});

    globalColor = newColor;
  }
}
