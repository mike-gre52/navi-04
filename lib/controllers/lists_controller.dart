import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/lists/list_item.dart';

import '../models/user.dart';

class ListsController extends GetxController {
  static ListsController instance = Get.find();

  var listInstance = ListData.static();

  Stream<List<ListData>> getListData() {
    Stream<List<ListData>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ListData.static().fromJson(doc.data()))
              .toList(),
        );
    return data;
  }

  Stream<List<Item>> getListItems(listId) {
    Stream<List<Item>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('Items')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Item.static().fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );

    return data;
  }

  void addListItem(String newItem, String listId) {
    var itemId = DateTime.now().toString();
    final item = Item(
      name: newItem,
      id: itemId,
      isChecked: false,
    );

    // add item to list collection

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('Items')
        .doc(itemId) //need to generate unquie id
        .set(item.toJson()); //will need to build Item

    //update itemCount
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .update({'itemCount': FieldValue.increment(1)});
  }

  void deleteListItem(String itemId, String listId) {
    print(itemId);
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('Items')
        .doc(itemId)
        .delete(); //will need to build Item

    //update itemCount

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .update({'itemCount': FieldValue.increment(-1)});
  }

  void toggleListItemCheckedStatus(
      String itemId, String listId, bool isChecked) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('Items')
        .doc(itemId)
        .update({'isChecked': !isChecked});
  }

  void createList(String listName) {
    final String listId = DateTime.now().toString();
    final list = ListData(
      name: listName,
      id: listId,
      itemCount: 0,
    );

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .set(list.toJson());
  }

  void deleteList(String listId) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .delete();
  }
}
