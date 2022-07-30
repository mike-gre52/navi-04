import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/models/group.dart';

import '../utils/constants.dart';

class GroupController extends GetxController {
  static GroupController instance = Get.find();
  String groupId = '';

  setGroupId(String newGroupId) {
    groupId = newGroupId;
  }

  Stream<Group> getGroupData() {
    Stream<Group> data =
        firestore.collection('groups').doc(groupId).snapshots().map(
      (snapshot) {
        Group group = Group.fromJson(snapshot);
        return group;
      },
    );
    return data;
  }

  void leaveGroup() async {
    await firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid])
    });

    setUserGroupId(firebaseAuth.currentUser!.uid);
    setUserInGroupStatusFalse();
    setlocalGroupId(firebaseAuth.currentUser!.uid);
  }

  setUserGroupId(newGroupId) {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"groupId": newGroupId});
  }

  setUserInGroupStatusTrue() {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"inGroup": true});
  }

  setUserInGroupStatusFalse() {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"inGroup": false});
  }

  setlocalGroupId(String groupId) {
    Database().setGroupId(groupId);
  }

  createGroup(String groupName) {
    String groupId = '';
    for (var i = 0; i < 4; i++) {
      final uniqueId = UniqueKey().toString();
      final shortedId = uniqueId.substring(2, uniqueId.length - 1);
      if (i == 0) {
        groupId = shortedId;
      } else {
        groupId = groupId + '-' + shortedId;
      }
    }

    final group = Group(
      groupName: groupName,
      groupId: groupId,
      members: [firebaseAuth.currentUser!.uid],
    );

    //creates group in group collection
    firestore.collection('groups').doc(groupId).set(group.toJson());

    setUserGroupId(groupId);
    setUserInGroupStatusTrue();
    setlocalGroupId(groupId);
  }

  addGroupMember(String groupId) async {
    //check if group exists----

    try {
      //will try to add user to group - will throw if the group does not exist
      await firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
      });

      //updates users group id
      setUserGroupId(groupId);
      setUserInGroupStatusTrue();
      setlocalGroupId(groupId);
      Get.snackbar(
        'Success',
        'You have succesfully joined!',
      );
    } catch (e) {
      Get.snackbar(
        'Invalid Group Id',
        'The group Id \'$groupId\' is not valid.',
      );
    }
  }
}
