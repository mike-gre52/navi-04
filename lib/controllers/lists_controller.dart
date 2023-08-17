import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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
    print("getting list data $globalGroupId");
    Stream<List<ListData>> data = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
            (doc) => ListData.static().fromJson(
              doc.data(),
            ),
          )
              .where((list) {
            return list.id != null && list.id != "";
          }).toList(),
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
                (doc) => Item.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );

    return data;
  }

  Future<int> getListItemCount(String listId) async {
    try {
      AggregateQuerySnapshot data = await firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('lists')
          .doc(listId) //specific list
          .collection('items')
          .count()
          .get();
      return data.count;
    } catch (e) {
      return 0;
    }
  }

  Future<int> getListLength(listId) async {
    CollectionReference _collectionRef = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('items');

    QuerySnapshot<Object?> data = await _collectionRef.get();

    List<Item> items = [];

    data.docs.forEach((element) {
      items.add(Item.fromJsonQuery(element));
    });
    return items.length;
  }

  Future<List<Item>> getRecentlyDeletedTest(listId) async {
    CollectionReference _collectionRef = firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('recently-deleted');

    QuerySnapshot<Object?> data = await _collectionRef.get();

    List<Item> deletedItems = [];

    data.docs.forEach((element) {
      deletedItems.add(Item.fromJsonQuery(element));
    });
    return deletedItems;
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
                (doc) => Item.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );

    return data;
  }

  void adjustListCounter(listId, numItems) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .update({'itemCount': numItems});
  }

  void editListName(String listId, String newName) {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('lists')
          .doc(listId) //specific list
          .update({'name': newName});
    } catch (e) {
      //
    }
  }

  Future<void> addListItem(String newItem, ListData list) async {
    int listLength = await getListItemCount(list.id!);
    if (listLength <= 149) {
      var itemId = DateTime.now().toString();
      final item =
          Item(name: newItem, id: itemId, isChecked: false, imageUrl: '');

      // add item to list collection
      bool shouldIncrement = false;
      try {
        await firestore
            .collection('groups')
            .doc(globalGroupId)
            .collection('lists')
            .doc(list.id) //specific list
            .collection('items')
            .doc(itemId) //need to generate unquie id
            .set(item.toJson()); //will need to build Item
        shouldIncrement = true;
      } catch (e) {
        print(e);
        shouldIncrement = false;
      }
      //update itemCount if item succesfully added
      if (shouldIncrement) {
        int numItems = await getListLength(list.id);
        adjustListCounter(list.id, numItems);
      }
    } else {
      Get.snackbar(
        'The list is full',
        'You have reached the maximum items for a list',
      );
    }
  }

  Future<void> deleteListItem(Item item, String listId, bool showSnackBar,
      bool addToRecentlyDeleted) async {
    bool didDeleteImage = await deleteListItemImage(item, listId);
    if (addToRecentlyDeleted) {
      item.imageUrl = "";
      try {
        firestore
            .collection('groups')
            .doc(globalGroupId)
            .collection('lists')
            .doc(listId) //specific list
            .collection('recently-deleted')
            .doc(item.id)
            .set(item.toJson());
      } catch (e) {
        Get.snackbar(
          'Error deleting list item',
          '',
        );
      }
    }
    //delete last recently deleted if full
    List<Item> recentlyDeleted = await getRecentlyDeletedTest(listId);
    if (recentlyDeleted.length > 20) {
      deleteRecentlyDeletedItem(recentlyDeleted.first.id, listId);
    }

    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('lists')
          .doc(listId) //specific list
          .collection('items')
          .doc(item.id)
          .delete(); //will need to build Item
    } catch (e) {
      print("error");
    }
    int numItems = await getListLength(listId);
    adjustListCounter(listId, numItems);
  }

  Future<bool> deleteListItemImage(Item item, String listId) async {
    if (item.imageUrl != null && item.imageUrl != "") {
      try {
        await firebaseStorage
            .ref()
            .child(globalGroupId)
            .child('listImages')
            .child('list-$listId')
            .child(item.id)
            .delete();
        return true;
      } catch (e) {
        Get.snackbar(
          'Error deleting list item',
          '',
        );
        return false;
      }
    }
    return true;
  }

  Future<void> deleteListItemImageFirebase(Item item, String listId) async {
    try {
      await firebaseStorage
          .ref()
          .child(globalGroupId)
          .child('listImages')
          .child('list-$listId')
          .child(item.id)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error deleting list item',
        '',
      );
    }
  }

  Future<void> updateListImageUrl(
      Item item, String listId, String imageUrl) async {
    await firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .collection('items')
        .doc(item.id)
        .update({'imageUrl': imageUrl});
  }

  void updateListName(ListData list, String listName) {
    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(list.id) //specific list
        .update({'name': listName});
  }

  void restoreListItem(Item item, String listId) async {
    var itemId = DateTime.now().toString();
    //create new item
    final newItem = Item(
      name: item.name,
      id: itemId,
      isChecked: false,
      imageUrl: '',
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
    int numItems = await getListLength(listId);
    adjustListCounter(listId, numItems);

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
      if (listItems[i].isChecked != null) {
        if (listItems[i].isChecked!) {
          deleteListItem(listItems[i], listId, false, true);
        }
      }
    }
  }

  Future<void> deleteAllListItems(
      String listId, List<Item> listItems, bool addToRecentlyDeleted) async {
    for (var i = 0; i < listItems.length; i++) {
      await deleteListItem(listItems[i], listId, false, addToRecentlyDeleted);
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

  Future<void> clearRecentlyDeleted(String listId, List<Item> items) async {
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

  void createList(String listName) {
    final String listId = DateTime.now().toString();
    final list = ListData(
      name: listName,
      id: listId,
      itemCount: 0,
      shouldRender: true,
    );

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .set(list.toJson());
  }

  Future<void> setListRenderToFalse(String listId) async {
    try {
      firestore
          .collection('groups')
          .doc(globalGroupId)
          .collection('lists')
          .doc(listId) //specific list
          .update({'shouldRender': false});
    } catch (e) {
      print("error updating list render status");
    }
  }

  Future<void> deleteList(String listId, List<Item> listItems,
      List<Item> recentlyDeletedListItems) async {
    await setListRenderToFalse(listId);
    await deleteAllListItems(listId, listItems, false);
    //await Future.delayed(const Duration(milliseconds: 2000));
    await clearRecentlyDeleted(listId, recentlyDeletedListItems);
    //await Future.delayed(const Duration(milliseconds: 2000));
    await firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .delete();
    //await Future.delayed(const Duration(milliseconds: 2000));
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
