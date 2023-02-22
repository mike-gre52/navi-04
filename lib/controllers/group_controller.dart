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

  Stream<List<Member>> getGroupMembers() {
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

  void leaveGroup(Group group) {
    final username = globalUsername;
    final color = globalColor;
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

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('members')
        .doc(firebaseAuth.currentUser!.uid)
        .delete();

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
    print('adding');
    firestore.collection('groups').doc(groupId).update({
      'members': FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
    });
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

  createGroup(String groupName) async {
    final username = globalUsername;
    final color = globalColor;

    String newGroupId = generateUniqueId();

    globalGroupId = newGroupId;
    final group = Group(
        groupName: groupName,
        groupId: newGroupId,
        members: [firebaseAuth.currentUser!.uid]);

    final member = Member(
      name: username,
      color: color,
      id: '${firebaseAuth.currentUser!.uid}',
    );

    //creates group in group collection
    firestore.collection('groups').doc(globalGroupId).set(group.toJson());
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('members')
        .doc(firebaseAuth.currentUser!.uid)
        .set(member.toJson());

    setUserGroupId(globalGroupId);
    setUserInGroupStatusTrue();
  }

  addGroupMember(String groupId, Member member) async {
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
      print(snap);
      if (snap.exists) {
        //group id valid
        print('1');
        await addIdToMembers(groupId);
        print('2');
        await firestore
            .collection('groups')
            .doc(groupId)
            .collection('members')
            .doc(firebaseAuth.currentUser!.uid)
            .set(member.toJson());
        print('3');
        //updates users group id
        setUserGroupId(groupId);
        print('4');
        setUserInGroupStatusTrue();
        print('5');

        Get.snackbar(
          'Success',
          'You have succesfully joined!',
          onTap: (snack) {
            print('hello');
          },
        );
      } else {
        //group id invalid
        Get.snackbar(
          'Invalid Group Id',
          'The group Id \'$groupId\' is not valid.',
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Invalid Group Id',
        'The group Id \'$groupId\' is not valid.',
      );
    }
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
