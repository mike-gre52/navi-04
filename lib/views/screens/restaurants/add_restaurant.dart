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

  bool doesDelivery = false;
  int rating = 1;
  int price = 3;

  Object _selectedSegment = 0;
  bool isInvalidNumber = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _timeController.dispose();
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

  void validateInput(input) {
    if (input != null) {
      if (input == '') {
        setState(() {
          isInvalidNumber = false;
        });
      } else {
        int? num = int.tryParse(input);
        if (num != null) {
          setState(() {
            isInvalidNumber = false;
          });
        } else {
          setState(() {
            isInvalidNumber = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height5 = screenHeight / 179.2;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height20 = screenHeight / 44.8;
    double height30 = screenHeight / 29.86;
    double height50 = screenHeight / 17.92;
    double height60 = screenHeight / 14.933;
    double height65 = screenHeight / 13.784;
    double width5 = screenWidth / 82.8;
    double width30 = screenWidth / 13.8;
    double width100 = screenWidth / 4.14;
    double width350 = screenWidth / 1.182;
    double fontSize18 = screenHeight / 49.777;
    double fontSize20 = screenHeight / 44.8;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(
              headerText: 'Add Restaurant',
              headerColor: appRed,
              borderColor: royalYellow,
              textColor: Colors.white,
              dividerColor: Colors.white,
              rightAction: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onIconClick: () {
                Navigator.pop(context);
              },
            ),
            //NEED TO MAKE SURE TIME IS A NUMBER - WILL SET THE KEYBOARD TO NUMPAD BUT STILL NEED TO VERIFY
            Container(
              margin: EdgeInsets.only(left: width30, top: width30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: height5),
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: fontSize18,
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
                      textfieldWidth: width350,
                      textfieldHeight: height65,
                      borderRadius: height10,
                      onSubmit: (_) {},
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width5, top: height30),
                        child: Text(
                          'Time',
                          style: TextStyle(
                              fontSize: fontSize18,
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
                          textfieldWidth: width100,
                          showIcon: false,
                          textfieldHeight: height50,
                          borderRadius: height10,
                          onSubmit: (_) {},
                          onChanged: validateInput,
                          keyboard: TextInputType.number,
                        ),
                      ),
                      isInvalidNumber
                          ? Container(
                              height: height20,
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Must be a number',
                                style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(
                              height: height20,
                            ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width5, top: height30),
                        child: Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: fontSize18,
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
              margin: EdgeInsets.symmetric(horizontal: height30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width5, top: height30),
                        child: Text(
                          'Price',
                          style: TextStyle(
                              fontSize: fontSize18,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      PriceSegmentedControll(
                        setPriceStatus: setPriceStatus,
                        initialValue: 3,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width5, top: height30),
                        child: Text(
                          'Delivery',
                          style: TextStyle(
                              fontSize: fontSize18,
                              color: black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      DeliverySegmentedControll(
                        setDeliveryStatus: setDeliveryStatus,
                        initialValue: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height15),
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
                    false,
                    "",
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  height: height60,
                  width: width100,
                  margin: EdgeInsets.only(
                    top: height30,
                  ),
                  decoration: BoxDecoration(
                    color: appRed,
                    borderRadius: BorderRadius.circular(height15),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontSize: fontSize18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
