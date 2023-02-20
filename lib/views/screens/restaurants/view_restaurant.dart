import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/models/restaurant.dart';
import 'package:whats_for_dinner/utils/colors.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/app_header.dart';
import 'package:whats_for_dinner/views/widgets/app/custom_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/notes_textfield.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/delivery_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/price_segmented_control.dart';
import 'package:whats_for_dinner/views/widgets/restaurants/select_rating.dart';

class ViewRestaurant extends StatefulWidget {
  const ViewRestaurant({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewRestaurant> createState() => _ViewRestaurantState();
}

class _ViewRestaurantState extends State<ViewRestaurant> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  final data = Get.arguments as List;
  late Restaurant restaurant;
  late Function onSubmit;

  bool doesDelivery = false;
  int rating = 1;
  int price = 3;

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
    print(price);
  }

  void newRatingSelected(newValue) {
    setState(() {
      rating = newValue + 1;
    });
  }

  @override
  void initState() {
    restaurant = data[0];
    onSubmit = data[1];
    _nameController.text = restaurant.name;
    _timeController.text = restaurant.time.toString();
    rating = restaurant.rating;
    setDeliveryStatus(restaurant.doesDelivery);
    setPriceStatus(restaurant.price);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            headerText:
                restaurant.name[0].toUpperCase() + restaurant.name.substring(1),
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
            margin: const EdgeInsets.only(left: 30, top: 30),
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
                    onSubmit: (_) {},
                    onChanged: (_) {},
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
                      margin: const EdgeInsets.only(left: 5, top: 30),
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
                        onSubmit: (_) {},
                        onChanged: (_) {},
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
                      isTapable: true,
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
                      initialValue: restaurant.price,
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
                      initialValue: restaurant.doesDelivery ? 0 : 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                Restaurant updatedRestaurant = Restaurant(
                  name: _nameController.text,
                  time: int.parse(_timeController.text),
                  rating: rating,
                  price: price,
                  doesDelivery: doesDelivery,
                  isFavorite: restaurant.isFavorite,
                  id: restaurant.id,
                  restaurantUrl: restaurant.restaurantUrl,
                  orders: restaurant.orders,
                );

                await restaurantController.updateRestaurant(updatedRestaurant);
                Navigator.pop(context);
                onSubmit(updatedRestaurant);
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
                    'Update',
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
