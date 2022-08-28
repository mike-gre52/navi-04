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

  void leaveGroup() {
    final username = globalUsername;
    final color = globalColor;
    final member = Member(
      name: username,
      color: color,
      id: firebaseAuth.currentUser!.uid,
    );
    firestore.collection('groups').doc(globalGroupId).update({
      'members': FieldValue.arrayRemove([member.toJson()])
    });

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
  }

  setUserInGroupStatusFalse() {
    firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({"inGroup": false});
  }

  createGroup(String groupName) async {
    final username = globalUsername;
    final color = globalColor;

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

    globalGroupId = newGroupId;
    final group = Group(
      groupName: groupName,
      groupId: newGroupId,
      members: [
        Member(
            name: username,
            color: color,
            id: '${firebaseAuth.currentUser!.uid}'),
      ],
    );

    //creates group in group collection
    firestore.collection('groups').doc(globalGroupId).set(group.toJson());

    setUserGroupId(globalGroupId);
    setUserInGroupStatusTrue();
  }

  addGroupMember(String groupId, Member member) async {
    //check if group exists----

    try {
      //will try to add user to group - will throw if the group does not exist
      await firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion(
          [member.toJson()],
        )
      });

      //updates users group id
      setUserGroupId(groupId);
      setUserInGroupStatusTrue();

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

  setFirebaseUserColorInGroup(String newColor) async {
    final username = globalUsername;

    final newMemberData = Member(
      name: username,
      color: newColor,
      id: firebaseAuth.currentUser!.uid,
    );
    final oldMemberData = Member(
      name: username,
      color: globalColor,
      id: firebaseAuth.currentUser!.uid,
    );

    firestore.collection('groups').doc(globalGroupId).update({
      "members": FieldValue.arrayRemove([oldMemberData.toJson()])
    });
    firestore.collection('groups').doc(globalGroupId).update({
      "members": FieldValue.arrayUnion([newMemberData.toJson()])
    });
    globalColor = newColor;
  }
}
