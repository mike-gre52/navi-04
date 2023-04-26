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

  void addListItem(String newItem, String listId) async {
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
          .doc(listId) //specific list
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
      int numItems = await getListLength(listId);
      adjustListCounter(listId, numItems);
    }
  }

  void deleteListItem(Item item, String listId, bool showSnackBar,
      bool addToRecentlyDeleted) async {
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

    //delete last recently deleted if full

    List<Item> recentlyDeleted = await getRecentlyDeletedTest(listId);
    if (recentlyDeleted.length > 20) {
      deleteRecentlyDeletedItem(recentlyDeleted.first.id, listId);
    }

    //delete image if it exists
    if (item.imageUrl != '') {
      deleteListItemImage(item, listId);
      item.imageUrl = '';
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

    int numItems = await getListLength(listId);
    adjustListCounter(listId, numItems);
    /*
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
    */
  }

  void deleteListItemImage(Item item, String listId) {
    firebaseStorage
        .ref()
        .child(globalGroupId)
        .child('listImages')
        .child('list-$listId')
        .child(item.id)
        .delete();
  }

  void updateListImageUrl(Item item, String listId, String imageUrl) {
    firestore
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
    );

    firestore
        .collection('groups')
        .doc(globalGroupId)
        .collection('lists')
        .doc(listId) //specific list
        .set(list.toJson());
  }

  Future<void> deleteList(String listId, List<Item> listItems,
      List<Item> recentlyDeletedListItems) async {
    await deleteAllListItems(listId, listItems, false);
    await clearRecentlyDeleted(listId, recentlyDeletedListItems);
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
