import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

class AddRestaurant extends StatefulWidget {
  AddRestaurant({Key? key}) : super(key: key);

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  bool doesDelivery = true;
  int rating = 1;
  int price = 1;

  Object _selectedSegment = 0;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timeController.dispose();
    _notesController.dispose();
  }

  void setDeliveryStatus(value) {
    if (value == 0) {
      doesDelivery = true;
    } else {
      doesDelivery = false;
    }
  }

  void setPriceStatus(value) {
    price = value;
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            headerText: 'Add Restaurant',
            headerColor: appRed,
            borderColor: royalYellow,
            textColor: Colors.white,
            dividerColor: Colors.white,
            rightAction: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onIconClick: () {
              Navigator.pop(context);
            },
          ),
          //NEED TO MAKE SURE TIME IS A NUMBER - WILL SET THE KEYBOARD TO NUMPAD BUT STILL NEED TO VERIFY
          Container(
            margin: EdgeInsets.only(left: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 18,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: CustomTextfield(
                    icon: Icons.person,
                    placeholderText: '',
                    controller: _nameController,
                    borderColor: appRed,
                    showIcon: false,
                    textfieldWidth: 350,
                    textfieldHeight: 65,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 30),
                      child: Text(
                        'Time',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: CustomTextfield(
                        icon: Icons.timer,
                        placeholderText: '',
                        controller: _timeController,
                        borderColor: appRed,
                        textfieldWidth: 100,
                        showIcon: false,
                        textfieldHeight: 50,
                        borderRadius: 10,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 30),
                      child: Text(
                        'Rating',
                        style: TextStyle(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SelectRating(
                      rating: rating,
                      onTap: newRatingSelected,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 30),
                      child: Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    PriceSegmentedControll(
                      setPriceStatus: setPriceStatus,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, top: 30),
                      child: Text(
                        'Delivery',
                        style: TextStyle(
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    DeliverySegmentedControll(
                      setDeliveryStatus: setDeliveryStatus,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                NotesTextfield(
                  controller: _notesController,
                  borderColor: appRed,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                restaurantController.addRestaurant(
                  _nameController.text,
                  int.parse(_timeController.text),
                  rating,
                  price,
                  doesDelivery,
                  _notesController.text,
                  false,
                );
                Navigator.pop(context);
              },
              child: Container(
                height: 60,
                width: 100,
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  color: appRed,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
