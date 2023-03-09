import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whats_for_dinner/utils/constants.dart';
import 'package:whats_for_dinner/views/widgets/app/border_button.dart';

import '../../../models/restaurant.dart';
import '../../../utils/colors.dart';
import '../../widgets/app/custom_textfield.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _orderTextController = TextEditingController();

  bool imageJustUploaded = false;

  bool isImageUploaded = false;

  @override
  void dispose() {
    super.dispose();
    _nameTextController.dispose();
    _orderTextController.dispose();
  }

  final data = Get.arguments as List;

  late Restaurant restaurant;
  late Function onSubmit;
  late Order newOrder;
  late bool isUpdate;
  late Order copyOrder;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restaurant = data[0];
    onSubmit = data[1];
    newOrder = data[2];
    isUpdate = data[3];
    _nameTextController.text = newOrder.name;
    _orderTextController.text = newOrder.item;
    if (isUpdate) {
      copyOrder = Order(name: newOrder.name, item: newOrder.item);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double screenHeight = mediaQuery.size.height;
    double screenWidth = mediaQuery.size.width;
    double height10 = screenHeight / 89.6;
    double height15 = screenHeight / 59.733;
    double height25 = screenHeight / 35.84;
    double height30 = screenHeight / 29.86;
    double height60 = screenHeight / 14.933;
    double width30 = screenWidth / 13.8;
    double width200 = screenWidth / 2.07;
    double fontSize18 = screenHeight / 49.777;
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: width30, right: width30, top: height30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: fontSize18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: CustomTextfield(
                icon: Icons.person,
                placeholderText: 'Name',
                controller: _nameTextController,
                borderColor: appRed,
                textfieldWidth: width200,
                textfieldHeight: height60,
                borderRadius: height10,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
            ),
            SizedBox(height: height15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order',
                style: TextStyle(
                  fontSize: fontSize18,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: CustomTextfield(
                icon: Icons.restaurant_menu_rounded,
                placeholderText: 'Order',
                controller: _orderTextController,
                borderColor: appRed,
                textfieldWidth: double.maxFinite,
                textfieldHeight: height60,
                borderRadius: height10,
                onSubmit: (_) {},
                onChanged: (_) {},
              ),
            ),
            SizedBox(height: height25),
            GestureDetector(
              onTap: () async {
                if (isUpdate) {
                  copyOrder.item = _orderTextController.text;
                  copyOrder.name = _nameTextController.text;
                  await restaurantController.editOrder(
                      restaurant, newOrder, copyOrder);
                } else {
                  newOrder.item = _orderTextController.text;
                  newOrder.name = _nameTextController.text;
                  await restaurantController.addOrder(restaurant, newOrder);
                }

                Navigator.pop(context);
                onSubmit();
              },
              child: BorderButton(
                buttonColor: appRed,
                buttonText: 'Submit',
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
