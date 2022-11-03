import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/data/local_data.dart';
import 'package:whats_for_dinner/main.dart';
import 'package:whats_for_dinner/models/list.dart';
import 'package:whats_for_dinner/utils/colors.dart';
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
        .collection('items')
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

  Stream<List<Item>> getRecentlyDeletedListItems(listId) {
    Stream<List<Item>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('recently-deleted')
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
        .collection('items')
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

  void deleteListItem(
      Item item, String listId, bool showSnackBar, bool addToRecentlyDeleted) {
    if (addToRecentlyDeleted) {
      //add to recently deleted
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('lists')
          .doc(listId) //specific list
          .collection('recently-deleted')
          .doc(item.id)
          .set(item.toJson());
    }

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('items')
        .doc(item.id)
        .delete(); //will need to build Item

    //update itemCount

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .update({'itemCount': FieldValue.increment(-1)});

    if (showSnackBar) {
      Get.snackbar(
        '',
        '',
        messageText: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'Undo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        //backgroundColor: red,
        //maxWidth: ,
        //margin: EdgeInsets.only(left: 150),

        duration: const Duration(milliseconds: 3500),
        padding: const EdgeInsets.all(0),
        snackPosition: SnackPosition.BOTTOM,

        onTap: (snack) {
          restoreListItem(item, listId);
        },
      );
    }
  }

  void restoreListItem(Item item, String listId) {
    var itemId = DateTime.now().toString();
    //create new item
    final newItem = Item(
      name: item.name,
      id: itemId,
      isChecked: false,
    );

    //add back to groceries
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('items')
        .doc(item.id)
        .set(item.toJson());

    //update itemCount
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .update({'itemCount': FieldValue.increment(1)});

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('recently-deleted')
        .doc(item.id)
        .delete(); //will need to build Item
  }

  void deleteSelectedItems(String listId, List<Item> listItems) {
    for (var i = 0; i < listItems.length; i++) {
      if (listItems[i].isChecked) {
        deleteListItem(listItems[i], listId, false, true);
      }
    }
  }

  void deleteAllListItems(
      String listId, List<Item> listItems, bool addToRecentlyDeleted) {
    for (var i = 0; i < listItems.length; i++) {
      deleteListItem(listItems[i], listId, false, addToRecentlyDeleted);
    }
  }

  void deleteRecentlyDeletedItem(String itemId, String listId) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('recently-deleted')
        .doc(itemId)
        .delete(); //will need to build Item
  }

  void clearRecentlyDeleted(String listId, List<Item> items) {
    print(items.length);
    for (var i = 0; i < items.length; i++) {
      deleteRecentlyDeletedItem(items[i].id, listId);
    }
  }

  void toggleListItemCheckedStatus(
      String itemId, String listId, bool isChecked) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('items')
        .doc(itemId)
        .update({'isChecked': !isChecked});
  }

  void createList(
    String listName,
  ) {
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

  void deleteList(String listId, List<Item> listItems) {
    deleteAllListItems(listId, listItems, false);
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .delete();
  }

  void editListItemName(String itemId, String listId, String newName) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId)
        .collection('items')
        .doc(itemId)
        .update({'name': newName});
  }
}
